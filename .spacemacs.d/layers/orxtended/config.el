(setq org-reveal-root "file:///home/aidan/.spacemacs.d/private/resources/reveal-js")


(add-hook 'pdf-view-mode-hook 'pdf-view-midnight-minor-mode)

(add-hook 'LaTeX-mode-hook 'turn-on-reftex)


(setq org-ref-default-bibliography '("~/documents/sync/bibliography/references.bib")
      org-ref-pdf-directory "~/documents/sync/bibliography/"
      org-ref-bibliography-notes "~/documents/sync/bibliography/notes.org")

(setq org-latex-pdf-process
      '("pdflatex -interaction nonstopmode -output-directory %o %f"
        "bibtex %b"
        "pdflatex -interaction nonstopmode -output-directory %o %f"
        "pdflatex -interaction nonstopmode -output-directory %o %f"))
