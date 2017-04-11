
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
  (org-display-inline-images)

)


