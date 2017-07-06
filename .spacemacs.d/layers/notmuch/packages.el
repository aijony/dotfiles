;;; packages.el --- notmuch Layer packages File for Spacemacs
;;
;; Copyright (c) 2015-2016 Ben Gamari
;;
;; Author: Ben Gamari <ben@smart-cactus.org>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3
;; github:mullr

(setq notmuch-packages '(notmuch notmuch-labeler notmuch-unread))

(setq notmuch-excluded-packages '())

(defun notmuch/init-notmuch ()
  "Initialize notmuch"
  (use-package notmuch
    :defer t
    :init (progn
            (spacemacs/set-leader-keys "amn" 'notmuch/new-mail
              "amm" 'notmuch/jump-search "ami" 'notmuch/inbox)
            (spacemacs/set-leader-keys-for-major-mode
              'notmuch-search-mode "t+" 'notmuch-search-add-tag)
            (spacemacs/set-leader-keys-for-major-mode
              'notmuch-tree-mode "tt" 'notmuch-tree-tag-thread
              "t+" 'notmuch-tree-add-tag "t-" 'notmuch-tree-remove-tag
              "r" 'notmuch-tree-refresh-view
              ;; "d" 'notmuch-tree-archive-message-then-next
              ;; "A" 'notmuch-tree-archive-thread
              "g" 'notmuch-poll-and-refresh-this-buffer
              "s" 'notmuch-search-from-tree-current-query
              "c" 'notmuch-show-stash-map "m" 'notmuch-mua-new-mail
              "w" 'notmuch-show-save-attachments)
            (spacemacs/set-leader-keys-for-minor-mode
              'notmuch-message-mode "," 'notmuch-mua-send-and-exit
              "k" 'message-kill-buffer))

    :config
    (progn (evilified-state-evilify-map notmuch-search-mode-map
            :mode notmuch-search-mode
            :bindings (kbd "q")'notmuch-search-quit
            (kbd "r")
            'notmuch-search-reply-to-thread
            (kbd "R")
            'notmuch-search-reply-to-thread-sender)
          (evilified-state-evilify-map notmuch-show-mode-map
            :mode notmuch-show-mode)
          (evilified-state-evilify-map notmuch-tree-mode-map
            :mode notmuch-tree-mode
            :bindings (kbd "q")'notmuch-bury-or-kill-this-buffer
            (kbd "?")
            'notmuch-help
            (kbd "RET")
            'notmuch/tree-show-message
            (kbd "}")
            'notmuch-tree-scroll-or-next
            (kbd "{")
            'notmuch-tree-scroll-message-window-back)

          ;; :init (tabbar-mode)
          ;; :bind (("C-<tab>" . tabbar-forward-tab)
          ;;        ("C-S-<tab>" . tabbar-backward-tab)))

          ;; See https://github.com/syl20bnr/spacemacs/issues/6681

          (push "\\*notmuch.+\\*" spacemacs-useful-buffers-regexp)
          ;; Fix helm
          ;; See id:m2vbonxkum.fsf@guru.guru-group.fi
          (setq notmuch-address-selection-function (lambda (prompt collection initial-input)
                                                     (completing-read prompt
                                                                      (cons initial-input collection)
                                                                      nil
                                                                      t
                                                                      nil
                                                                      'notmuch-address-history)))

          ;;(spacemacs/declare-prefix-for-mode 'notmuch-show-mode "n" "notmuch")
          ;;(spacemacs/declare-prefix-for-mode 'notmuch-show-mode "n." "MIME parts")

          (evilified-state-evilify-map 'notmuch-hello-mode-map
            :mode notmuch-hello-mode)
          (evilified-state-evilify-map 'notmuch-show-stash-map
            :mode notmuch-show-mode)
          (evilified-state-evilify-map 'notmuch-show-part-map
            :mode notmuch-show-mode)
          (evilified-state-evilify-map 'notmuch-show-mode-map
            :mode notmuch-show-mode
            :bindings (kbd "N")'notmuch-show-next-message
            (kbd "n")
            'notmuch-show-next-open-message)
          (evilified-state-evilify-map 'notmuch-tree-mode-map
            :mode notmuch-tree-mode)
          (evilified-state-evilify-map 'notmuch-search-mode-map
            :mode notmuch-search-mode
            :bindings (kbd "f")'notmuch-search-filter)
          (evil-define-key 'visual notmuch-search-mode-map
            "*" 'notmuch-search-tag-all "a" 'notmuch-search-archive-thread
            "-" 'notmuch-search-remove-tag "+" 'notmuch-search-add-tag)
          (spacemacs/set-leader-keys-for-major-mode
            'notmuch-show-mode "nc" 'notmuch-show-stack-cc
            "n|" 'notmuch-show-pipe-message "nw" 'notmuch-show-save-attachments
            "nv" 'notmuch-show-view-raw-message))))
