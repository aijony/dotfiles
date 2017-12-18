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


;;Hides python error message occurring in org snippets

;;Flycheck

;;de-pop-up-ify Flycheck
(add-hook 'flycheck-mode-hook (lambda ()
(if (eq flycheck-pos-tip-mode t)
    (flycheck-pos-tip-mode 'toggle))))

;;Build directory settings

(setq flycheck-check-syntax-automatically '(mode-enabled new-line))


;;Thanks to git hub user Paulo Costa @pcesar22 All calls to
;;perl-mode now use cperl-mode
(defalias 'perl-mode 'cperl-mode)
;;Cperl mode hook enables company auto complete and fixes issue
;;with cperl-electric and smart-parens
(add-hook 'cperl-mode-hook
          #'company-mode
          (lambda ()
            (local-unset-key (kbd "{"))))

;; Haskell


(setq haskell-program-name "stack exec intero")


;; YCMD

;; (add-hook 'after-init-hook #'global-ycmd-mode)

;;Safe command for .dir-locals.el
(put 'helm-make-build-dir 'safe-local-variable
     'stringp)

;;Default build directory
(setq build-dir '"build")
(setq-default helm-make-build-dir build-dir)

;;Auto-Completion
(setq ycmd-dir (file-truename '"~/.ycmd/ycmd/ycmd/"))
(setq word-python "python")

(defun my-eval-string (string)
  (car (read-from-string string)))

(setq to-command (my-eval-string (concat "(\"" word-python "\" \"" ycmd-dir
                                         "\")")))

(set-variable 'ycmd-server-command to-command)

(set-variable 'ycmd-extra-conf-handler 'load)
(setq ycmd-generate-command '"~/.ycmd/YCM-Generator/config_gen.py")

(evil-leader/set-key "f i" 'my-insert-file-name)

;; YCMD ENDS

;;Prevent parsing hold-u
;; (eval-after-load 'semantic
;;   (add-hook 'semantic-mode-hook
;;             (lambda ()
;;               (dolist (x (default-value 'completion-at-point-functions))
;;                 (when (string-prefix-p "semantic-"
;;                                        (symbol-name x))
;;                   (remove-hook 'completion-at-point-functions
;;                                x))))))

(setq ycmd-force-semantic-completion t)


