;;; packages.el --- erc-znc layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2016 Sylvain Benner & Contributors
;;
;; Author: Adam Kruszewski <adam@kruszewski.name>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

;;; Commentary:
;; A simple ZNC.el layer for ERC.

(defconst erc-znc-packages
  '(znc
    erc
    erc-latex
    erc-youtube
    ))

(defun erc-znc/init-znc ()
  (use-package znc
    :defer t
    :init
    ))

(defun erc-znc/post-init-erc ()
  (spacemacs/set-leader-keys
    "aie" 'znc-erc)
  (setq erc-lurker-hide-list '("JOIN" "PART" "QUIT"))
  (setq erc-lurker-threshold-time 3600))

(defun erc-znc/post-init-erc-image ()
  (erc-image-disable))

(defun erc-znc/post-init-erc-latex ()
  (erc-latex-mode '1)
  )

(defun erc-znc/post-init-erc-youtube ()
  (erc-youtube-disable))


;; HACK
(defun erc/post-init-persp-mode ()
  ;; do not save erc buffers
  (with-eval-after-load 'persp-mode
    (push (lambda (b) (with-current-buffer b (eq major-mode 'erc-mode)))
          persp-filter-save-buffers-functions))

  (spacemacs|define-custom-layout erc-spacemacs-layout-name
    :binding erc-spacemacs-layout-binding
    :body
    (progn
      (defun spacemacs-layouts/add-erc-buffer-to-persp ()
        (persp-add-buffer (current-buffer)
                          (persp-get-by-name
                           erc-spacemacs-layout-name)))
      (add-hook 'erc-mode-hook #'spacemacs-layouts/add-erc-buffer-to-persp)
      (call-interactively 'znc-all))))

;;; packages.el ends here
