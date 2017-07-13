;;; packages.el --- circe layer packages file for Spacemacs.  -*- lexical-binding: t; -*-
;;
;; Copyright (c) 2012-2014 Sylvain Benner
;; Copyright (c) 2014-2016 Sylvain Benner & Contributors
;;
;; Author: Chris Barrett <chris.d.barrett@me.com>
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
;; added to `circe-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `circe/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another spacemacs layer, so
;;   define the functions `circe/pre-init-PACKAGE' and/or
;;   `circe/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:


(defconst circe-packages
  '(circe
    persp-mode
    circe-notifications
    helm
    helm-circe
    ))

(defun circe/init-circe ()
  (use-package circe
    :commands circe
    :config
    (progn
      (set-face-background 'circe-prompt-face nil)
      (setq circe-reduce-lurker-spam t)
      (setq circe-use-cycle-completion t)
      (setq circe-active-users-timeout (* 60 30)) ; 30 minutes
      (setq circe-format-say "{nick}> {body}")
      (setq circe-format-self-say (concat (propertize ">>>" 'face 'circe-self-say-face) " {body}"))
      (setq circe-prompt-string (concat (propertize ">>>" 'face 'circe-prompt-face) " "))
      (setq circe-highlight-nick-type 'all)

      ;; Show channel name in prompt.

      (defun circe/bufname-to-channame (s)
        (-let* (((_ gitter-fmt) (s-match (rx (+ nonl) "/" (group (+ nonl)) eos) s))
                ((_ standard-fmt) (s-match (rx "#" (group (+ nonl)) eos) s)))
          (or gitter-fmt standard-fmt)))

      (defun circe/set-prompt ()
        (let* ((chan (circe/bufname-to-channame (buffer-name)))
               (prompt (concat "#" (propertize chan 'face 'circe-prompt-face) " > ")))
          (lui-set-prompt prompt)))

      (add-hook 'circe-chat-mode-hook #'circe/set-prompt)

      ;; Timestamps in margins.

      (setq lui-time-stamp-position 'right-margin)
      (setq lui-time-stamp-format "%H:%M")
      (setq lui-fill-type nil)))

  (use-package circe-color-nicks
    :commands enable-circe-color-nicks
    :init
    (with-eval-after-load 'circe
      (enable-circe-color-nicks))
    :config
    (setq circe-color-nicks-everywhere t))

  (use-package lui
    :init
    (progn
      (defun circe/set-local-vars ()
        (setq fringes-outside-margins t)
        (setq right-margin-width 5)
        (setq word-wrap t)
        (setq wrap-prefix "    "))

      (add-hook 'lui-mode-hook #'circe/set-local-vars)))

  (use-package lui-autopaste
    :commands enable-lui-autopaste
    :init
    (add-hook 'circe-channel-mode-hook #'enable-lui-autopaste)))

(defun circe/post-init-helm ()
  (use-package helm
    :defer t
    :config
    (dolist (mode '(circe-channel-mode circe-query-mode circe-server-mode))
      (add-to-list 'helm-mode-no-completion-in-region-in-modes mode))))

(defun circe/init-circe-notifications ()
  (use-package circe-notifications
    :commands enable-circe-notifications
    :after circe
    :init
    (add-hook 'circe-server-connected-hook #'enable-circe-notifications)
    :config
    (progn
      ;;; HACK: Fix broken implementation of internal function.

      (defun circe-notifications-nicks-on-all-networks ()
        "Get a list of all nicks in use according to `circe-network-options'."
        (delete-dups (mapcar (lambda (opt)
                               (plist-get (cdr opt) :nick))
                             circe-network-options)))

      (when (eq system-type 'darwin)
        (setq circe-notifications-alert-style 'osx-notifier)))))

(defun circe/post-init-persp-mode ()
  ;; do not save circe buffers
  (with-eval-after-load 'persp-mode
    (push (lambda (b) (with-current-buffer b (eq major-mode 'circe-mode)))
          persp-filter-save-buffers-functions))

  (spacemacs|define-custom-layout circe-spacemacs-layout-name
    :binding circe-spacemacs-layout-binding
    :body
    (progn
      (defun spacemacs-layouts/add-circe-buffer-to-persp ()
        (persp-add-buffer (current-buffer)
                          (persp-get-by-name
                           circe-spacemacs-layout-name)))
      (add-hook 'circe-mode-hook #'spacemacs-layouts/add-circe-buffer-to-persp)
      (call-interactively 'circe))))
;;; packages.el ends here
