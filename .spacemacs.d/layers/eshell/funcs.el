
(with-eval-after-load 'eshell
  ;; This is an eshell alias
  (defun eshell/clear ()
    (let ((inhibit-read-only t))
      (erase-buffer)))
  ;; This is a key-command
  (defun spacemacs/eshell-clear-keystroke ()
    "Allow for keystrokes to invoke eshell/clear"
    (interactive)
    (eshell/clear)
    (eshell-send-input))
  )

(defun eshell-here ()
  (interactive)
  (let* ((parent (if (buffer-file-name)
                     (file-name-directory (buffer-file-name))
                   default-directory))
         (height (/ (window-total-height) 3))
         (name   (car (last (split-string parent "/" t)))))
    (split-window-vertically (- height))
    (other-window 1)
    (eshell "new")
    (rename-buffer (concat "*eshell: " name "*"))

    (insert (concat "ls"))
    (eshell-send-input)))


(defun eshell/x ()
  (insert "exit")
  (eshell-send-input)
  (delete-window))
