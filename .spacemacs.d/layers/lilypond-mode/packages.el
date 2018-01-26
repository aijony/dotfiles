;;; packages.el --- lilypond-mode layer packages file for Spacemacs.
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
;; added to `lilypond-mode-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `lilypond-mode/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `lilypond-mode/pre-init-PACKAGE' and/or
;;   `lilypond-mode/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:

(defconst lilypond-mode-packages
  '(
    (lilypond-mode :location built-in)
    )
  )

;; For each extension, define a function lilypond-mode/init-<extension-lilypond-mode>
;;
(defun lilypond-mode/init-lilypond-mode ()
  (use-package lilypond-mode
    :commands LilyPond-mode
    :config
    (autoload 'LilyPond-mode "lilypond-mode")
    (setq auto-mode-alist
          (cons '("\\.ly$" . LilyPond-mode) auto-mode-alist))

    (add-hook 'LilyPond-mode-hook (lambda () (turn-on-font-lock)))


    (setq locale-coding-system 'utf-8)
    (set-terminal-coding-system 'utf-8)
    (set-keyboard-coding-system 'utf-8)
    (set-selection-coding-system 'utf-8)
    (prefer-coding-system 'utf-8)))
;;; packages.el ends here
