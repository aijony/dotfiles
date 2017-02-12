;;; config.el --- better-auto-completion layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2016 Sylvain Benner & Contributors
;;
;; Author:  <aidan@excli>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3



;;Build directory settings





(setq flycheck-check-syntax-automatically '(mode-enabled new-line))


;;Thanks to git hub user Paulo Costa @pcesar22 All calls to
;;perl-mode now use cperl-mode
(defalias 'perl-mode 'cperl-mode)
;;Cperl mode hook enables company auto complete and fixes issue
;;with cperl-electric and smart-parens
(add-hook 'cperl-mode-hook
          #'company-mode
          (lambda () (local-unset-key (kbd "{")))
          )



;;YCMD

;;Safe command for .dir-locals.el
(put 'helm-make-build-dir 'safe-local-variable 'stringp)

;;Default build directory
(setq build-dir '"build")
(setq-default helm-make-build-dir build-dir)

;;Auto-Completion

(set-variable 'ycmd-server-command '("python" "~/.ycmd/ycmd/ycmd/ycmd"))
(set-variable 'ycmd-extra-conf-handler 'load)
(setq ycmd-generate-command '"~/.ycmd/YCM-Generator/config_gen.py")

(evil-leader/set-key "f i" 'my-insert-file-name)

