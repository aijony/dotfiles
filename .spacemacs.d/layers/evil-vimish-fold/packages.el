;;; packages.el --- evil-vimish-fold layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2017 Sylvain Benner & Contributors
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
;; added to `evil-vimish-fold-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `evil-vimish-fold/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `evil-vimish-fold/pre-init-PACKAGE' and/or
;;   `evil-vimish-fold/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:

(setq evil-vimish-fold-packages
      '(evil-vimish-fold))

(defun evil-vimish-fold/init-evil-vimish-fold ()
  (use-package evil-vimish-fold
    :config
     (setq evil-vimish-fold-mode 1)
     (setq fold-dir "vimish-fold/")
     (setq cache-dir . (spacemacs-cache-directory))
     (setq vimish-fold-dir (concat cache-dir fold-dir))

     ))

;;; packages.el ends here
