;;; private-elisp/my-org-bindings.el -*- lexical-binding: t; -*-
;;; Save current org mode and export it to pdf via latex.
(defun save-and-export ()
  (interactive)
  (if (eq major-mode 'org-mode)
  (progn
  (save-buffer)
  (org-latex-export-to-pdf))
  (message "You're not using org mode right now...")))
(map! "<f5>" 'save-and-export)

(defun insert-math-org()
  "Insert LaTeX's math mode parenthesis"
  (interactive)
  (insert "\\\( \\\) ")
  (backward-char 4))
(defun map-insert-math()
  (interactive)
  (map! :leader
        :desc "Insert parenthesis for LaTeX's math mode"
        "i m" #'insert-math-org))
(defun map-insert-environment()
  (map! :leader
        :desc "Insert a latex environment in Org mode"
        :n "i e" #'org-cdlatex-environment-indent))
(defun insert-text-math-mode ()
  (interactive)
  (insert "\\text\{ \}")
  (backward-char 2))
(defun map-insert-text-in-math-mode()
  (interactive)
  (map! :leader
        :desc "Insert \\text{} in Org's latex snippets"
        :n "i t"#'insert-text-math-mode))
(defun my-custom-entities-for-org ()
  (setq org-entities-user nil)
  (progn
    (add-to-list 'org-entities-user  (list "iff" "\\iff" t "" "<->" "" "⇔"))
    (add-to-list 'org-entities-user  (list "implies" "\\implies" t "" "->" "" "⇒"))
    (add-to-list 'org-entities-user  (list "vDash" "\\vDash" t "" "" "|=" "⊨"))
    (add-to-list 'org-entities-user  (list "nvDash" "\\nvDash" t "" "" "no|=" "⊭"))
    (add-to-list 'org-entities-user  (list "phi" "\\varphi" t "" "" "" "φ"))
    (add-to-list 'org-entities-user  (list "vdash" "\\vdash" t "" "" "|-" "⊢"))
    (add-to-list 'org-entities-user  (list "nvdash" "\\nvdash" t "" "" "no|-" "⊬"))
    (add-to-list 'org-entities-user  (list "subseteq" "\\subseteq" t "" "" "" "⊆"))
    (add-to-list 'org-entities-user  (list "N" "\\mathbb{N}" t "" "" "" "ℕ"))
    (add-to-list 'org-entities-user  (list "Z" "\\mathbb{Z}" t "" "" "" "ℤ"))
    (add-to-list 'org-entities-user  (list "Q" "\\mathbb{Q}" t "" "" "" "ℚ "))
    (add-to-list 'org-entities-user  (list "R" "\\mathbb{R}" t "" "" "" "ℝ"))
    (add-to-list 'org-entities-user  (list "C" "\\mathbb{C}" t "" "" "" "ℂ"))))
(setq org-return-follows-link t)
(provide 'my-org-bindings)
