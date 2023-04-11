;;; ../../emacs-doom-config/private-elisp/gpt.el -*- lexical-binding: t; -*-


;;; GPT related config
(setq chatgpt-shell-openai-key
      (plist-get (car (auth-source-search :host "openai.com"))
                 :secret))
;; (setq gptel-api-key
;;       chatgpt-shell-openai-key)
