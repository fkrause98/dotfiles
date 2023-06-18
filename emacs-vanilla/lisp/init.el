;;; Load package manager config
(load "~/.emacs.d/package-manager-settings.el")
;;; Better GC for Emacs
(load "~/.emacs.d/garbage-collection.el")
;;; Load editor settings
(load "~/.emacs.d/settings.el")
;;; Interactive text sorting and filtering
(load "~/.emacs.d/ivy-counsel-swiper.el")
;;; Customized sorting
(load "~/.emacs.d/prescient.el")
;;; Some non-related (between them) packages
(load "~/.emacs.d/packages.el")
;;; A proper editor for Emacs
(load "~/.emacs.d/evil.el")
;;; General keybinds
(load "~/.emacs.d/general.el")
;;; Project management
(load "~/.emacs.d/project.el")
;;; Git management
(load "~/.emacs.d/git.el")
;;; Lsp settings
(load "~/.emacs.d/lsp.el")
;;; Autocomplete
(load "~/.emacs.d/company.el")
;;; Mac-os specific settings
(load "~/.emacs.d/mac.el")
;;; Lang settings
(load "~/.emacs.d/elixir.el")
(load "~/.emacs.d/rust.el")
(load "~/.emacs.d/tree-sitter.el")
;;; Terminals
(load "~/.emacs.d/term.el")
;;; Custom funcs
(load "~/.emacs.d/custom-funcs.el")

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("e5a748cbefd483b74b183d7da4fca6228207a6bf9be9792dc85403a186724e1f" "628278136f88aa1a151bb2d6c8a86bf2b7631fbea5f0f76cba2a0079cd910f7d" "06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a" "4cf3221feff536e2b3385209e9b9dc4c2e0818a69a1cdb4b522756bcdf4e00a4" "4aee8551b53a43a883cb0b7f3255d6859d766b6c5e14bcb01bed572fcbef4328" "1a1ac598737d0fcdc4dfab3af3d6f46ab2d5048b8e72bc22f50271fd6d393a00" "e3daa8f18440301f3e54f2093fe15f4fe951986a8628e98dcd781efbec7a46f2" "5f128efd37c6a87cd4ad8e8b7f2afaba425425524a68133ac0efd87291d05874" default))
 '(package-selected-packages
   '(company-prescient ivy-prescient evil-smartparens smartparens elixir-mode elixir evil-surround tree-sitter-langs tree-sitter gcmh scroll-on-jump company-box company evil-nerd-commenter lsp-ui pbcopy flycheck perfect-margin perect-margin-mode rustic popper lsp-ivy lsp-mode projectile evil color-theme-sanityinc-tomorrow color-theme-sanityinc-solarized doom-themes helpful counsel ivy-rich which-key rainbow-delimiters simple-modeline swiper ivy command-log-mode commnad-log-mode use-package)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(defun counsel-flycheck ()
  "Navigate to flycheck errors"
  (interactive)
  (if (not (bound-and-true-p flycheck-mode))
      (message "Flycheck mode is not available or enabled")
    (ivy-read "Error: "
	      (let ((source-buffer (current-buffer)))
		(with-current-buffer
		    (or (get-buffer flycheck-error-list-buffer)
			(progn
			  (with-current-buffer
			      (get-buffer-create flycheck-error-list-buffer)
			    (flycheck-error-list-mode)
			    (current-buffer))))
		  (flycheck-error-list-set-source source-buffer)
		  (flycheck-error-list-reset-filter)
		  (revert-buffer t t t)
		  (split-string (buffer-string) "\n" t " *")))
	      :action
	      (lambda (s &rest _)
		(when-let*
		    ((the-error (get-text-property 0 'tabulated-list-id s))
		     (pos (flycheck-error-pos the-error)) )
		  (goto-char (flycheck-error-pos the-error))))
	      :history 'counsel-flycheck-history)))





