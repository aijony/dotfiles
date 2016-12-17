(defvar orxtended-pre-extensions
  '(
    ;; pre extension orxtendeds go here

    )
)

(defvar orxtended-post-extensions
  '(
     ox-extra
    )
)
;; For each extension, define a function orxtended/init-<extension-orxtended>
;;
 (defun orxtended/init-ox-extra ()
   (use-extension ox-extra
	:config
	(ox-extras-activate '(ignore-headlines))
  (setq evil-escape-key-sequence "kj")
   )
)

