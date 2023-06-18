;;; package -- prescient
;; Intelligent sorting w/ Ivy and counsel
(use-package prescient)
(use-package ivy-prescient
  :requires (ivy counsel prescient)
  :after counsel
  :init
  (setq ivy-prescient-enable-filtering nil)
  :config
  (ivy-prescient-mode 1))
(use-package company-prescient
  :after company
  :config
  (company-prescient-mode 1))
