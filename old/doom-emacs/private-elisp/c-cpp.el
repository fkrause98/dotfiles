;;; ../emacs-doom-config/private-elisp/c-cpp.el -*- lexical-binding: t; -*-

;;; C++ settings
(setq c-default-style "stroustrup")
(add-hook 'c++-mode-hook
          (lambda ()
            (progn
              (setq
               company-minimum-prefix-length 4
               tab-width 4
               evil-shift-width 4))))
;;Black magic
(setq lsp-clients-clangd-args '("-j=3" "--cross-file-rename" "--background-index"
                                "--completion-style=bundled" "--header-insertion=never"
                                "--limit-results=80"))
(setq org-latex-listings 'minted
      org-latex-packages-alist '(("" "minted"))
      org-latex-pdf-process '("pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
                              "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
                              "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"))
(setq org-latex-minted-options '(("breaklines" "true")
                                 ("breakanywhere" "true")))
