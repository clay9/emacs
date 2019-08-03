(require 'expand-region)

(defun my-copy-region-as-kill (beg end &optional region)
  (interactive (list (mark) (point)
                     (prefix-numeric-value current-prefix-arg)))
  (let ((str (if region
                 (funcall region-extract-function nil)
               (filter-buffer-substring beg end))))
  (if (eq last-command 'kill-region)
        (kill-append str (< end beg))
      (kill-new str)))
  nil)

(defun my-expand-region ()
  (interactive)
  (er/expand-region 1)
  (my-copy-region-as-kill (region-beginning) (region-end)))

(defun my-contract-region ()
  (interactive)
  (er/contract-region 1)
  (my-copy-region-as-kill (region-beginning) (region-end)))


(provide 'init-expand-region)
