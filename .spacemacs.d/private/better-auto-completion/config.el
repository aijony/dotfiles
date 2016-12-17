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



;;Safe command for .dir-locals.el
(put 'helm-make-build-dir 'safe-local-variable 'stringp)

;;Default build directory
(setq build-dir '"build")
(setq-default helm-make-build-dir build-dir)

;;Auto-Completion

(set-variable 'ycmd-server-command '("python" "/usr/bin/ycmd/ycmd"))
(set-variable 'ycmd-extra-conf-handler 'load)
(setq ycmd-generate-command '"~/.ycmd/YCM-Generator/config_gen.py")
