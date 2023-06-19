;;; package -- prescient
;; Intelligent sorting w/ Ivy and counsel
(use-package prescient
  :config
  ;; Remember candidate frequencies across sessions
  (prescient-persist-mode 1))
(use-package ivy-prescient
  :hook ivy-mode
  :after ivy-mode
  :init
  (setq ivy-prescient-enable-filtering nil)
  :config
  (ivy-prescient-mode 1))
(use-package company-prescient
  :hook company-mode
  :after company
  :config
  (company-prescient-mode 1))

