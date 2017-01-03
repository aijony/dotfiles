;;; packages.el --- reveal layer packages file for Spacemacs.
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
;; added to `reveal-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `reveal/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `reveal/pre-init-PACKAGE' and/or
;;   `reveal/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:
(eval-when-compile
  (require 'use-package nil t))

(defconst reveal-packages '(ox-reveal))

(defun reveal/init-ox-reveal ()
  (use-package ox-reveal
    :config

    (setq org-reveal-root "file:///home/aidan/.spacemacs.d/private/resources/reveal-js")
    )
  )


;;; packages.el ends here
