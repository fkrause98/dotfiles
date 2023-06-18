;;; package --- Summary: Macos specific settings
;;; Macos-copy-paste
(use-package pbcopy)
(turn-on-pbcopy)
;;; Get env from shell
(use-package exec-path-from-shell
  :defer t
  :ensure t
  :init
  (when (memq window-system '(mac ns x))
	(exec-path-from-shell-initialize)))
