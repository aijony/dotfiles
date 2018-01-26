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
                                  persp-mode
                                  ))


(defun notmuch-personal/post-init-notmuch ()
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


         (spacemacs/set-leader-keys "a n" 'notmuch)

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
                        (evil-normal-state)
                        (define-key evil-motion-state-map (kbd "RET") 'widget-field-activate))
                       ((and (or is-normal is-insert) (not editable))
                        (evil-evilified-state)))))
             nil t)))

         ;; Evilify the default notmuch modes
         (dolist (mode notmuch-evilify-mode-list)
           (evil-set-initial-state mode 'evilified))




         ;; TODO Don't use eval-after-load (maybe)
         (with-eval-after-load 'notmuch
           (notmuch/switch-keys notmuch-common-keymap '(("j"  ";")))

           (notmuch/switch-keys notmuch-hello-mode-map '(("v" "_")))

           (notmuch/switch-keys notmuch-tree-mode-map '(("A" "O")
                                                        ("a" "o")
                                                        ("v" "a")
                                                        ("V" "A")
                                                        ("n" "J")
                                                        ("N" "H")
                                                        ("p" "K")
                                                        ("P" "L")
                                                        ("k" ":")
                                                        ("SPC" "C-L")
                                                        ("DEL" "C-H")))

           (notmuch/switch-keys notmuch-search-mode-map '(("SPC" "C-L")
                                                          ("DEL" "C-H")
                                                          ("n" "J")
                                                          ("p" "K")
                                                          ("l" "\"")
                                                          ("k" ":")
                                                          ("a" "o")))

           (notmuch/switch-keys notmuch-show-mode-map '(("SPC" "C-L")
                                                        ("n" "J")
                                                        ("p" "K")
                                                        ("l" "\"")
                                                        ("k" ":")
                                                        ("a" "o")))

           (notmuch/add-key notmuch-tree-mode-map '(("d" spacemacs/notmuch-message-delete-down)
                                                    ("D" spacemacs/notmuch-message-delete-up)
                                                    ("M" compose-mail-other-frame)))

           (notmuch/add-key notmuch-search-mode-map '(("a" spacemacs/notmuch-search-archive-thread-down)
                                                      ("A" spacemacs/notmuch-search-archive-thread-up)
                                                      ("d" spacemacs/notmuch-message-delete-down)
                                                      ("D" spacemacs/notmuch-message-delete-up)
                                                      ("J" notmuch-jump-search)
                                                      ("L" notmuch-search-filter)
                                                      ("gg" notmuch-search-first-thread)
                                                      ("gr" notmuch-refresh-this-buffer)
                                                      ("gR" notmuch-refresh-all-buffers)
                                                      ("G" notmuch-search-last-thread)
                                                      ("M" compose-mail-other-frame)))))

;;; HACK Fix keybindings

(defun notmuch/init-notmuch ()
  (use-package notmuch
    :defer t
    :commands notmuch
    :init
    (progn
      (spacemacs/declare-prefix "aN" "notmuch")
      (spacemacs/set-leader-keys "aNN" 'notmuch)
      (spacemacs/set-leader-keys "aNi" 'spacemacs/notmuch-inbox)
      (spacemacs/set-leader-keys "aNj" 'notmuch-jump-search)
      (spacemacs/set-leader-keys "aNs" 'notmuch-search)
      (spacemacs/set-leader-keys "aNn" 'helm-notmuch)
      (load-library "org-notmuch"))
    :config
    (progn
      (dolist (prefix '(("ms" . "stash")
                        ("mp" . "part")
                        ("mP" . "patch")))
        (spacemacs/declare-prefix-for-mode 'notmuch-show-mode
          (car prefix)
          (cdr prefix))))

  ;; fixes: killing a notmuch buffer does not show the previous buffer
  (push "\\*notmuch.+\\*" spacemacs-useful-buffers-regexp)
  ))

(defun notmuch-personal/post-init-persp-mode ()
  (spacemacs|define-custom-layout notmuch-spacemacs-layout-name
    :binding notmuch-spacemacs-layout-binding
    :body
    (call-interactively 'notmuch)))
