(require 'package)
(setq package-user-dir (expand-file-name "./.packages"))
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("gnu" . "https://elpa.gnu.org/packages/")))
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

(package-install 'htmlize)

(setq org-html-validation-link nil
      org-html-head-include-scripts nil
      org-html-head-include-default-style nil
      org-html-head "<link rel=\"stylesheet\" type=\"text/css\" href=\"https://cdn.simplecss.org/simple.min.css\" />")
      ;; org-html-head "<link rel=\"stylesheet\" type=\"text/css\" href=\"https://cdn.simplecss.org/simple.min.css\" />")

(require 'ox-publish)
(setq org-publish-project-alist
      (list
       (list "my-org-site"
             :recursive t
             :base-directory "~/org/"
             :publishing-directory "~/blog/"
             :publishing-function 'org-html-publish-to-html
             :with-author nil
             :with-creator t
             :with-toc nil
             :section-numbers nil
             :time-stamp-file nil
             :language "en")))
;; Generate the site output
(org-publish-all t)
(message "Build Complete!")
;; Customize HTML output
(provide 'build-site)
;;; build-site.el ends here
