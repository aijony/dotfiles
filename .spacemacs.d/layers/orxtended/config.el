;;(setq org-reveal-root "file:///home/aidan/.spacemacs.d/private/resources/reveal-js")




(setq org-ref-default-bibliography '("~/org/bibliography/references.bib")
      org-ref-pdf-directory
      "~/org/bibliography/"
      org-ref-bibliography-notes
      "~/org/bibliography/notes.org")

(setq org-agenda-files (list "~/org/cal.org"
                             "~/org/todo.org"
                             "~/org/agenda.org"
                             "~/org/refile.org"
                             "~/org/swedemom.org"))

(setq org-refile-targets '(
                           (nil :maxlevel . 9)
                           (org-agenda-files :maxlevel . 9)
                           ))


(setq org-latex-pdf-process '("pdflatex -interaction nonstopmode -output-directory %o %f"
                              "bibtex %b" "pdflatex -interaction nonstopmode -output-directory %o %f"
                              "pdflatex -interaction nonstopmode -output-directory %o %f"))


(setq org-todo-keywords
      (quote ((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d)")
              (sequence "WAITING(w@/!)" "HOLD(h)" "|" "CANCELLED(c@/!)" "DEAD"))))


(setq org-capture-templates
      '(
        ;; Syncs with google calender
        ("c" "calendar" entry (file  "~/org/cal.org" )
         "* %?\n\n%^T\n\n:PROPERTIES:\n\n:END:\n\n")

        ("j" "journal" entry (file+datetree "~/org/journal.org")
         "* %?\n%U\n")

        ("?" "weblink" entry (file "~/org/bookmarks.org")
         "* %:description  Source: %u, %c  %:initial" :empty-lines 1)

        ("t" "todo" entry (file "~/org/refile.org")
         "* TODO %^{Description} %^G %i%?")

        ("w" "todo-deadline" entry (file "~/org/refile.org")
         "* TODO %^{Description} %^G DEADLINE: %^t %i%?")

        ;; Misc note
        ("n" "note" entry (file "~/org/refile.org")
         "* %^{Description} %T%^G %i%? %A")

        ("i" "idea" entry (file "~/org/refile.org")
         "* %^{Title} %i %a")

        ;;Timed
        ("m" "meeting" entry (file "~/org/refile.org")
         "* %? :meeting:\n%U" :clock-in t :clock-resume t)

        ("p" "phone call" entry (file "~/org/refile.org")
          "* %? :phone:\n%U" :clock-in t :clock-resume t)

        ("s" "notes" entry (file "~/org/refile.org")
         "* %? :notes:\n%U\n%a\n" :clock-in t :clock-resume t)

        ("h" "Habit" entry (file "~/org/refile.org")
         "* NEXT %?\n%U\n%a\nSCHEDULED:
%(format-time-string \"%<<%Y-%m-%d %a .+1d/3d>>\")
\n:PROPERTIES:\n:STYLE: habit\n:REPEAT_TO_STATE: NEXT\n:END:\n")

        ))


