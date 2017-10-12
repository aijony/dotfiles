(setq ob-ipython-packages
  '(ob-ipython))


(defun ob-ipython/init-ob-ipython ()
  (use-package ob-ipython
    :config
    (setq ob-ipython-resources-dir "./img/")


    (defun ob-ipython--render (file-or-nil values)
      (let ((org (lambda (value) value))
            (png (lambda (value)
                   (let ((file (or file-or-nil (ob-ipython--generate-file-name ".png"))))
                     (ob-ipython--write-base64-string file value)
                     (format "[[file:%s]]" file))))
            (svg (lambda (value)
                   (let ((file (or file-or-nil (ob-ipython--generate-file-name ".svg"))))
                     (ob-ipython--write-base64-string file value)
                     (format "[[file:%s]]" file))))
            (html (lambda (value)
                    ;; ((eq (car value) 'text/html)
                    ;;  (let ((pandoc (executable-find "pandoc")))
                    ;;    (and pandoc (with-temp-buffer
                    ;;                  (insert value)
                    ;;                  (shell-command-on-region
                    ;;                   (point-min) (point-max)
                    ;;                   (format "%s -f html -t org" pandoc) t t)
                    ;;                  (s-trim (buffer-string))))))
                    ))
            (txt (lambda (value)
                   (let ((lines (s-lines value)))
                     (if (cdr lines)
                         (format "#+BEGIN_EXAMPLE\n%s\n#+END_EXAMPLE" (s-join "\n  " lines))
                       (s-concat ": " (car lines)))))))
        (or (-when-let (val (cdr (assoc 'text/org values))) (funcall org val))
            (-when-let (val (cdr (assoc 'image/png values))) (funcall png val))
            (-when-let (val (cdr (assoc 'image/svg+xml values))) (funcall svg val))
            (-when-let (val (cdr (assoc 'text/plain values))) (funcall txt val)))))))
