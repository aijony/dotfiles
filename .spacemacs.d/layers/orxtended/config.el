;;(setq org-reveal-root "file:///home/aidan/.spacemacs.d/private/resources/reveal-js")

(add-hook 'pdf-view-mode-hook 'pdf-view-midnight-minor-mode)

(add-hook 'LaTeX-mode-hook 'turn-on-reftex)


(setq org-ref-default-bibliography '("~/sync/bibliography/references.bib")
      org-ref-pdf-directory
      "~/sync/bibliography/"
      org-ref-bibliography-notes
      "~/sync/bibliography/notes.org")

(setq org-latex-pdf-process '("pdflatex -interaction nonstopmode -output-directory %o %f"
                              "bibtex %b" "pdflatex -interaction nonstopmode -output-directory %o %f"
                              "pdflatex -interaction nonstopmode -output-directory %o %f"))


;; Show images after evaluating code blocks.
(setq org-startup-with-inline-images t)


(add-hook 'org-babel-after-execute-hook 'orxtended/after-babel)

(setq org-startup-with-latex-preview t)

(setq org-latex-listings t)


(setq org-preview-latex-default-process 'imagemagick)


