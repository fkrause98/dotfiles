(use-package inf-ruby
  :commands (inf-ruby))

(use-package rubocopfmt
  :hook
  (ruby-mode . rubocopfmt-mode))

(use-package rake
  :commands (rake))
