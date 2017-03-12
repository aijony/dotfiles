
(spacemacs/set-leader-keys-for-major-mode 'eshell-mode
  "h" 'spacemacs/helm-eshell-history)

(spacemacs/set-leader-keys-for-major-mode 'eshell-mode
  "c" 'eshell/clear)

(eval-after-load 'eshell
  '(define-key eshell-mode-map (kbd "<tab>") 'helm-esh-pcomplete))

(evil-define-key 'insert eshell-mode-map
  (kbd "<tab>") 'helm-esh-pcomplete
  )



