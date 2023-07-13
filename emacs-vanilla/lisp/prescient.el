;;; package -- prescient
;; Intelligent sorting w/ Ivy and counsel
(use-package prescient
  :straight t
  :config
  (prescient-persist-mode 1))

(use-package vertico-prescient
  :straight t
  :after (prescient)
  :config
  (vertico-prescient-mode))

(use-package company-prescient
  :straight t
  :after (company)
  :config
  (company-prescient-mode 1))

