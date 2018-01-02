

(defun void-dollar-symbol ()
  (interactive)
  (progn
    (read-only-mode -1)
    (beginning-of-buffer)
    (while (search-forward "$" nil t)
      (replace-match " "))
    )
  )
