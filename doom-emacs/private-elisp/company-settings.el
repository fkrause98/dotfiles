;;; ../emacs-doom-config/private-elisp/company-settings.el -*- lexical-binding: t; -*-

(setq company-idle-delay 0.2
      company-show-numbers t
      company-tooltip-limit 10
      company-minimum-prefix-length 4
      company-tooltip-align-annotations t
      company-tooltip-flip-when-above nil
      c-syntactic-indentation t)
(setq company-idle-delay 0.3)
(setq company-show-numbers t)
(setq company-tooltip-limit 10)
(setq company-minimum-prefix-length 2)
(setq company-tooltip-align-annotations t)
;; invert the navigation direction if the the completion popup-isearch-match
;; is displayed on top (happens near the bottom of windows)
(setq company-tooltip-flip-when-above t)
