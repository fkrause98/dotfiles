;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el

;; To install a package with Doom you must declare them here and run 'doom sync'
;; on the command line, then restart Emacs for the changes to take effect -- or
;; use 'M-x doom/reload'.


;; To install SOME-PACKAGE from MELPA, ELPA or emacsmirror:
                                        ;(package! some-package)

;; To install a package directly from a remote git repo, you must specify a
;; `:recipe'. You'll find documentation on what `:recipe' accepts here:
;; https://github.com/raxod502/straight.el#the-recipe-format
                                        ;(package! another-package
                                        ;  :recipe (:host github :repo "username/repo"))

;; If the package you are trying to install does not contain a PACKAGENAME.el
;; file, or is located in a subdirectory of the repo, you'll need to specify
;; `:files' in the `:recipe':
                                        ;(package! this-package
                                        ;  :recipe (:host github :repo "username/repo"
                                        ;           :files ("some-file.el" "src/lisp/*.el")))

;; If you'd like to disable a package included with Doom, you can do so here
;; with the `:disable' property:
                                        ;(package! builtin-package :disable t)

;; You can override the recipe of a built in package without having to specify
;; all the properties for `:recipe'. These will inherit the rest of its recipe
;; from Doom or MELPA/ELPA/Emacsmirror:
                                        ;(package! builtin-package :recipe (:nonrecursive t))
                                        ;(package! builtin-package-2 :recipe (:repo "myfork/package"))

;; Specify a `:branch' to install a package from a particular branch or tag.
;; This is required for some packages whose default branch isn't 'master' (which
;; our package manager can't deal with; see raxod502/straight.el#279)
                                        ;(package! builtin-package :recipe (:branch "develop"))

;; Use `:pin' to specify a particular commit to install.
                                        ;(package! builtin-package :pin "1a2b3c4d5e")


;; Doom's packages are pinned to a specific commit and updated from release to
;; release. The `unpin!' macro allows you to unpin single packages...
                                        ;(unpin! pinned-package)
;; ...or multiple packages
                                        ;(unpin! pinned-package another-pinned-package)
;; ...Or *all* packages (NOT RECOMMENDED; will likely break things)
                                        ;(unpin! t)
;; (package! solaire-mode
;;   :disable t)
(package! blamer)
(package! dtrt-indent)
(package! flycheck-popup-tip :disable t)
(package! impatient-mode)
(package! xelb)
(package! telega)
(package! org-mime)
(package! scroll-on-jump)
(package! inf-elixir)
(package! evil-matchit)
(package! ox-reveal)
(package! org-present)
(package! exec-path-from-shell)
(package! evil-matchit)
(package! perfect-margin)
(package! company-web)
(package! all-the-icons-ivy-rich)
(package! consult-dir)
(package! command-log-mode)
(package! emamux)
(package! aggressive-indent)
(package! crux)
(package! dired-sidebar)
(package! slack)
(package! ob-restclient)
(package! ox-gfm)
;; Eshell goodies
(package! project-shells)
(package! esh-autosuggest)
(package! eshell-vterm)
(package! eshell-up)
(package! code-review)
(package! kaolin-themes)
(package! gruvbox-theme)
(package! ox-slack)
(package! request)
(package! blamer)
(package! dired-sidebar)
(package! smart-semicolon)
(package! counsel-tramp)
(package! x86-lookup)
(package! nasm-mode)
(package! dirvish)
(package! modus-themes)
(package! gruvbox-theme)
;;(package! icons-in-terminal
;;  :recipe (:host github :repo "seagle0128/icons-in-terminal.el"))
(package! inf-elixir)
(package! apheleia)
(package! visual-regexp)
(package! visual-regexp-steroids)
(package! evil-smartparens)
(package! edit-server)
(package! scrollkeeper)
(package! org-tree-slide)
(package! markdown-toc)
(package! counsel-tramp)
;;(package! chatgpt-shell
;;  :recipe (:host github
;;           :repo "xenodium/chatgpt-shell"))

;; (package! gptel
;;   :recipe (:host github
;;            :repo "karthink/gptel"))
(package! mix)
(package! org-modern)
(package! evil-textobj-tree-sitter)
