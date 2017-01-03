;;; packages.el --- writing layer packages file for Spacemacs.
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
;; added to `writing-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `writing/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `writing/pre-init-PACKAGE' and/or
;;   `writing/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:
(setq writing-packages
      '(
        writegood-mode
        synonyms
        ))

(defun writing/init-writegood-mode ()
  (use-package writegood-mode)
  )
(defun writing/init-synonyms ()
  (use-package synonyms
  :init
  (setq synonyms-file ".spacemacs.d/private/resources/mthesaur.txt")
  (setq synonyms-cache-file ".spacemacs.d/private/resources/mthesaur.txt.cache")
  )
  )

;;packages.el ends here
