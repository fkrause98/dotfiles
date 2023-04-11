(defun random-banner-image (banners-directory)
  ;; A function to return a random banner from a folder.
  (setq splash-images (directory-files-recursively
                       (expand-file-name banners-directory
                                         doom-private-dir)
                       ".*png"))
  (setq index-random-image
        (random (length splash-images)))
  (setq fancy-splash-image
        (nth index-random-image splash-images)))

(provide 'random-banner)
