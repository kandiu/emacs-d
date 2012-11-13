;;; -*- lexical-binding: t -*-

;;; general global variables for configuration

;; base load path
(defconst dotfiles-dir
  (file-name-directory
   (or (buffer-file-name) load-file-name))
  "Base path for customised Emacs configuration")

(add-to-list 'load-path dotfiles-dir)

;; What OS/window system am I using?

;; Adapted from:
;; https://github.com/purcell/emacs.d/blob/master/init.el
(defconst *is-a-mac*
  (eq system-type 'darwin)
  "Is this running on OS X?")

(defconst *is-carbon-emacs*
  (and *is-a-mac* (eq window-system 'mac))
  "Is this the Carbon port of Emacs?")

(defconst *is-cocoa-emacs*
  (and *is-a-mac* (eq window-system 'ns))
  "Is this the Cocoa version of Emacs?")

(defconst *is-linux*
  (eq system-type 'gnu/linux)
  "Is this running on Linux?")

;; Basic paths and variables other things need
(require 'init-utils)
(require 'init-paths)

;; use-package - used in other places
(require 'init-use-package)

;; backups and autosaves
(require 'init-backups)

;; Editing and interface changes
(require 'init-editing)
(require 'init-interface)

(require 'init-packages)

(use-package init-window-gui
             :if (display-graphic-p))
(use-package init-osx
             :if *is-a-mac*)
(use-package init-linux
             :if *is-linux*)
(require 'init-xterm)

;; Mode configuration

;; built-in modes
(require 'init-abbrev)
(require 'init-ansi-color)
(require 'init-ansi-term)
(require 'init-ediff)
(require 'init-emacs-lisp)
(require 'init-eshell)
(require 'init-flymake)
(require 'init-hippie-expand)
(require 'init-ido)
(require 'init-org)
(require 'init-recentf)
(require 'init-rst)
(require 'init-ruby)
(require 'init-saveplace)
(require 'init-tramp)
(require 'init-uniquify)
(require 'init-whitespace)

;; vendor-ised modes
(defconst vendor-modes
  '(init-eproject
    init-js2
    init-json
    init-magit)
  "Configuration for vendorised code")

(bw-require-list vendor-modes)

;; Packaged modes from ELPA etc.
(defconst elpa-modes
  '(init-ace-jump
    init-ack-and-a-half
    init-browse-kill-ring
    init-expand-region
    init-iedit
    init-markdown
    init-multiple-cursors
    init-paredit
    init-puppet
    init-undo-tree
    init-yaml
    init-yasnippet)
  "Configuration for modes loaded via package.el")

(bw-require-list elpa-modes)

;; Custom theme support
(require 'init-themes)
(require 'init-solarized)

(require 'init-keybindings)

;; start a server, unless one is already running
(require 'server)
(unless (server-running-p)
  (server-start))

;; Load custom file last
(setq custom-file (concat dotfiles-dir "custom.el"))
(load custom-file 'noerror)
