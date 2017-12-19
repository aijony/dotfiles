(require 'seq)


(defun notmuch/search ()
  (interactive)
  (require 'notmuch)
  (notmuch-search))

(defun notmuch/tree ()
  (interactive)
  (require 'notmuch)
  (notmuch-tree))

(defun notmuch/jump-search ()
  (interactive)
  ;; (require 'notmuch)
  (notmuch-jump-search)
  (bind-map-change-major-mode-after-body-hook))

(defun notmuch/new-mail ()
  (interactive)
  (require 'notmuch)
  (notmuch-mua-new-mail))

(defun notmuch/inbox ()
  (interactive)
  (require 'notmuch)
  (notmuch-tree "tag:inbox")
  (bind-map-change-major-mode-after-body-hook))

(defun notmuch/tree-show-message ()
  (interactive)
  (notmuch-tree-show-message-in)
  (select-window notmuch-tree-message-window))

(defun notmuch/list-to-regexp (list)
  "Converts lists of regexp expressions into a single
expression that incorporates them all in an or-like fashion."
  (let ((head (concat "\\("
                      (car list)
                      "\\)"))
        (body (cdr list))
        (func '(lambda (a b)
                 (concat a "\\|\\(" b "\\)"))))
    (seq-reduce func body head)))

(defun notmuch/switch-keys (keymap oldkey newkey)
  "Swaps OLDKEY with NEWKEY in KEYMAP without changing the
key's definition"
  (define-key keymap (kbd newkey) (lookup-key keymap (kbd oldkey)))
  (define-key keymap (kbd oldkey) nil)
  )
