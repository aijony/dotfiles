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

(setq orxtended-packages '(
                           (org :location built-in)
                           org-gcal
                           org-cliplink
                           (org-protocol :location built-in)
                           (org-crypt :location built-in)
                           (ob-latex :location built-in)
                           (ox-manuscript :location local)
                           (ox-extra :location local)))

;; For each extension, define a function orxtended/init-<extension-orxtended>
;;
(defun orxtended/init-ox-extra ()
  (use-package ox-extra
    :config
    ;; TODO Verify keybindings
    (ox-extras-activate '(ignore-headlines))


    ;; * Journal templates
    ;; Bare-bones template
    (add-to-list 'org-latex-classes
                 '("no-article"
                   "\\documentclass{article}
                   [NO-DEFAULT-PACKAGES]
                   [PACKAGES]
                   [EXTRA]"
                   ("\\section{%s}" . "\\section*{%s}")
                   ("\\subsection{%s}" . "\\subsection*a{%s}")
                   ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                   ("\\paragraph{%s}" . "\\paragraph*{%s}")
                   ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))
    (add-to-list 'org-latex-classes
                 '("amsmath"
                   "\\documentclass{amsmath}
                   [NO-DEFAULT-PACKAGES]
                   [PACKAGES]
                   [EXTRA]"
                   ("\\section{%s}" . "\\section*{%s}")
                   ("\\subsection{%s}" . "\\subsection*a{%s}")
                   ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                   ("\\paragraph{%s}" . "\\paragraph*{%s}")
                   ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))

    ;; ** <<APS journals>>
    (add-to-list 'org-latex-classes '("revtex4-1"
                                      "\\documentclass{revtex4-1}
                                      [NO-DEFAULT-PACKAGES]
                                      [PACKAGES]
                                      [EXTRA]"
                                      ("\\section{%s}" . "\\section*{%s}")
                                      ("\\subsection{%s}" . "\\subsection*{%s}")
                                      ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                                      ("\\paragraph{%s}" . "\\paragraph*{%s}")
                                      ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))

    ;; ** <<APA journals>>
    (add-to-list 'org-latex-classes '("apa6"
                                      "\\documentclass{apa6}
                                      [NO-DEFAULT-PACKAGES]
                                      [PACKAGES]
                                      [EXTRA]"
                                      ("\\section{%s}" . "\\section*{%s}")
                                      ("\\subsection{%s}" . "\\subsection*{%s}")
                                      ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                                      ("\\paragraph{%s}" . "\\paragraph*{%s}")
                                      ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))
    ))


(defun orxtended/init-org-cliplink ()
  (use-package org-cliplink)
  (spacemacs/set-leader-keys-for-major-mode 'org-mode
    "i L" 'orxtended/insert-url-as-org-link-fancy)
  )

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

(defun orxtended/post-init-org ()

  ;; Latex Preview Packages
  ;; Woo category theory

  (add-to-list 'org-latex-packages-alist '("" "tikz-cd" nil))
  (add-to-list 'org-latex-packages-alist '("outputdir=export" "minted"))

  (setq org-latex-listings 'minted) 


  (plist-put org-format-latex-options :scale 1.35)

  ;; Hooks
  (add-hook 'pdf-view-mode-hook 'pdf-view-midnight-minor-mode)
  (add-hook 'LaTeX-mode-hook 'turn-on-reftex)
  (add-hook 'org-babel-after-execute-hook 'orxtended/after-babel)
  ;; Not sure what this did, but it doesn't work...
  ;; (add-hook 'org-mode-hook 'turn-on-org-cdlatex)

  (setq org-treat-S-cursor-todo-selection-as-state-change nil)

  ;; Org Startup
  (setq org-startup-with-latex-preview t
        org-startup-with-inline-images t
        org-startup-align-all-tables t
        org-startup-indented t
        org-startup-truncated t
        org-pretty-entities t
        org-pretty-entities-include-sub-superscripts t
        org-footnote-define-inline t
        )

  ;; https://github.com/purcell/emacs.d/blob/c0b36ccd87f660cde1b6caa692a3195a24c3ce3c/lisp/init-org.el#L10-L22
  ;; Various settings
  (setq
   ;; org-archive-mark-done nil
   ;; org-fast-tag-selection-single-key 'expert
   ;; org-export-kill-product-buffer-when-displayed t
   ;; org-tags-column 80
   ;; org-log-done t
   org-edit-timestamp-down-means-later t
   org-hide-emphasis-markers t
   org-catch-invisible-edits 'show
   org-export-coding-system 'nil
   org-html-validation-link nil)

  ;; Latex
  (setq
   ;; Show images after evaluating code blocks.
   org-startup-with-inline-images t
   org-preview-latex-default-process 'imagemagick)

  ;; This is what makes bibtex work
  (setq org-latex-pdf-process '(
                                "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
                                "cp export/%b-blx.bib ."
                                "bibtex export/%b"
                                "rm -rf %b-blx.bib ."
                                "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
                                "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"))

  ;; Makes the font the wrong freakin color
  ;;(setq org-latex-create-formula-image-program
  ;;      'dvipng)

  ;; Babel
  (setq
   org-confirm-babel-evaluate nil
   ;; Over-rides :export none
   org-export-babel-evaluate t)

  ;; display/update images in the buffer after I evaluate
  ;;(add-hook 'org-babel-after-execute-hook 'org-display-inline-images 'append)


  ;; Refile
  (setq org-refile-targets '((nil :maxlevel . 9)
                             (org-agenda-files :maxlevel . 9)))

  (setq org-refile-use-outline-path 'file
        org-outline-path-complete-in-steps nil
        org-refile-allow-creating-parent-nodes 'confirm)

  ;; Keybindings
  (spacemacs/set-leader-keys-for-major-mode 'org-mode
    "sx" 'org-cut-subtree
    "sp" 'org-paste-subtree
    "sy" 'org-copy-subtree
    "sR" 'orxtended/org-refile-to-datetree
    "sa" 'org-archive-to-archive-sibling))

(defun orxtended/init-org-protocol ()
  (use-package org-protocol
    :defer t
    :commands (org-protocol-capture org-protocol-create) ;; this adds autoloads
    :init
    (require 'org-protocol)

    ;;; Org Capture
    ;;;; Thank you random guy from StackOverflow
    ;;;; http://stackoverflow.com/questions/23517372/hook-or-advice-when-aborting-org-capture-before-template-selection

    ;; (defadvice org-capture
    ;;     (after make-full-window-frame activate)
    ;;   "Advise capture to be the only window when used as a popup"
    ;;   (if (equal "emacs-capture" (frame-parameter nil 'name))
    ;;       (delete-other-windows)))

    ;; (defadvice org-capture-finalize
    ;;     (after delete-capture-frame activate)
    ;;   "Advise capture-finalize to close the frame"
    ;;   (if (equal "emacs-capture" (frame-parameter nil 'name))
    ;;       (delete-frame)))


    (evil-leader/set-key-for-mode 'org-mode
      "mp" 'org-protocol-capture)))

(defun orxtended/init-org-crypt ()
  (use-package org-crypt
    :init
    (require 'org-crypt)
    (org-crypt-use-before-save-magic)
    (setq org-tags-exclude-from-inheritance (quote ("crypt")))
    ;; GPG key to use for encryption
    ;; Either the Key ID or set to nil to use symmetric encryption.
    (setq org-crypt-key nil)
    ))

(defun orxtended/init-ox-manuscript ()
  (use-package ox-manuscript))


;;; packages.el ends here
