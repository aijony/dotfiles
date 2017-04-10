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
;;;;; packages.el --- ox-extra layer packages file for Spacemacs.
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
;; added to `orxtended-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `orxtended/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `orxtended/pre-init-PACKAGE' and/or
;;   `orxtended/post-init-PACKAGE' to customize the package as it is loaded.

(setq orxtended-packages '((ox-extra :location local)))

;; For each extension, define a function orxtended/init-<extension-orxtended>
;;
(defun orxtended/init-ox-extra ()
  (use-package ox-extra
    :config (ox-extras-activate '(ignore-headlines))))

(defun orxtended/post-init-org-mode ()
  (require 'ob-latex)
  (setq org-tags-column 0)
  ;; Show images when opening a file.
  (add-hook 'org-mode-hook 'turn-on-org-cdlatex)
  (setq org-latex-create-formula-image-program
        'dvipng)
  ;; Do not confirm before evaluation
  (setq org-confirm-babel-evaluate nil)
  ;; Do not evaluate code blocks when exporting.
  (setq org-export-babel-evaluate nil))




;;; packages.el ends here
