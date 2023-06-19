;;; package -- prescient
;; Intelligent sorting w/ Ivy and counsel
(straight-use-package 'prescient)
(straight-use-package 'ivy-prescient)
(straight-use-package 'company-prescient)
;; Remember candidate frequencies across sessions
;;(prescient-persist-mode 1)
;; Ivy-integration
(ivy-prescient-mode 1)
;; Company integration
(company-prescient-mode 1)
