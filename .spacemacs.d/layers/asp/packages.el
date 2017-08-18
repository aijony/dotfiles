

(setq asp-packages '(asp-mode :location local))

(defun asp/init-asp-mode ()
  (use-package asp-mode
    :defer t
    :config
    (autoload 'asp-mode "asp-mode")
    (setq auto-mode-alist 
          (cons '("\\.asp\\'" . asp-mode) auto-mode-alist))))
