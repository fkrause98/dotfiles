;;; summary -- flycheck settings and download

(use-package flycheck
  :after lsp-mode
  :straight t
  :config
  (global-flycheck-mode)
  (setq flycheck-display-errors-function nil))
