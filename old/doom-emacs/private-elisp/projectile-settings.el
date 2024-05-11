;;; ../emacs-doom-config/private-elisp/projectile-settings.el -*- lexical-binding: t; -*-
(after! projectile
  (setq projectile-project-root-files-bottom-up
        (remove
         ".git"
         projectile-project-root-files-bottom-up)))
