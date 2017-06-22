
;;Set path for stack
(add-hook 'eshell-mode-hook '(lambda ()
                               (eshell/set-path "~/.local/bin")))
