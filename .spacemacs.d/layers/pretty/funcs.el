(defmacro with-face (STR &rest PROPS)
  "Return STR propertized with PROPS."
  `(propertize ,STR 'face (list ,@PROPS)))

(defun pretty-notch-fifty ()
  "Not to 50! (Applies every known prettification)"
  (interactive)
  (pretty-like-org)
  (pretty-mode)
  )

(defun pretty-like-org ()
  "Emulates various sub/super scripts and TeX expressions"
  (interactive)
  (pretty-like-org-add-font-lock)
  (setq-local font-lock-keywords-only t)
  (setq-local buffer-invisibility-spec t)
  )

(defun pretty-like-org-add-font-lock ()
  "Set font lock defaults for the current buffer."
  (interactive)
  (let* ((em org-fontify-emphasized-text)
	 (lk org-highlight-links)
	 (like-org-font-lock-extra-keywords
	  (list
	   ;; Call the hook
	   '(org-font-lock-hook)
	   ;; ;; Headlines
     ;;  `(,(if org-fontify-whole-heading-line
     ;;   "^\\(\\**\\)\\(\\* \\)\\(.*\n?\\)"
     ;; "^\\(\\**\\)\\(\\* \\)\\(.*\\)")
     ;;    (1 (org-get-level-face 1))
     ;;    (2 (org-get-level-face 2))
     ;;    (3 (org-get-level-face 3)))
	   ;; Table lines
	   ;; '("^[ \t]*\\(\\(|\\|\\+-[-+]\\).*\\S-\\)"
	   ;;   (1 'org-table t))
	   ;; ;; Table internals
	   ;; '("^[ \t]*|\\(?:.*?|\\)? *\\(:?=[^|\n]*\\)" (1 'org-formula t))
	   ;; '("^[ \t]*| *\\([#*]\\) *|" (1 'org-formula t))
	   ;; '("^[ \t]*|\\( *\\([$!_^/]\\) *|.*\\)|" (1 'org-formula t))
	   ;; '("| *\\(<[lrc]?[0-9]*>\\)" (1 'org-formula t))
	   ;; ;; Drawers
	   ;; '(org-fontify-drawers)
	   ;; ;; Properties
	   ;; (list org-property-re
		 ;; '(1 'org-special-keyword t)
		 ;; '(3 'org-property-value t))
	   ;; ;; Link related fontification.
	   ;; '(org-activate-links)
	   ;; (when (memq 'tag lk) '(org-activate-tags (1 'org-tag prepend)))
	   ;; (when (memq 'radio lk) '(org-activate-target-links (1 'org-link t)))
	   ;; (when (memq 'date lk) '(org-activate-dates (0 'org-date t)))
	   ;; (when (memq 'footnote lk) '(org-activate-footnote-links))
     ;;       ;; Targets.
     ;;       (list org-any-target-regexp '(0 'org-target t))
	   ;; ;; Diary sexps.
	   ;; '("^&?%%(.*\\|<%%([^>\n]*?>" (0 'org-sexp-date t)) ;; ;; Macro
	   ;; '(org-fontify-macros)
	   ;; '(org-hide-wide-columns (0 nil append))
	   ;; TODO keyword
	   (list (format org-heading-keyword-regexp-format
			 org-todo-regexp)
		 '(2 (org-get-todo-face 2) t))
	   ;; DONE
	   (if org-fontify-done-headline
	       (list (format org-heading-keyword-regexp-format
			     (concat
			      "\\(?:"
			      (mapconcat 'regexp-quote org-done-keywords "\\|")
			      "\\)"))
		     '(2 'org-headline-done t))
	     nil)
	   ;; ;; Priorities
	   ;; '(org-font-lock-add-priority-faces)
	   ;; Tags
	   '(org-font-lock-add-tag-faces)
	   ;; Tags groups
	   ;; (when (and org-group-tags org-tag-groups-alist)
	   ;;   (list (concat org-outline-regexp-bol ".+\\(:"
		 ;;     (regexp-opt (mapcar 'car org-tag-groups-alist))
		 ;;     ":\\).*$")
		 ;;   '(1 'org-tag-group prepend)))
	   ;; Special keywords
	   ;; (list (concat "\\<" org-deadline-string) '(0 'org-special-keyword t))
	   ;; (list (concat "\\<" org-scheduled-string) '(0 'org-special-keyword t))
	   ;; (list (concat "\\<" org-closed-string) '(0 'org-special-keyword t))
	   ;; (list (concat "\\<" org-clock-string) '(0 'org-special-keyword t))
	   ;; Emphasis
	   (when em '(org-do-emphasis-faces))
	   ;; Checkboxes
	   '("^[ \t]*\\(?:[-+*]\\|[0-9]+[.)]\\)[ \t]+\\(?:\\[@\\(?:start:\\)?[0-9]+\\][ \t]*\\)?\\(\\[[- X]\\]\\)"
	     1 'org-checkbox prepend)
	   (when (cdr (assq 'checkbox org-list-automatic-rules))
	     '("\\[\\([0-9]*%\\)\\]\\|\\[\\([0-9]*\\)/\\([0-9]*\\)\\]"
	       (0 (org-get-checkbox-statistics-face) t)))
	   ;; Description list items
	   ;; '("^[ \t]*[-+*][ \t]+\\(.*?[ \t]+::\\)\\([ \t]+\\|$\\)"
	   ;;   1 'org-list-dt prepend)
	   ;; ;; ARCHIVEd headings
	   ;; (list (concat
		 ;;  org-outline-regexp-bol
		 ;;  "\\(.*:" org-archive-tag ":.*\\)")
		 ;; '(1 'org-archived prepend))
	   ;; Specials
	   '(org-do-latex-and-related)
	   '(org-fontify-entities)
	   '(org-raise-scripts)
	   ;; Code
	   ;; '(org-activate-code (1 'org-code t))
	   ;; COMMENT
	   ;; (list (format
		 ;;  "^\\*+\\(?: +%s\\)?\\(?: +\\[#[A-Z0-9]\\]\\)? +\\(?9:%s\\)\\(?: \\|$\\)"
		 ;;  org-todo-regexp
		 ;;  org-comment-string)
		 ;; '(9 'org-special-keyword t))
	   ;; ;; Blocks and meta lines
	   ;; '(org-fontify-meta-lines-and-blocks)
    )))
    (setq like-org-font-lock-extra-keywords (delq nil like-org-font-lock-extra-keywords))
    (run-hooks 'org-font-lock-set-keywords-hook)
    ;; Now set the full font-lock-keywords
    (setq-local like-org-font-lock-keywords like-org-font-lock-extra-keywords)
    (font-lock-add-keywords nil like-org-font-lock-extra-keywords)
    nil))

