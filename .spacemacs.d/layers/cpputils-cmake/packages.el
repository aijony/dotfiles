;;; packages.el --- cpputils-cmake layer packages file for Spacemacs.
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
;; added to `cpputils-cmake-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `cpputils-cmake/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `cpputils-cmake/pre-init-PACKAGE' and/or
;;   `cpputils-cmake/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:



 
(setq cpputils-cmake-packages
       '(
         ;;Get the package from MELPA, ELPA, etc.
         cpputils-cmake
         (add-to-list 'auto-mode-alist '("\\CMake\\'" . cmake-mode))
        ))
;;; packages.el ends here
