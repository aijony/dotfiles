# lilypond-mode

Emacs major mode for editing lilypond music notation.

lilypond-mode was created as an alternative to [Nicolas Sceaux's lyqi major mode](https://github.com/nsceaux/lyqi), which seems to be the leading lilypond major mode, but it falls short on two important factors: its name doesn't end in "-mode", and it isn't available in a repository.

...Call me fussy, but notation is everything. I want to fix that.

## Implemented features

Here are the features that lilypond-mode currently supports:

* Single-line and multi-line comments
* Rudimentary indentation (work in progress)
* Rudimentary exporting (work in progress)

## Planned features

Here's what I have in mind for lilypond-mode:

* Complete syntax highlighting
* Complete indentation support
* Keymaps for exporting
* Accessible from a repository such as MELPA

lilypond-mode's features are subject to change, but I will be keeping the mode as simple as it can be.

## Installation

Since this major mode isn't yet hosted on a repository such as MELPA or MARMALADE, the best way to install it is to download `lilypond-mode.el`.

For Emacs beginners:
* Move `lilypond-mode.el` to anywhere in your load-path.
* Load the package by adding `(require 'lilypond-mode)` in your `.emacs` file, or by loading it at run-time using `M-x load-library RET lilypond-mode`.

## Contributing

This project is brand new. It does not support most of lilypond's features. If you wish to contribute, feel free to submit a pull request. I'll take a look at it.

This project is released under the MIT license.
