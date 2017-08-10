
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


(setq org-notmuch-tag-whitelist 'nil)
(setq org-notmuch-tag-blacklist '("inbox" "unread" "attachment"))
(setq org-notmuch-conversion '(("flagged" . "important") ("test" . "tested")))
(setq org-notmuch-email-link "notmuch:id:")
(setq org-notmuch-search-link "notmuch-search")
(setq org-notmuch-email-regexp "[=+_.~a-zA-Z0-9]*[-+_.~:a-zA-Z0-9]*@[-.a-zA-Z0-9]+")
(setq org-notmuch-tag-regexp "[a-zA-Z0-9]")

(defun org-notmuch/tag-emails ()
  (interactive)
  ;; Get notmuch id
  (let* ((ids (org-notmuch/get-ids org-notmuch-email-link org-notmuch-email-regexp))
         (tags (apply 'append (mapcar 'org-notmuch/id-to-tags ids)))
    (concat-tags (delete-dups (append (org-notmuch/check-lists tags) (org-get-tags))))
    (temp)
    (output-tags (dolist (tag concat-tags temp)
                   (setq temp (concat temp tag ":")))))
  (org-set-tags-to output-tags)))

(defun org-notmuch/check-lists (tags)
  (delete nil
          (mapcar
           (lambda (tag)
             (cond
              ((member tag org-notmuch-tag-blacklist) 'nil)
              ((not (or
                     (member tag org-notmuch-tag-whitelist)
                     (eq org-notmuch-tag-whitelist 'nil)))
               'nil)
              ((assoc tag org-notmuch-conversion)
               (cdr (assoc tag org-notmuch-conversion)))
              ('t tag)))
           tags)))

(defun org-notmuch/get-ids (regexp-link regexp-identifier)
  (let* (
         (notmuch-emails '())
         (pos (point))
         (begin (org-element-property :begin (org-element-at-point)))
         (end (org-element-property :end (org-element-at-point))))
    (goto-char begin)
    (while (re-search-forward regexp-link end 't)
      (looking-at regexp-identifier)
      (push (match-string 0) notmuch-emails))
    (goto-char pos)
    ;;return
    notmuch-emails))

(defun org-notmuch/id-to-tags (id)
  (split-string (shell-command-to-string
                 (concat "notmuch search --output:tags id:" id))))


