
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

