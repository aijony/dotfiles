
(defadvice org-export-output-file-name (before org-add-export-dir activate)
  "Modifies org-export to place exported files in a different directory
https://emacs.stackexchange.com/questions/3985/make-org-mode-export-to-beamer-keep-temporary-files-out-of-the-current-directory"
  (when (not pub-dir)
    (setq pub-dir org-export-output-directory-prefix)
    (when (not (file-directory-p pub-dir))
      (make-directory pub-dir))))


(defun orxtended/transparentize ()
  (interactive)
  (if (not (string-match "ImageMagick" (shell-command-to-string "convert -version")))
      (error "Missing ImageMagick")
    (let ((to-change (directory-files default-directory nil "\\T.png$")))
      (while to-change
        (let* ((file (car to-change))
               (command (concat "convert " file " -fuzz 10% -transparent white "
                                file)))
          (shell-command-to-string command))
        (setq to-change (cdr to-change))))))

(defun orxtended/after-babel ()
  (interactive)
  '(orxtended/transparentize)
  (org-preview-latex-fragment)
  (org-display-inline-images))

(defun orxtended/org-refile-to-datetree (&optional file)
  "Refile a subtree to a datetree corresponding to it's timestamp.

The current time is used if the entry has no timestamp. If FILE
is nil, refile in the current file."
  (interactive "f")
  (let* ((datetree-date (or (org-entry-get nil "TIMESTAMP" t)
                            (org-read-date t nil "now")))
         (date (org-date-to-gregorian datetree-date))
         )
    (save-excursion
      (with-current-buffer (current-buffer)
        (org-cut-subtree)
        (if file (find-file file))
        (org-datetree-find-date-create date)
        (org-narrow-to-subtree)
        (show-subtree)
        (org-end-of-subtree t)
        (newline)
        (goto-char (point-max))
        (org-paste-subtree 4)
        (widen)
        ))
    )
  )


;;; https://emacs.stackexchange.com/questions/3280/orgmode-insert-link-from-clipboard

(defun orxtended/insert-url-as-org-link-sparse ()
  "If there's a URL on the clipboard, insert it as an org-mode
link in the form of [[url]]."
  (interactive)
  (let ((link (substring-no-properties (x-get-selection 'CLIPBOARD)))
        (url  "\\(http[s]?://\\|www\\.\\)"))
    (save-match-data
      (if (string-match url link)
          (insert (concat "[[" link "]]"))
        (error "No URL on the clipboard")))))

(defun orxtended/insert-url-as-org-link-fancy ()
  "If there's a URL on the clipboard, insert it as an org-mode
link in the form of [[url][*]], and leave point at *."
  (interactive)
  (let ((link (substring-no-properties (x-get-selection 'CLIPBOARD)))
        (url  "\\(http[s]?://\\|www\\.\\)"))
    (save-match-data
      (if (string-match url link)
          (progn
            (insert (concat "[[" link "][]]"))
            (backward-char 2))
        (error "No URL on the clipboard")))))


(setq org-notmuch-tag-whitelist 'nil)
(setq org-notmuch-tag-blacklist '("inbox" "unread" "attachment"))
(setq org-notmuch-conversion '(("flagged" . "important") ("test" . "tested")))
(setq org-notmuch-email-link "notmuch:id:")
(setq org-notmuch-email-regexp "[=+_.~a-zA-Z0-9]*[-+_.~:a-zA-Z0-9]*@[-.a-zA-Z0-9]+")

(defun org-notmuch/tag-emails ()
  (interactive)
  (cl-flet* (
             (check-lists (tags)
                          (delete nil
                                  (mapcar (lambda (tag)
                                            (cond
                                             ((member tag org-notmuch-tag-blacklist) 'nil)
                                             ((not (or (member tag org-notmuch-tag-whitelist)
                                                       (eq org-notmuch-tag-whitelist 'nil))) 'nil)
                                             ((assoc tag org-notmuch-conversion)
                                              (cdr (assoc tag org-notmuch-conversion)))
                                             ('t tag)))
                                          tags)))

             ;; Gets the notmuch ids in the org-mode section's links
             (get-ids (regexp-link regexp-identifier)
                      (let* ((notmuch-emails '())
                             (pos (point))
                             (begin (org-element-property :begin (org-element-at-point)))
                             (end (org-element-property :end (org-element-at-point))))
                        (goto-char begin)
                        (while (re-search-forward regexp-link end 't)
                          (looking-at regexp-identifier)
                          (push (match-string 0)
                                notmuch-emails))
                        (goto-char pos)
                        ;;return
                        notmuch-emails))

             ;; ":open-source:" is not a valid tag, so this converts it to "opensource"
             (clean-tags (tags)
                         (mapcar (lambda (tag)
                                   (apply #'concat
                                          (s-split-words tag)))
                                 tags))

             ;; Converts notmuch email ids to notmuch tags
             (ids-to-tags (ids)
                          (apply 'append
                                 (mapcar (lambda (id)
                                           (split-string (shell-command-to-string
                                                          (concat "notmuch search --output:tags id:"
                                                                  id))))
                                         ids))))

    (let* ((ids (get-ids org-notmuch-email-link org-notmuch-email-regexp))
           (tags (ids-to-tags ids))
           (concat-tags (delete-dups (clean-tags (append (check-lists tags)
                                                         (org-get-tags)))))
           (temp)
           (output-tags (dolist (tag concat-tags temp)
                          (setq temp (concat temp tag ":")))))
      (org-set-tags-to output-tags))))
