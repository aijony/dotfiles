;;; packages.el --- notmuch Layer packages File for Spacemacs
;;
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3
;; github:mullr

(setq notmuch-packages '(
                         ;; helm-notmuch
                         ;; notmuch-labeler
                         persp-mode
                         (notmuch :location site)))


(defun notmuch/init-notmuch () "Initialize notmuch"
       (use-package notmuch
         :defer t
         :commands notmuch
         :config

         ;; See https://github.com/syl20bnr/spacemacs/issues/6681
         (push "\\*notmuch.+\\*" spacemacs-useful-buffers-regexp)

         ;; This fixes helm
         ;; See id:m2vbonxkum.fsf@guru.guru-group.fi
         (setq notmuch-address-selection-function
               (lambda (prompt collection initial-input)
                 (completing-read
                  prompt (cons initial-input collection) nil t nil 'notmuch-address-history)))

         ;; Applies setting described by `notmuch-clean-defaults'
         (if notmuch-clean-defaults
             (setq
              notmuch-message-headers nil
              notmuch-wash-citation-lines-prefix 0
              notmuch-wash-citation-lines-suffix 0))

         ;; Applies settings described by `notmuch-better-wash'
         ;; TODO implement `cl-letf'

         ;; Applies setting described by `notmuch-sensible-defaults'
         (if notmuch-sensible-defaults
             (setq message-interactive nil
                   notmuch-search-oldest-first nil))

         ;; Applies settings described by `notmuch-use-sendmail'
         (if notmuch-use-sendmail
             (progn
               (setq message-send-mail-function 'message-send-mail-with-sendmail
                     send-mail-function 'sendmail-send-it)
               ;; Checks if arg is more than bool and assumes string
               (if (not (eq notmuch-use-sendmail t))
                   (setq sendmail-program notmuch-use-sendmail))))

         ;; Dynamic evil-states based off of text property
         (add-hook
          'notmuch-hello-mode-hook
          (lambda ()
            (add-hook
             'post-command-hook
             (lambda ()
               (let (
                     ;; Everything else that isn't `editable' for notmuch-hello should be read-only
                     (editable (get-char-property (point) 'field))
                     (is-evilified (string= evil-state "evilified"))
                     (is-normal (string= evil-state "normal"))
                     (is-insert (string= evil-state "insert")))
                 (cond ((and is-evilified editable)
                        (evil-normal-state))
                       ((and (or is-normal is-insert) (not editable))
                        (evil-evilified-state)))))
             nil t)))

         ;; Evilify the default notmuch modes
         (dolist (mode notmuch-evilify-mode-list)
           (evil-set-initial-state mode 'evilified))


         (spacemacs/set-leader-keys "a n" 'notmuch)

         ;; TODO Don't use eval-after-load (maybe)
         (with-eval-after-load 'notmuch
           (notmuch/switch-keys notmuch-common-keymap (kbd "j") (kbd ";"))
           (notmuch/switch-keys notmuch-common-keymap (kbd "G") (kbd "C-g"))
           (notmuch/switch-keys notmuch-hello-mode-map (kbd "v") (kbd "C-v"))
           (notmuch/switch-keys notmuch-tree-mode-map (kbd "")(kbd ""))
           (notmuch/switch-keys notmuch-tree-mode-map (kbd "v")(kbd "C-v"))
           (notmuch/switch-keys notmuch-tree-mode-map (kbd "V")(kbd "C-V"))
           (notmuch/switch-keys notmuch-tree-mode-map (kbd "a")(kbd "o"))
           (notmuch/switch-keys notmuch-tree-mode-map (kbd "A")(kbd "O"))
           (notmuch/switch-keys notmuch-tree-mode-map (kbd "n")(kbd "J"))
           (notmuch/switch-keys notmuch-tree-mode-map (kbd "N")(kbd "H"))
           (notmuch/switch-keys notmuch-tree-mode-map (kbd "p")(kbd "K"))
           (notmuch/switch-keys notmuch-tree-mode-map (kbd "P")(kbd "L"))
           (notmuch/switch-keys notmuch-tree-mode-map (kbd "k")(kbd ":"))
           (notmuch/switch-keys notmuch-tree-mode-map (kbd "SPC")(kbd "C-L"))
           (notmuch/switch-keys notmuch-tree-mode-map (kbd "DEL")(kbd "C-H"))
           (notmuch/switch-keys notmuch-search-mode-map (kbd "SPC")(kbd "C-L"))
           (notmuch/switch-keys notmuch-search-mode-map (kbd "DEL")(kbd "C-H"))
           (notmuch/switch-keys notmuch-search-mode-map (kbd "n")(kbd "J"))
           (notmuch/switch-keys notmuch-search-mode-map (kbd "p")(kbd "K"))
           (notmuch/switch-keys notmuch-search-mode-map (kbd "l")(kbd "\""))
           (notmuch/switch-keys notmuch-search-mode-map (kbd "k")(kbd ":"))
           (notmuch/switch-keys notmuch-search-mode-map (kbd "a")(kbd "o"))
           (notmuch/switch-keys notmuch-show-mode-map (kbd "SPC")(kbd "C-L"))
           (notmuch/switch-keys notmuch-show-mode-map (kbd "n")(kbd "J"))
           (notmuch/switch-keys notmuch-show-mode-map (kbd "p")(kbd "K"))
           (notmuch/switch-keys notmuch-show-mode-map (kbd "l")(kbd "\""))
           (notmuch/switch-keys notmuch-show-mode-map (kbd "k")(kbd ":"))
           (notmuch/switch-keys notmuch-show-mode-map (kbd "a")(kbd "o"))
           )))

(defun notmuch/post-init-persp-mode ()

  (spacemacs|define-custom-layout notmuch-spacemacs-layout-name
    :binding notmuch-spacemacs-layout-binding
    :body
    (call-interactively 'notmuch)))


;; (progn
;;         (((spacemacs/set-leader-keys "amn" 'notmuch/new-mail
;;           "amm" 'notmuch/jump-search "ami" 'notmuch/inbox)))
;;         (spacemacs/set-leader-keys-for-major-mode
;;           'notmuch-search-mode "t+" 'notmuch-search-add-tag)
;;         (spacemacs/set-leader-keys-for-major-mode
;;           'notmuch-tree-mode "tt" 'notmuch-tree-tag-thread
;;           "t+" 'notmuch-tree-add-tag "t-" 'notmuch-tree-remove-tag
;;           "r" 'notmuch-tree-refresh-view
;;           ;; "d" 'notmuch-tree-archive-message-then-next
;;           ;; "A" 'notmuch-tree-archive-thread
;;           "g" 'notmuch-poll-and-refresh-this-buffer
;;           "s" 'notmuch-search-from-tree-current-query
;;           "c" 'notmuch-show-stash-map "m" 'notmuch-mua-new-mail
;;           "w" 'notmuch-show-save-attachments)
;;         (spacemacs/set-leader-keys-for-minor-mode
;;           'notmuch-message-mode "," 'notmuch-mua-send-and-exit
;;           "k" 'message-kill-buffer))

;; :config
;; (progn (evilified-state-evilify-map notmuch-search-mode-map
;;         :mode notmuch-search-mode
;;         :bindings (kbd "q")'notmuch-search-quit
;;         (kbd "r")
;;         'notmuch-search-reply-to-thread
;;         (kbd "R")
;;         'notmuch-search-reply-to-thread-sender)
;;       (evilified-state-evilify-map notmuch-show-mode-map
;;         :mode notmuch-show-mode)
;;       (evilified-state-evilify-map notmuch-tree-mode-map
;;         :mode notmuch-tree-mode
;;         :bindings (kbd "q")'notmuch-bury-or-kill-this-buffer
;;         (kbd "?")
;;         'notmuch-help
;;         (kbd "RET")
;;         'notmuch/tree-show-message
;;         (kbd "}")
;;         'notmuch-tree-scroll-or-next
;;         (kbd "{")
;;         'notmuch-tree-scroll-message-window-back)

;;       ;; :init (tabbar-mode)
;;       ;; :bind (("C-<tab>" . tabbar-forward-tab)
;;       ;;        ("C-S-<tab>" . tabbar-backward-tab)))

;;       ;; See https://github.com/syl20bnr/spacemacs/issues/6681

;;       (push "\\*notmuch.+\\*" spacemacs-useful-buffers-regexp)
;;       ;; Fix helm
;;       ;; See id:m2vbonxkum.fsf@guru.guru-group.fi
;;       (setq notmuch-address-selection-function (lambda (prompt collection initial-input)
;;                                                  (completing-read prompt
;;                                                                   (cons initial-input collection)
;;                                                                   nil
;;                                                                   t
;;                                                                   nil
;;                                                                   'notmuch-address-history)))

;;       ;; (spacemacs/declare-prefix-for-mode 'notmuch-show-mode "n" "notmuch")
;;       ;; (spacemacs/declare-prefix-for-mode 'notmuch-show-mode "n." "MIME parts")

;;       (evilified-state-evilify-map 'notmuch-hello-mode-map
;;         :mode notmuch-hello-mode)
;;       (evilified-state-evilify-map 'notmuch-show-stash-map
;;         :mode notmuch-show-mode)
;;       (evilified-state-evilify-map 'notmuch-show-part-map
;;         :mode notmuch-show-mode)
;;       (evilified-state-evilify-map 'notmuch-show-mode-map
;;         :mode notmuch-show-mode
;;         :bindings (kbd "N")'notmuch-show-next-message
;;         (kbd "n")
;;         'notmuch-show-next-open-message)
;;       (evilified-state-evilify-map 'notmuch-tree-mode-map
;;         :mode notmuch-tree-mode)
;;       (evilified-state-evilify-map 'notmuch-search-mode-map
;;         :mode notmuch-search-mode
;;         :bindings (kbd "f")'notmuch-search-filter)
;;       (evil-notmuch/switch-keys 'visual notmuch-search-mode-map
;;         "*" 'notmuch-search-tag-all "a" 'notmuch-search-archive-thread
;;         "-" 'notmuch-search-remove-tag "+" 'notmuch-search-add-tag)
;;       (spacemacs/set-leader-keys-for-major-mode
;;         'notmuch-show-mode "nc" 'notmuch-show-stack-cc
;;         "n|" 'notmuch-show-pipe-message "nw" 'notmuch-show-save-attachments
;;         "nv" 'notmuch-show-view-raw-message))))
