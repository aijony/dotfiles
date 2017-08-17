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

(setq orxtended-packages '(org-plus-contrib
                           org-gcal
                           (org-protocol :location built-in)
                           (ob-latex :location built-in)
                           (ox-extra :location local)))

;; For each extension, define a function orxtended/init-<extension-orxtended>
;;
(defun orxtended/init-ox-extra ()
  (use-package ox-extra
    :config
    ;; TODO Verify keybindings
    (ox-extras-activate '(ignore-headlines))))

(defun orxtended/init-org-gcal ()
  "Initialize org-gcal"
  (use-package org-gcal
    :defer t
    :commands (org-gcal-sync
               org-gcal-fetch
               org-gcal-post-at-point
               org-gcal-refresh-token
               org-gcal-delete-at-point)
    :config
    (setq org-gcal-down-days '365)

    (add-hook 'org-agenda-mode-hook (lambda () (org-gcal-sync)))
    (add-hook 'org-capture-after-finalize-hook (lambda () (org-gcal-sync)))
    ))

(defun orxtended/init-ob-latex ()
  (use-package ob-latex
    :defer t))

(defun orxtended/post-init-org-plus-contrib ()

  (add-hook 'pdf-view-mode-hook 'pdf-view-midnight-minor-mode)

  (add-hook 'LaTeX-mode-hook 'turn-on-reftex)

  (setq org-treat-S-cursor-todo-selection-as-state-change nil)

  ;; Show images after evaluating code blocks.
  (setq org-startup-with-inline-images t)

  (add-hook 'org-babel-after-execute-hook 'orxtended/after-babel)

  (setq org-startup-with-latex-preview t)

  (setq org-latex-listings t)

  (setq org-preview-latex-default-process 'imagemagick)

  (setq org-tags-column 0)

  ;; Not sure what this did, but it doesn't work...
  ;;(add-hook 'org-mode-hook 'turn-on-org-cdlatex)

  ;; Show images when opening a file.
  (setq org-latex-create-formula-image-program
        'dvipng)
  ;; Do not confirm before evaluation
  (setq org-confirm-babel-evaluate nil)

  (setq org-refile-use-outline-path 'file)

  (setq org-outline-path-complete-in-steps nil)

  (setq org-refile-allow-creating-parent-nodes 'confirm)



  ;; Do not evaluate code blocks when exporting.
  (setq org-export-babel-evaluate nil)



  (spacemacs/set-leader-keys-for-major-mode 'org-mode
    "s R" 'orxtended/org-refile-to-datetree
    "s a" 'org-archive-to-archive-sibling
    )
 )

(defun orxtended/init-org-protocol ()
  (use-package org-protocol
    :defer t
    :commands (org-protocol-capture org-protocol-create) ;; this adds autoloads
    :init
    (evil-leader/set-key-for-mode 'org-mode
      "mp" 'org-protocol-capture)))




;;; packages.el ends here
