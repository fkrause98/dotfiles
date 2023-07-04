(use-package web-mode
  :straight t
  :mode (("\\.html?\\'" . web-mode)
         ("\\.css\\'" . web-mode)
         ("\\.jsx\\'" . web-mode)
         ("\\.tsx\\'" . web-mode)
         ("\\.ts\\'" . web-mode)
         ("\\.vue\\'" . web-mode)
         ("\\.html.leex\\'" . web-mode)
         ("\\.html.heex\\'" . web-mode))
  :config
  (setq web-mode-markup-indent-offset 2
        web-mode-css-indent-offset 2
        web-mode-code-indent-offset 2
        web-mode-enable-auto-pairing t
        web-mode-enable-auto-closing t
        web-mode-enable-auto-opening t
        web-mode-enable-auto-indentation t
        web-mode-enable-auto-quoting t
        web-mode-enable-auto-expanding t
        web-mode-enable-auto-tag-face t
        web-mode-enable-current-element-highlight t
        web-mode-enable-current-column-highlight t
        web-mode-enable-css-colorization t
        web-mode-enable-comment-keywords t
        web-mode-enable-heredoc-fontification t
        web-mode-enable-engine-detection t
        web-mode-enable-part-face t
        web-mode-enable-block-face t
        web-mode-enable-variable-face t
        web-mode-enable-boolean-fontification t
        web-mode-enable-element-tag-fontification t
        web-mode-enable-element-content-fontification t
        web-mode-enable-html-entities-fontification t
        web-mode-enable-block-padding t
        web-mode-enable-buffer-local-variables t
        web-mode-enable-heredoc-fontification t
        web-mode-enable-inlays t
        web-mode-enable-sql-detection t
        web-mode-enable-string-interpolation t
        web-mode-enable-heredoc-fontification t
        web-mode-engines-alist
        '(("php"    . "\\.phtml\\'")
          ("blade"  . "\\.blade\\.")
          ("elixir" . "\\.html.heex\\'")
          ("elixir" . "\\.html.leex\\'")))) 
