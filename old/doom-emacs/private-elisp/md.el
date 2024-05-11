;;; ../../emacs-doom-config/private-elisp/md.el -*- lexical-binding: t; -*-

;;; Markdown
(custom-set-variables '(livedown-autostart nil) ; automatically open preview when opening markdown files
                      '(livedown-open t) ; automatically open the browser window
                      '(livedown-port 1337)         ; port for livedown server
                      '(livedown-browser 'firefox)) ; browser to use
;; Grip
(setq browse-url-generic-program "firefox" grip-preview-use-webkit nil)
