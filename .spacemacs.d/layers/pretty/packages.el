;;; Display Layer

(setq pretty-packages
      '(
        ;; Core Display Packages
        all-the-icons
        spaceline-all-the-icons
        (prettify-utils :location (recipe :fetcher github
                                          :repo "Ilazki/prettify-utils.el"))

        ;; Local packages
        (pretty-code :location local)
        ;; (pretty-eshell :location local)
        (pretty-fonts :location local)

        rcirc
        pretty-mode
        haskell-mode
        font-lock+
        ))

;;; Locals
;;;; Pretty-code

(defun pretty/init-pretty-code ()
  (use-package pretty-code
    ;; :after hy-mode python
    :config
    (progn
      (global-prettify-symbols-mode 1)

      (setq hy-pretty-pairs
            (pretty-code-get-pairs
             '(:lambda "fn" :def "defn"
                       ; :composition "comp"
                       :null "None" :true "True" :false "False"
                       :in "in" :not "not"
                       :and "and" :or "or"
                       :some "some"
                       :tuple "#t"
                       :pipe "ap-pipe"
                       )))

      (setq python-pretty-pairs
            (pretty-code-get-pairs
             '(:lambda "lambda" :def "def"
                       :null "None" :true "True" :false "False"
                       :int "int" :float "float" :str "str" :bool "bool"
                       :not "not" :for "for" :in "in" :not-in "not in"
                       :return "return" :yield "yield"
                       :and "and" :or "or"
                       :tuple "Tuple"
                       :pipe "tz-pipe"
                       )))
      (pretty-code-set-pairs `((hy-mode-hook     ,hy-pretty-pairs)
                               (python-mode-hook ,python-pretty-pairs))))))

;;;; Pretty-eshell

;; (defun pretty/init-pretty-eshell ()
;;   (use-package pretty-eshell
;;     :config
;;     (progn
;;       (esh-section esh-dir
;;                    "\xf07c"  ; 
;;                    (abbreviate-file-name (eshell/pwd))
;;                    '(:foreground "gold" :bold ultra-bold :underline t))
;;       (esh-section esh-git
;;                    "\xe907"  ; 
;;                    (magit-get-current-branch)
;;                    '(:foreground "pink"))
;;       (esh-section esh-python
;;                    "\xe928"  ; 
;;                    pyvenv-virtual-env-name)
;;       (esh-section esh-clock
;;                    "\xf017"  ; 
;;                    (format-time-string "%H:%M" (current-time))
;;                    '(:foreground "forest green"))
;;       (esh-section esh-num
;;                    "\xf0c9"  ; 
;;                    (number-to-string esh-prompt-num)
;;                    '(:foreground "brown"))
;;       (setq eshell-funcs (list esh-dir esh-git esh-python esh-clock esh-num)))))

;;;; Pretty-fonts

(defun pretty/init-pretty-fonts ()
  (use-package pretty-fonts
    :init
    (progn
      (defconst pretty-fonts-hy-mode
        '(("\\(self\\)"   ?⊙))))

    :config
    (progn
      (add-hook 'rcirc-mode-hook (lambda () (setq-local font-lock-keywords-only t)))
      (pretty-fonts-set-kwds
       '(;; Fira Code Ligatures
         (pretty-fonts-fira-font prog-mode-hook org-mode-hook)
         (pretty-fonts-fira-font rcirc-mode-hook)
         ;; Custom replacements not possible with `pretty-code' package
         (pretty-fonts-hy-mode hy-mode-hook)))

      (pretty-fonts-set-fontsets
       '(("fontawesome"
          ;;                         
          #xf07c #xf0c9 #xf0c4 #xf0cb #xf017 #xf101)

         ("all-the-icons"
          ;;    
          #xe907 #xe928)

         ("github-octicons"
          ;;                          
          #xf091 #xf059 #xf076 #xf075 #xe192  #xf016)

         ("material icons"
          ;;        
          #xe871 #xe918 #xe3e7
          ;;
          #xe3d0 #xe3d1 #xe3d2 #xe3d4)

         ("Symbola"
          ;; 𝕊    ⨂      ∅      ⟻    ⟼     ⊙      𝕋       𝔽
          #x1d54a #x2a02 #x2205 #x27fb #x27fc #x2299 #x1d54b #x1d53d
          ;; 𝔹    𝔇       𝔗
          #x1d539 #x1d507 #x1d517))))))

;;; Core Packages
;;;; All-the-icons

(defun pretty/init-all-the-icons ()
  (use-package all-the-icons
    :config
    (progn
      ;; hy-mode
      (add-to-list
       'all-the-icons-icon-alist
       '("\\.hy$" all-the-icons-fileicon "lisp" :face all-the-icons-orange))
      (add-to-list
       'all-the-icons-mode-icon-alist
       '(hy-mode all-the-icons-fileicon "lisp" :face all-the-icons-orange))

      ;; graphviz-dot-mode
      (add-to-list
       'all-the-icons-icon-alist
       '("\\.dot$" all-the-icons-fileicon "graphviz" :face all-the-icons-pink))
      (add-to-list
       'all-the-icons-mode-icon-alist
       '(graphviz-dot-mode all-the-icons-fileicon "graphviz" :face all-the-icons-pink))
      )))

;;;; Prettify-utils

(defun pretty/init-prettify-utils ()
  (use-package prettify-utils))

;;;; Spaceline-all-the-icons

(defun pretty/post-init-spaceline-all-the-icons ()
  (use-package spaceline-all-the-icons
    :after spaceline
    :config
    (progn
      (spaceline-all-the-icons-theme)

      (setq spaceline-highlight-face-func 'spaceline-highlight-face-default)
      (setq spaceline-all-the-icons-icon-set-modified 'chain)
      (setq spaceline-all-the-icons-icon-set-window-numbering 'square)
      (setq spaceline-all-the-icons-separator-type 'arrow)
      (setq spaceline-all-the-icons-primary-separator "")

      (spaceline-toggle-all-the-icons-buffer-size-off)
      (spaceline-toggle-all-the-icons-buffer-position-off)
      (spaceline-toggle-all-the-icons-vc-icon-off)
      (spaceline-toggle-all-the-icons-vc-status-off)
      (spaceline-toggle-all-the-icons-git-status-off)
      (spaceline-toggle-all-the-icons-flycheck-status-off)
      (spaceline-toggle-all-the-icons-time-off)
      (spaceline-toggle-all-the-icons-battery-status-off)
      (spaceline-toggle-hud-off)

      (setq org-clock-current-task nil)  ; bugfix
      )))

(defun pretty/init-pretty-mode ()
  (use-package pretty-mode
    :config
    (progn
      (global-pretty-mode t)

      (pretty-deactivate-groups
       '(:equality :ordering :ordering-triple
                   :arrows :arrows-twoheaded
                   :sub-and-superscripts 
                   :punctuation 
                   ))

      (pretty-activate-groups
       '(:greek :arithmetic-nary :logic :sets :ordering-double))
      )))

(defun pretty/post-init-rcirc ()
    ; (add-to-list 'pretty-supported-modes 'rcirc-mode)
    ; (add-to-list 'pretty-modes-aliases '(rcirc-mode . haskell-mode))
    ; (add-hook 'rcirc-mode-hook 'pretty-notch-fifty)
    )

;; (defun pretty/init-latex-pretty-symbols ()
;;   (use-package latex-pretty-symbols
;;               :commands latex-unicode-simplified
;;               :config
;;               (add-hook 'circe-mode-hook 'latex-unicode-simplified)
;;               (defun pretty/psuedo-tex ()
;;                 (interactive)
;;                 (latex-unicode-simplified))))


(defun pretty/post-init-haskell-mode ()
  (use-package haskell-mode
    :config
    (setq haskell-font-lock-symbols 't
          haskell-font-lock-symbols-alist '(("\\" . "λ")
                                            ("not" . "¬")
                                            ("()" . "∅")
                                            ;("==" . "≡")
                                            ;("/=" . "≢")
                                            ("!!" . "‼")
                                            ("&&" . "∧")
                                            ("||" . "∨")
                                            ("sqrt" . "√")
                                            ("undefined" . "⊥")
                                            ("pi" . "π")
                                            ("." "∘" haskell-font-lock-dot-is-not-composition)
                                            ("forall" . "∀")))))

(defun pretty/post-init-font-lock+ ()
  (use-package font-lock+))
