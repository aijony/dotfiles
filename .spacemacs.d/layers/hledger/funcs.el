
;; These do not work as intended but prevent error
(defun ledger-do-reconcile (&optional sort)
  "SORT the uncleared transactions in the account and display them in the *Reconcile* buffer.
Return a count of the uncleared transactions."
  (let* ((buf ledger-buf)
         (account ledger-acct)
         (sort-by (if sort
                      sort
                    "(date)"))
         (xacts
          (with-temp-buffer
            (ledger-exec-ledger buf (current-buffer)
                                "-f balance -U" "-f balance --real")
            (goto-char (point-min))
            (unless (eobp)
              (if (looking-at "(")
                  (read (current-buffer))))))
         (fmt (ledger-reconcile-compile-format-string ledger-reconcile-buffer-line-format)))
    (if (> (length xacts) 0)
        (progn
          (if ledger-reconcile-buffer-header
              (insert (format ledger-reconcile-buffer-header account)))
          (dolist (xact xacts)
            (ledger-reconcile-format-xact xact fmt))
          (goto-char (point-max))
          (delete-char -1)) ;gets rid of the extra line feed at the bottom of the list
      (insert (concat "There are no uncleared entries for " account)))
    (goto-char (point-min))
    (set-buffer-modified-p nil)
    (setq buffer-read-only t)

    (length xacts)))


(defun ledger-reconcile-get-cleared-or-pending-balance (buffer account)
  "Use BUFFER to Calculate the cleared or pending balance of the ACCOUNT."

  ;; these vars are buffer local, need to hold them for use in the
  ;; temp buffer below

  (with-temp-buffer
    ;; note that in the line below, the --format option is
    ;; separated from the actual format string.  emacs does not
    ;; split arguments like the shell does, so you need to
    ;; specify the individual fields in the command line.
    (ledger-exec-ledger buffer (current-buffer)
                        "balance" "balance --cleared --pending" "balance --empty" 
                         "%(scrub(display_total))" account)
    (ledger-split-commodity-string
     (buffer-substring-no-properties (point-min) (point-max)))))

