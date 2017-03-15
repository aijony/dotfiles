(setq org-reveal-root "file:///home/aidan/.spacemacs.d/private/resources/reveal-js")

(setq org-tags-column 0)

(add-hook 'pdf-view-mode-hook 'pdf-view-midnight-minor-mode)

(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
(add-hook 'org-mode-hook 'turn-on-org-cdlatex)


(with-eval-after-load 'org-mode
(org-babel-do-load-languages 'org-babel-load-languages
                             '((C . t)
                               (latex . t)
                               (python . t)
                               (sage . t)
                               ))
)
