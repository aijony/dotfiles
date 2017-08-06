
;;Set path for stack
(add-hook 'eshell-mode-hook '(lambda ()
                               (eshell/set-path "~/.local/bin")
                               (setenv "LEDGER_FILE" (file-truename "~/finance/hledger.journal"))
                               ))



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


  (remove-hook 'eshell-mode-hook 'spacemacs//eshell-switch-company-frontend)
  (add-hook 'eshell-mode-hook 'spacemacs//eshell-switch-company-frontend t)
)

