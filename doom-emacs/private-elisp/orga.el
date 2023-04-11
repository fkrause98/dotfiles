;;; ../emacs-doom-config/private-elisp/orga.el -*- lexical-binding: t; -*-

(defun sys-call-table ()
  (interactive)
  (async-shell-command "open  https://faculty.nps.edu/cseagle/assembly/sys_call.html"))

(set-lookup-handlers! 'nasm-mode
  :documentation 'x86-lookup)

(add-to-list 'auto-mode-alist  '("\\.asm\\'" . nasm-mode))
