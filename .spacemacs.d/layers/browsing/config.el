
(setq browse-url-browser-function 'eww-browse-url)
(setq httpd-port '8082)

;; PDF tools

;; workaround for pdf-tools not reopening to last-viewed page of the pdf:
;; https://github.com/politza/pdf-tools/issues/18#issuecomment-269515117
;; TODO: save bookmarks in separate file

(defun brds/pdf-set-last-viewed-bookmark ()
  (when (eq major-mode 'pdf-view-mode)
    (bookmark-set (brds/pdf-generate-bookmark-name))))

(defun brds/pdf-jump-last-viewed-bookmark ()
  (when
      (brds/pdf-has-last-viewed-bookmark)
    (bookmark-jump (brds/pdf-generate-bookmark-name))))

(defun brds/pdf-has-last-viewed-bookmark ()
  (assoc
   (brds/pdf-generate-bookmark-name) bookmark-alist))

(defun brds/pdf-generate-bookmark-name ()
  (concat "PDF-LAST-VIEWED: " (buffer-file-name)))

(add-hook 'kill-buffer-hook 'brds/pdf-set-last-viewed-bookmark)
(add-hook 'pdf-view-mode-hook 'brds/pdf-jump-last-viewed-bookmark)

