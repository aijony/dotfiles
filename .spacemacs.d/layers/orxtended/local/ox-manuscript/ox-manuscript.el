;;; ox-manuscript.el -- utilities to export scientific manuscripts,

;; Copyright(C) 2014 John Kitchin

;; Author: John Kitchin <jkitchin@andrew.cmu.edu>
;; This file is not currently part of GNU Emacs.

;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License as
;; published by the Free Software Foundation; either version 2, or (at
;; your option) any later version.

;; This program is distributed in the hope that it will be useful, but
;; WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program ; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 59 Temple Place - Suite 330,
;; Boston, MA 02111-1307, USA.

;;; Commentary:
;; provides the export menu and setup for the scientific manuscripts we write.
;;
;; A guiding principle here is that nothing is used by default.  You
;; should specify it all in the org file.

; important functions
;; ox-manuscript-export-and-build
;; ox-manuscript-export-and-build-and-open
;; ox-manuscript-build-submission-manuscript
;; ox-manuscript-build-submission-manuscript-and-open
;; ox-manuscript-export-and-build-and-email

;;; Code:

(require 'ox)
(require 'ox-publish)

;; * Custom variables

(defgroup ox-manuscript nil
  "Customization group for ox-manuscript.")

(defcustom ox-manuscript-latex-command
  "pdflatex"
  "Command to run latex."
  :group 'ox-manuscript)

(defcustom ox-manuscript-bibtex-command
  "bibtex8"
  "Command to run bibtex."
  :group 'ox-manuscript)

(defcustom ox-manuscript-interactive-build
  nil
  "Determines if pdfs are built with interaction from the user.
nil means just build without user interaction.  Anything else will
show the user a window of the results of each build step, and ask
if you should continue to the next step."
  :group 'ox-manuscript)


;; ** RSC
;; See http://www.rsc.org/Publishing/Journals/guidelines/AuthorGuidelines/AuthoringTools/Templates/tex.asp
;; I think their structure is too complex for ox-manuscript, and a real exporter would be required.

;; ** Science Magazine
;; Support for LaTeX in Science borders on ridiculous - LaTeX to HTML to Word - via DOS...
;; http://www.sciencemag.org/site/feature/contribinfo/prep/TeX_help/index.xhtml
;; No support in ox-manuscript for this.

;; ** Wiley
;; I have not been able to find a LaTeX package for Wiley

(provide 'ox-manuscript)

;;; ox-manuscript.el ends here
