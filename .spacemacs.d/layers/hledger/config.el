;; Simon's ledger-mode tweaks



(setq ledger-report-links-in-register nil)

(setq ledger-mode-should-check-version nil)
;; neutralise some ledgerisms
(setq ledger-binary-path (expand-file-name "~/.local/bin/hledger"))
(setq ledger-mode-should-check-version nil)
(setq ledger-init-file-name " ")

;; move default amount position right allowing longer account names
(setq ledger-post-amount-alignment-column 64)

;; disable distracting highlight
(setq ledger-highlight-xact-under-point nil)


(add-to-list 'auto-mode-alist '("\\.\\(h?ledger\\|journal\\|j\\)$" . ledger-mode))

;; enable some highlighting for CSV rules files
(add-to-list 'auto-mode-alist '("\\.rules$" . conf-mode))



;; automatically show new transactions from hledger add or hledger-web
(add-hook 'ledger-mode-hook 'auto-revert-tail-mode)

;; M-1 to collapse all transactions to one line, M-0 to reset. Useful for quickly scanning
(global-set-key "\M-0"
                (lambda ()
                  (interactive)
                  (set-selective-display (* tab-width 0))))
(global-set-key "\M-1"
                (lambda ()
                  (interactive)
                  (set-selective-display (* tab-width 1))))
(add-hook 'ledger-mode-hook
          (lambda ()
            (setq tab-width 4)))

;; useful when running reports in a shell buffer
(defun highlight-negative-amounts nil
  (interactive)
  (highlight-regexp "\\(\\$-\\|-\\$\\)[.,0-9]+"
                    (quote hi-red-b)))


;; enable orgstruct minor mode, TAB while on a * comment expands/collapses org node
;; (can get slow though)
(add-hook 'ledger-mode-hook 'orgstruct-mode)

(defvar ledger-report-balance
  (list "bal" (concat ledger-binary-path " -f %(ledger-file) bal")))

(defvar ledger-report-reg
  (list "reg" (concat ledger-binary-path " -f %(ledger-file) reg")))

(defvar ledger-report-payee
  (list "payee" (concat ledger-binary-path " -f %(ledger-file) reg @%(payee)")))

(defvar ledger-report-account
  (list "account" (concat ledger-binary-path " -f %(ledger-file) reg %(account)")))

(setq ledger-reports
      (list ledger-report-balance
            ledger-report-reg
            ledger-report-payee
            ledger-report-account))

;; Provide the path to you journal file.
;; The default location is too opinionated.
(setq hledger-jfile "~/.hledger.journal")
