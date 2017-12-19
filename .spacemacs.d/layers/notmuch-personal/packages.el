;;; packages.el --- notmuch Layer packages File for Spacemacs
;;
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3
;; github:mullr

(setq notmuch-personal-packages '(
                         ;; helm-notmuch
                         ;; notmuch-labeler
                                  (notmuch :location built-in)
                                  ))


(defun notmuch-personal/post-init-notmuch ()
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
         (if notmuch-better-wash
             (setq
              notmuch-wash-signature-regexp (notmuch/list-to-regexp notmuch-hide-text-signature)
              notmuch-wash-citation-regexp (notmuch/list-to-regexp notmuch-hide-text-at)
              notmuch-wash-original-regexp (notmuch/list-to-regexp notmuch-hide-text-below)))

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
         ;; Treats text-boxes like regular text files
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

           (notmuch/add-key notmuch-tree-mode-map (kbd "d") 'spacemacs/notmuch-message-delete-down)
           (notmuch/add-key notmuch-tree-mode-map (kbd "D") 'spacemacs/notmuch-message-delete-up)
           (notmuch/add-key notmuch-tree-mode-map (kbd "M") 'compose-mail-other-frame)
           (notmuch/add-key notmuch-search-mode-map (kbd "a") 'spacemacs/notmuch-search-archive-thread-down)
           (notmuch/add-key notmuch-search-mode-map (kbd "A") 'spacemacs/notmuch-search-archive-thread-up)
           (notmuch/add-key notmuch-search-mode-map (kbd "d") 'spacemacs/notmuch-message-delete-down)
           (notmuch/add-key notmuch-search-mode-map (kbd "D") 'spacemacs/notmuch-message-delete-up)
           (notmuch/add-key notmuch-search-mode-map (kbd "J") 'notmuch-jump-search)
           (notmuch/add-key notmuch-search-mode-map (kbd "L") 'notmuch-search-filter)
           (notmuch/add-key notmuch-search-mode-map (kbd "gg") 'notmuch-search-first-thread)
           (notmuch/add-key notmuch-search-mode-map (kbd "gr") 'notmuch-refresh-this-buffer)
           (notmuch/add-key notmuch-search-mode-map (kbd "gR") 'notmuch-refresh-all-buffers)
           (notmuch/add-key notmuch-search-mode-map (kbd "G") 'notmuch-search-last-thread)
           (notmuch/add-key notmuch-search-mode-map (kbd "M") 'compose-mail-other-frame)


           )

))

