

(setq asp-packages '(
                     (asp-mode :location local)
                     (csharp-mode)
                     ))

(defun asp/init-asp-mode ()
  (use-package asp-mode
    :defer t
    :commands asp-mode
    :config
    (setq auto-mode-alist 
          (cons '("\\.asp\\'" . asp-mode) auto-mode-alist))))

(defun asp/post-init-csharp-mode ()
  (add-hook 'csharp-mode-hook 'ml-comments)
  )

;; (defun asp/post-init-mmm-mode ()
;;   (use-package mmm-mode
;;     :defer t
;;     :commands mmm-mode
;;     :config
;;     (setq global-mmm-mode 'maybe)
;;     (mmm-add-classes
;;      '(
;;        (csharp-xml
;;         :submode xml-mode
;;         :face mmm-code-submode-face
;;         :front "\/\/\/"
;;         )))
;;     (mmm-add-mode-ext-class 'csharp-mode nil 'csharp-xml)))
