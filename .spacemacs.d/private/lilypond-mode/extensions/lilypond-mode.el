(defvar lilypond-mode-hook nil)


;; TODO multi-line comments feel broken. I need to refresh font-lock
;;      more often.
(defconst lilypond-font-lock-keywords-1
  (list
   '("\\\\\\w*" . font-lock-builtin-face)
   '("%[^{}].*" . font-lock-comment-face) ; Single-line comments
   '("%{[\0-\377:nonascii:]*%}" . font-lock-comment-face)) ;; Multi-line comments
  "Minimal keyword hightlighting for lilypond mode.")

(defconst lilypond-font-lock-keywords-2
  (append lilypond-font-lock-keywords-1
          (list
           '("" . font-lock-keyword-face)))
  "Additional keyword highlighting for lilypond mode. Currently unused.")

(defconst lilypond-font-lock-keywords-3
  (append lilypond-font-lock-keywords-2
          (list
           '("" . font-lock-keyword-face)))
  "Full keyword highlighting for lilypond mode. Currently unused.")

(defvar lilypond-font-lock-keywords lilypond-font-lock-keywords-3
  "Default highlighting expressions for lilypond mode.")

(defvar lilypond-mode-syntax-table
  (let ((st (make-syntax-table)))
    (modify-syntax-entry ?- "w " st)
    st)
  "Syntax table for lilypond-mode")


;; TODO this function needs better documentation and better coding.
(defun lilypond-indent-line ()
  "Indent current line according to lilypond syntax."
  (interactive)
  (beginning-of-line)
  (let ((not-indented t) cur-indent)
    ;; First line is always indented to 0
    (if not-indented
        (if (bobp)
            (progn
              (setq cur-indent 0)
              (setq not-indented nil))))
    ;; Preserve indentation if a "{" and "}" occur on the previous line
    (if not-indented
        (save-excursion
          (forward-line -1)
          (if (looking-at "^.*{.*}")
              (progn
                (setq cur-indent (- (current-indentation) tab-width))
                (setq not-indented nil)))))
    ;; De-indent relative to previous line if a "}" is on the current line
    (if not-indented
        (if (looking-at "^.*}")
            (save-excursion
              (forward-line -1)
              (setq cur-indent (- (current-indentation) tab-width))
              (setq not-indented nil))))
    ;; Increase indentation if a "{" occurs on the previous line
    (if not-indented
        (save-excursion
          (forward-line -1)
          (if (looking-at "^.*{")
              (progn
                (setq cur-indent (+ (current-indentation) tab-width))
                (setq not-indented nil)))))
    ;; If none of the above rules apply,
    ;; then preserve indentation from the previous line
    (if not-indented
        (save-excursion
          (forward-line -1)
          (setq cur-indent (current-indentation))
          (setq not-indented nil)))
    ;; Indent according to the applicable rule above
    (if cur-indent
        (progn
          (if (< cur-indent 0) (setq cur-indent 0))
          (indent-line-to cur-indent)))))


(defvar lilypond-mode-map
  (let ((map (make-keymap)))
    (define-key map "\C-c\C-c"
      (lambda (cmd)
        "Exports the current lilypond file using a given command."
        (interactive "sLilypond export command: ")
        (shell-command (concat cmd " " (buffer-file-name)))))
    map)
  "Keymap for lilypond major mode.")


(defun lilypond-mode ()
  "Major mode for editing lilypond music notation."
  (interactive)
  (kill-all-local-variables)
  (setq major-mode 'lilypond-mode)
  (setq mode-name "Lilypond")
  (set-syntax-table lilypond-mode-syntax-table)
  (use-local-map lilypond-mode-map)
  (set (make-local-variable 'font-lock-defaults) '(lilypond-font-lock-keywords))
  (set (make-local-variable 'indent-line-function) 'lilypond-indent-line)
  (run-hooks 'lilypond-mode-hook))


;;;###autoload
(add-to-list 'auto-mode-alist '("\\.ly\\'" . lilypond-mode))


(provide 'lilypond-mode)
