;;; init --- init.el

;;; Commentary:

;;; Code:

;(package-initialize)

(org-babel-load-file
 (expand-file-name "init-org.org"
                   user-emacs-directory))

(provide 'init)
;;; init.el ends here
