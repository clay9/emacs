(require 'bookmark)


(setq bookmark-automatically-show-annotations nil)

(defun bookmark-to-abbrevs ()
  "Create abbrevs based on `bookmark-alist'."
  (interactive)
  (dolist (bookmark bookmark-alist)
    (let* ((name (car bookmark))
	   (file (bookmark-get-filename name)))
      (define-abbrev global-abbrev-table name file))))


(provide 'init-bookmark)
