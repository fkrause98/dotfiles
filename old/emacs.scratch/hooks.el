(defun hooks//evil-hook()
  (dolist (mode '(custom-mode
                  eshell-mode
                  git-rebase-mode
                  erc-mode
                  circe-server-mode
                  circe-query-mode
                  sauron-mode
                  term-mode))))
(defun hooks//tree-sitter-hook ()
  (when (funcs//tree-sitter-has-lang major-mode)
    (tree-sitter-hl-mode)))
(defun hooks//aggressive-indent-hook ()
  (progn
    (electric-indent-mode -1)
    (electric-indent-local-mode -1)
    (aggressive-indent-mode)))
(defun hooks//prog-mode-hook
    (setq truncate-lines nil)
  (electric-pair-mode)
  (electric-indent-mode))
(defun hooks//elixir-hook ()
  (alchemist-mode))
