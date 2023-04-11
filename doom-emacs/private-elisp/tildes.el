;;; ../configfiles/.doom.d/tildes.el -*- lexical-binding: t; -*-
(setq tildes-mode-map
      (let ((map (make-sparse-keymap)))
        (define-key map (kbd "á") (lambda () (interactive) (insert "\\\'a")))
        (define-key map (kbd "é") (lambda () (interactive) (insert "\\\'e")))
        (define-key map (kbd "í") (lambda () (interactive) (insert "\\\'i")))
        (define-key map (kbd "ó") (lambda () (interactive) (insert "\\\'o")))
        (define-key map (kbd "ú") (lambda () (interactive) (insert "\\\'u")))))
(define-minor-mode tildes-mode
  "Al escribir una vocal con tilde la sustituye para que no rompa el paquete
   latex de la cátedra de Algo 2."
  nil
  :keymap tildes-mode-map
  :lighter "tildes")
(add-hook 'LaTeX-mode-hook 'tildes-mode)
;; (add-hook 'org-mode-hook 'tildes-mode)
(provide 'tildes-mode)
;;; tildes.el ends here
