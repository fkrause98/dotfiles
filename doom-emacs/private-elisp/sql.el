;;; ../emacs-doom-config/private-elisp/sql.el -*- lexical-binding: t; -*-


;;; SQL
(add-hook 'sql-interactive-mode-hook
          (lambda ()
            (toggle-truncate-lines)))
