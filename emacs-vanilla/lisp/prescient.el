;;; package -- prescient
;; Intelligent sorting w/ Ivy and counsel
(use-package prescient
  :straight t)
(use-package ivy-prescient
  :straight t
  :after (prescient ivy)
  :config
  (ivy-prescient-mode 1)
  (prescient-persist-mode 1))
(use-package company-prescient
  :straight t
  :after (prescient company)
  :config
  (company-prescient-mode 1))
  
;; (straight-use-package 'prescient)
;; (straight-use-package 'ivy-prescient)
;; (straight-use-package 'company-prescient)
;; Company integration
;; (company-prescient-mode 1)
