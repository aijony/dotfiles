
(spacemacs/set-leader-keys-for-major-mode
  'eshell-mode "h" 'spacemacs/helm-eshell-history)

(spacemacs/set-leader-keys-for-major-mode
  'eshell-mode "c" 'spacemacs/eshell-clear-keystroke)

(defun eshell/set-keys ()
  (local-set-key (kbd "<tab>")
                 'helm-esh-pcomplete)
  (local-set-key (kbd "C-l")
                 'spacemacs/eshell-clear-keystroke)
  (evil-define-key 'insert
    eshell-mode-map
    (kbd "<tab>")
    'helm-esh-pcomplete))


(add-hook 'eshell-mode-hook 'eshell/set-keys)
