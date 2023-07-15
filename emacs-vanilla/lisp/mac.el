;;; package --- Summary: Macos specific settings
;;; Get env from shell
(use-package exec-path-from-shell
  :defer t
  :straight t
  :init
  (when (memq window-system '(mac ns x))
	(exec-path-from-shell-initialize)))
