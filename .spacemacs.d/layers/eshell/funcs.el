(defun eshell-here ()
  (interactive)
  (let* ((parent (if (buffer-file-name)
                     (file-name-directory (buffer-file-name))
                   default-directory))
         (height (/ (window-total-height)
                    3))
         (name (car (last (split-string parent "/" t)))))
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


(defun eshell/set-path (path-input)
  ;;Preferred input is "~/location" for home directory
  (let ((path (file-truename path-input)))
    (setq eshell-path-env (concat path ":" eshell-path-env))
    (setenv ""PATH
            (concat path
                    ":"
                    (getenv "PATH")))
    (add-to-list 'exec-path
                 (concat path "/"))))

