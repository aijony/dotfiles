;;; packages.el --- ox-extra layer packages file for Spacemacs.
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
;; added to `ox-extra-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `ox-extra/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `ox-extra/pre-init-PACKAGE' and/or
;;   `ox-extra/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:

 (defvar ox-extra-pre-extensions
    '(
      ;; pre extension ox-extras go here
      ox-extra
      )
    )

  (defvar ox-extra-post-extensions
    '(
      
      )
    )
  ;; For each extension, define a function ox-extra/init-<extension-ox-extra>
  ;;
  (defun ox-extra/init-ox-extra ()
    (use-package ox-extra
      :config
      (ox-extras-activate '(ignore-headlines))
      (setq evil-escape-key-sequence "kj")
      )
)
;;; packages.el ends here
