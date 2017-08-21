

(setq asp-packages '((asp-mode :location local)))

(defun asp/init-asp-mode ()
  (use-package asp-mode
    :defer t
    :commands asp-mode
    :config
    (setq auto-mode-alist 
          (cons '("\\.asp\\'" . asp-mode) auto-mode-alist))))
