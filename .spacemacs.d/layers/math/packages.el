;;; packages.el --- sagemath layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2016 Sylvain Benner & Contributors
;;
;; Author: Alejandro Erickson <alejo@alejandro.home>
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
;; added to `math-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `math/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `math/pre-init-PACKAGE' and/or
;;   `math/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:

(defconst math-packages
  '(
    sage-shell-mode
    auto-complete-sage
    helm-sage
    ob-sagemath
    (calc :location built-in)
    ;; sage-shell-mode contains a copy of sage(-mode).
    ;; If it breaks, then enabling this is your backup plan.
    ;; (sage :location (recipe
    ;;                       :fetcher bitbucket
    ;;                       :repo "gvol/sage-mode"
    ;;                       :files ("emacs/*")))
    )
  )

(defun math/init-ob-sagemath()
  (use-package ob-sagemath
     :defer t
     :config
     ;; Ob-sagemath supports only evaluating with a session.
     (setq org-babel-default-header-args:sage '((:session . t)
                                                (:results . "output")))

     ))

(defun math/post-init-org-mode ()
  (define-key org-mode-map (kbd "C-c c") 'ob-math-execute-async))

(defun math/init-helm-sage()
  (use-package helm-sage
    :defer t))

(defun math/init-auto-complete-sage ()
  (use-package auto-complete-sage
    :defer t))


(defun math/init-sage-shell-mode ()
  (use-package sage-shell-mode
    :defer t
    :config

    (progn
    (add-hook 'sage-shell-after-prompt-hook #'sage-shell-view-mode)
    (setq sage-shell:use-prompt-toolkit nil)
    ;; Run SageMath by M-x run-sage instead of M-x sage-shell:run-sage
    (sage-shell:define-alias)

    ;; Turn on eldoc-mode in Sage terminal and in Sage source files
    (add-hook 'sage-shell-mode-hook #'eldoc-mode)
    (add-hook 'sage-shell:sage-mode-hook #'eldoc-mode)
      ;;TODO M-n and M-p to jk. The major-mode of the Sage process buffer is
      ;;sage-shell-mode
      (spacemacs/set-leader-keys-for-major-mode 'sage-shell-mode
        "c" 'sage-shell:interrupt-subjob
        "o" 'sage-shell:delete-output
        "O" 'sage-shell:clear-current-buffer
        "l" 'sage-shell:load-file
        "?" 'sage-shell:help
        "b" 'sage-shell:list-outputs
        "w" 'sage-shell:copy-previous-output-to-kill-ring
        "hh" 'helm-sage-complete
        )

      ;; (evil-define-key 'insert 'sage-shell-mode-map (kbd "tab") 'helm-sage-complete)
      ;; Enable setting of executable
      (setq sage-shell:completion-function 'helm-sage)
      (spacemacs/set-leader-keys-for-major-mode 'sage-shell:sage-mode
        "s" 'sage-shell:run-sage
        "S" 'sage-shell:run-new-sage
        )
      ;; is this working?
      (setq fold-dir "vimish-fold/")
      (setq cache-dir . (spacemacs-cache-directory))
      (setq sage-shell:input-history-chache-file (concat cache-dir fold-dir))

      )
    )
  )

;; sage-shell-mode contains a copy of sage(-mode).
;; If it breaks, then enabling this is your backup plan.
;;(defun math/init-sage ()
  ;; (use-package sage
  ;;   :defer t
;; :config
;; (add-hook 'sage-shell:sage-mode-hook 'ac-sage-setup)
;; (add-hook 'sage-shell-mode-hook 'ac-sage-setup)
  ;;   )
  ;; )

;; sage-shell-mode can be extended with auto-complete as well, if you don't like helm
;; (defun math/init-auto-complete-sage ()
;;   (use-package auto-complete-sage)
;;   :defer t
;;   :config
;;   (progn
;;     ;;(setq sage-shell:completion-function 'completion-at-point)
;;     )
;;   )

(defun math/init-helm-sage ()
  (use-package helm-sage
    :defer t
    ))

(defun math/init-calc ()
  (use-package calc
    :commands calc
    :defer t
    :config
    (calc-eval "2+2")
    (define-key calc-mode-map "kj" 'evil-escape)))
;;ob-sagemath

;;; packages.el ends here
