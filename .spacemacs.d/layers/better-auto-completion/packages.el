;;; packages.el --- better-auto-completion layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2016 Sylvain Benner & Contributors
;;
;; Author:  <aidan@excli>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

;;; Commentary:

;; See the Spacemacs documentation and FAQs for instructions on how to implement
;; a new layer:
;;
;;   SPC h SPC layers RET
;;
;;
;; Briefly, each package to be installed or configured by this layer should be
;; added to `better-auto-completion-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `better-auto-completion/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `better-auto-completion/pre-init-PACKAGE' and/or
;;   `better-auto-completion/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:


(setq better-auto-completion-packages '(
                                        company-ycmd
                                        flycheck-ycmd
                                        yasnippet
                                        ))

(defun better-auto-completion/post-init-company-ycmd ()
    (company-ycmd-setup)

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

    (setq ycmd-startup-timeout 20)

    ;; (setq ycmd-extra-conf-whitelist '("~/*"))

    (set-variable 'ycmd-server-command (list "python" "-u" (file-truename '"~/.ycmd/ycmd/ycmd/")))

    (set-variable 'ycmd-extra-conf-handler 'load)
    (setq ycmd-generate-command '"~/.ycmd/YCM-Generator/config_gen.py")

    (evil-leader/set-key "f i" 'my-insert-file-name)

    ;; YCMD ENDS

    ;;Hides python error message occurring in org snippets
    ;;Prevent parsing hold-u
    ;; (eval-after-load 'semantic
    ;;   (add-hook 'semantic-mode-hook
    ;;             (lambda ()
    ;;               (dolist (x (default-value 'completion-at-point-functions))
    ;;                 (when (string-prefix-p "semantic-"
    ;;                                        (symbol-name x))
    ;;                   (remove-hook 'completion-at-point-functions
    ;;                                x))))))

    (setq ycmd-force-semantic-completion t))


(defun better-auto-completion/post-init-flycheck-ycmd ()

    ;;Help artifacts when using terminal mode
    (when (not (display-graphic-p))
      (setq flycheck-indication-mode nil))
    ;;de-pop-up-ify Flycheck
    (add-hook 'flycheck-mode-hook (lambda ()
                                    (if (eq flycheck-pos-tip-mode t)
                                        (flycheck-pos-tip-mode 'toggle))))

    ;;Build directory settings
    )

(defun better-auto-completion/post-init-yasnippet ()
  (spacemacs/toggle-yasnippet-on)
  (add-to-list 'yas-snippet-dirs (expand-file-name "~/.spacemacs.d/snippets"))
  )
;;; packages.el ends here
