
(defun ycmd-generate ()
  (interactive)
  (let (
        (project-dir (format "%s" (projectile-project-root)))
        (generator-dir ycmd-generate-command )
        )
    (shell-command (format "%s %s" generator-dir  project-dir ))
    )
  )

