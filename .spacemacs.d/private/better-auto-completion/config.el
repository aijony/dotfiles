;;; config.el --- better-auto-completion layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2016 Sylvain Benner & Contributors
;;
;; Author:  <aidan@excli>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3



;;Build directory settings


;;Set company behavior
(let ((map company-active-map))
  (define-key map (kbd "<tab>") 'company-complete-selection)
  (define-key map (kbd "RET") 'nil)
  )


;;Prevent parsing hold-up
(eval-after-load 'semantic
  (add-hook 'semantic-mode-hook
            (lambda ()
              (dolist (x (default-value 'completion-at-point-functions))
                (when (string-prefix-p "semantic-" (symbol-name x))
                  (remove-hook 'completion-at-point-functions x))))))


(setq flycheck-check-syntax-automatically '(mode-enabled new-line)


;;Thanks to git hub user Paulo Costa @pcesar22 All calls to
;;perl-mode now use cperl-mode
(defalias 'perl-mode 'cperl-mode)
;;Cperl mode hook enables company auto complete and fixes issue
;;with cperl-electric and smart-parens
(add-hook 'cperl-mode-hook
          #'company-mode
          (lambda () (local-unset-key (kbd "{")))
          )



;;YCMD

;;Safe command for .dir-locals.el
(put 'helm-make-build-dir 'safe-local-variable 'stringp)

;;Default build directory
(setq build-dir '"build")
(setq-default helm-make-build-dir build-dir)

;;Auto-Completion

(set-variable 'ycmd-server-command '("python" "/usr/bin/ycmd/ycmd"))
(set-variable 'ycmd-extra-conf-handler 'load)
(setq ycmd-generate-command '"~/.ycmd/YCM-Generator/config_gen.py")


;;Fuzzy-file-insert
(defun my-insert-file-name (filename &optional args)
  "Insert name of file FILENAME into buffer after point.

  Prefixed with \\[universal-argument], expand the file name to
  its fully canocalized path.  See `expand-file-name'.

  Prefixed with \\[negative-argument], use relative path to file
  name from current directory, `default-directory'.  See
  `file-relative-name'.

  The default with no prefix is to insert the file name exactly as
  it appears in the minibuffer prompt."
  ;; Based on insert-file in Emacs -- ashawley 20080926
  (interactive "*fInsert file name: \nP")
  (cond ((eq '- args)
         (insert (file-relative-name filename)))
        ((not (null args))
         (insert (expand-file-name filename)))
        (t
         (insert filename))))

(evil-leader/set-key "f i" 'my-insert-file-name)

