(setq coala-packages
      '((flycheck-coala :location (recipe
                                   :fetcher github
                                   :repo "coala/coala-emacs"
                                   :files ("flycheck-coala.el")))))


(defun coala/init-flycheck-coala ()
  (use-package flycheck-coala))
