;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
(when (bound-and-true-p IS-MAC)
  (setq doom-font (font-spec :family "Liga SFMono Nerd Font" :size 12 :weight 'regular)
        doom-variable-pitch-font (font-spec :family "Liga SFMono Nerd Font" :size 13)))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'modus-vivendi)
;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(after! eglot
  (eglot-booster-mode))

(after! dape
  (setq dape-cwd-function 'projectile-project-root)
  (map! :map dap-mode-map
        :leader
        :prefix ("d" . "dap")
        :desc "dap hydra" "h" #'hydra-dap/body

        :desc "dap debug"   "s" #'dape
        :desc "dap quit"    "q" #'dape-quit
        :desc "dap restart" "r" #'dape-restart

        :desc "dap breakpoint toggle"     "b" #'dape-breakpoint-toggle
        :desc "dap breakpoint remove all" "B" #'dape-breakpoint-remove-all
        :desc "dap breakpoint log"        "l" #'dape-breakpoint-log

        :desc "dap continue" "c" #'dape-continue
        :desc "dap next"     "n" #'dape-next
        :desc "dap step in"  "i" #'dape-step-in
        :desc "dap step out" "o" #'dape-step-out

        :desc "dap eval" "e" #'dape-evaluate-expression))



(after! magit
  (map! :map magit-mode-map
        :nv "g$" #'magit-process-buffer))

;; Remove annoying docs
(setq lsp-signature-auto-activate nil)
(setq lsp-signature-render-documentation nil)
(after! lsp
  (defun lsp-booster--advice-json-parse (old-fn &rest args)
    "Try to parse bytecode instead of json."
    (or
     (when (equal (following-char) ?#)
       (let ((bytecode (read (current-buffer))))
         (when (byte-code-function-p bytecode)
           (funcall bytecode))))
     (apply old-fn args)))
  (advice-add (if (progn (require 'json)
                         (fboundp 'json-parse-buffer))
                  'json-parse-buffer
                'json-read)
              :around
              #'lsp-booster--advice-json-parse)

  (defun lsp-booster--advice-final-command (old-fn cmd &optional test?)
    "Prepend emacs-lsp-booster command to lsp CMD."
    (let ((orig-result (funcall old-fn cmd test?)))
      (if (and (not test?)                             ;; for check lsp-server-present?
               (not (file-remote-p default-directory)) ;; see lsp-resolve-final-command, it would add extra shell wrapper
               lsp-use-plists
               (not (functionp 'json-rpc-connection))  ;; native json-rpc
               (executable-find "emacs-lsp-booster"))
          (progn
            (message "Using emacs-lsp-booster for %s!" orig-result)
            (cons "emacs-lsp-booster" orig-result))
        orig-result)))

  (advice-add 'lsp-resolve-final-command :around #'lsp-booster--advice-final-command))

(setq shell-file-name "fish")

(setq-default line-spacing 4)

(after! compile
  (compilation-set-skip-threshold 2))

(after! rustic
  (add-hook! rustic-mode
             #'(lambda ()
                 (set-popup-rule! "^\\*rustic-compilation"
                   :side 'bottom
                   :size 0.5
                   :select t
                   :quit 'current)
                 (setq display-buffer-alist (assq-delete-all '^\\*rustic-compilation display-buffer-alist))
                 (setq compilation-skip-threshold 2))))



(after! cc-mode
  (set-eglot-client! 'cc-mode '("clangd" "-j=3" "--clang-tidy"))
  (setq c-default-style
        '((java-mode . "java")
          (awk-mode . "awk")
          (other . "cc-mode"))))
;; (with-eval-after-load 'evil
;;   (scroll-on-jump-advice-add evil-undo)
;;   (scroll-on-jump-advice-add evil-redo)
;;   (scroll-on-jump-advice-add evil-jump-item)
;;   (scroll-on-jump-advice-add evil-jump-forward)
;;   (scroll-on-jump-advice-add evil-jump-backward)
;;   (scroll-on-jump-advice-add evil-ex-search-next)
;;   (scroll-on-jump-advice-add evil-ex-search-previous)
;;   (scroll-on-jump-advice-add evil-forward-paragraph)
;;   (scroll-on-jump-advice-add evil-backward-paragraph)
;;   (scroll-on-jump-advice-add evil-goto-mark)

;;   ;; Actions that themselves scroll.
;;   (scroll-on-jump-with-scroll-advice-add evil-goto-line)
;;   (scroll-on-jump-with-scroll-advice-add evil-scroll-down)
;;   (scroll-on-jump-with-scroll-advice-add evil-scroll-up)
;;   (scroll-on-jump-with-scroll-advice-add evil-scroll-line-to-center)
;;   (scroll-on-jump-with-scroll-advice-add evil-scroll-line-to-top)
;;   (scroll-on-jump-with-scroll-advice-add evil-scroll-line-to-bottom))

;; (with-eval-after-load 'goto-chg
;;   (scroll-on-jump-advice-add goto-last-change)
;;   (scroll-on-jump-advice-add goto-last-change-reverse))

;; (global-set-key (kbd "<C-M-next>") (scroll-on-jump-interactive 'diff-hl-next-hunk))
;; (global-set-key (kbd "<C-M-prior>") (scroll-on-jump-interactive 'diff-hl-previous-hunk))

(use-package! gptel
  :config
  (setq gptel-model 'qwen2.5-coder:32b
        gptel-backend (gptel-make-ollama "Ollama"
                        :host "localhost:11434"
                        :stream t
                        :models '(qwen2.5-coder:32b))
        gptel-default-mode #'org-mode)
  (add-hook! gptel-post-stream 'gptel-auto-scroll)
  (map!
   :leader
   (:prefix-map ("o" . "open")
    :desc "Open GPT Chat"        "c" #'gptel
    :desc "GPT Menu"             "g" #'gptel-menu)))
