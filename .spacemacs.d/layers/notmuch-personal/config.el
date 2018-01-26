
(defvar notmuch-better-defaults nil
 "Sets `notmuch-clean-defaults', `notmuch-sensible-defaults'
, and `notmuch-better-wash'. It doesn't override.")

(defvar notmuch-clean-defaults notmuch-better-defaults
  "Removes moves headers,
and doesn't preview any citation.
Showing parts of citations can be helpful
for detecting false positives.
However, context can usually be enough.")

(defvar notmuch-sensible-defaults notmuch-better-defaults
  "Orders searches so most recent appears at the top.
Sends mail without hanging Emacs, or displaying errors,
see: `message-interactive'.")

(defvar notmuch-better-wash notmuch-better-defaults
  "Notmuch will hide citations and signatures automatically.
It does this via regexp, but it is far from all-encompassing of
every type of email format. Setting to `t' will apply all
`notmuch-hide-text-*' lists. These lists can also be modified
to suit the users personal preference. Setting `nil' will
leave the defaults up to notmuch.
")

(defvar notmuch-use-sendmail nil
  "Defines variables to use sendmail if t, if
a file path is sent, that will be the program used.
For example sending /usr/bin/msmtp will use
msmtp instead of sendmail.
 ")

;; List of default notmuch modes that will become evilifed.
(setq notmuch-evilify-mode-list '(notmuch-hello-mode
                                  notmuch-search-mode
                                  notmuch-show-mode
                                  notmuch-tree-mode
                                  ;; notmuch-message-mode
                                  ))

(defvar notmuch-spacemacs-layout-name "@Notmuch"
  "Name used in the setup for `spacemacs-layouts' micro-state")

(defvar notmuch-spacemacs-layout-binding "n"
  "Binding used in the setup for `spacemacs-layouts' micro-state")


(defvar notmuch-hide-text-signature '("^-- ?"
                                      "^_+$")
  "This list is only implemented with `notmuch-clean-defaults' set to t.
Default signature regexp manually derived from default
`notmuch-wash-signature-regexp' as of 0.24.2.
The parent variable is unlikely to change on notmuch's side.
All matching signatures will be hidden.
Feel free to add or remove regexp from this list.
It is automatically properly concatenated with `notmuch-list-to-regexp'")

(defvar notmuch-hide-text-at '("\\(^[[:space:]]*>.*\n\\)+")
  "This list is only implemented with `notmuch-clean-defaults' set to t.
Default citation regexp manually derived from default
`notmuch-wash-citation-regexp' as of 0.24.2.
The parent variable is unlikely to change on notmuch's side.
All text matching will be hidden.
Feel free to add or remove regexp from this list.
It is automatically properly concatenated with `notmuch-list-to-regexp'")

(defvar notmuch-hide-text-below '("--+\s?[oO]riginal [mM]essage\s?--+"
                                  "From: .*\nSent: .*"
                                  "\nOn .*\n?.*wrote:")
  "This list is only implemented with `notmuch-clean-defaults' set to t.
Default original regexp manually derived from default
`notmuch-wash-original-regexp' as of 0.24.2.
The parent variable is unlikely to change on notmuch's side.
All text below matches will be hidden.
This layer has been extended  to recognize more common signatures.
Feel free to add or remove regexp from this list.
It is automatically properly concatenated with `notmuch-list-to-regexp' ")


