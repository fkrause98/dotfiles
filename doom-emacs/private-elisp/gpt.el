;;; ../../emacs-doom-config/private-elisp/gpt.el -*- lexical-binding: t; -*-


;;; GPT related config
(after! chatgpt-shell
  (setq chatgpt-shell-openai-key
        (plist-get (car (auth-source-search :host "openai.com"))
                   :secret)))
