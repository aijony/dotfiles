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


(setq better-auto-completion-packages '())





(defun better-auto-completion-packages/post-init-auto-completion ()
  (use-package company-ycmd
    ;;Set company behavior
    (let ((map company-active-map))
      (define-key map (kbd "RET") 'company-complete-selection)
      (define-key map (kbd "tab") 'nil)))
  )

(defun better-auto-completion-packages/post-init-syntax-checking ()
  (use-package flycheck-ycmd
    ;;Help artifacts when using terminal mode
    (when (not (display-graphic-p))
      (setq flycheck-indication-mode nil)))
  )

;;; packages.el ends here
