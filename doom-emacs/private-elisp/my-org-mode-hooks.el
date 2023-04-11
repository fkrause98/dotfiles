;;; org-mode-hooks.el -*- lexical-binding: t; -*-

(provide 'my-org-mode-hooks)
(add-hook 'org-mode-hook 'map-insert-text-in-math-mode)
(when (eq system-type 'gnu/linux)
  (add-hook 'org-mode-hook 'org-fragtog-mode))
(add-hook 'org-mode-hook '(lambda ()
                            (progn
                              (map-insert-environment)
                              (map-insert-math))))
(add-hook 'org-mode-hook '(lambda ()
                            (setq org-pretty-entities t)))
(add-hook 'org-mode-hook 'org-superstar-mode)
(add-hook 'org-mode-hook 'my-custom-entities-for-org)
(add-hook 'org-mode-hook
          #'(lambda ()
              (company-mode -1)))
