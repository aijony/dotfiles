(setq org-reveal-root "file:///home/aidan/.spacemacs.d/private/resources/reveal-js")

(setq org-tags-column 0)

(org-babel-do-load-languages 'org-babel-load-languages
                             '((C . t)
                               (java . t)))


(add-hook 'pdf-view-mode-hook 'pdf-view-midnight-minor-mode)

(defun org-remove-headlines (backend)
  "Remove headlines with :no_title: tag."
  (org-map-entries (lambda () (let ((beg (point)))
                                (outline-next-visible-heading 1)
                                (backward-char)
                                (delete-region beg (point))))
                   "no_export" tree)
  (org-map-entries (lambda () (delete-region (point-at-bol) (point-at-eol)))
                   "no_title"))

(add-hook 'org-export-before-processing-hook #'org-remove-headlines)
