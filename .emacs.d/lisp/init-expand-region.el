(require 'expand-region)


;; ****************************************************
;; Overloaded Function
;; ****************************************************
(defun my-copy-region-as-kill (beg end &optional region)
  "Used for Fun: my-expand-region, my-contract-region
  Change: when copy, no longer unmark the region
  Origin: Copy an unmark the region"
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
  "Used by User
   Change: copy the region when marked
   Oringe: expand region"
  (interactive)
  (er/expand-region 1)
  (my-copy-region-as-kill (region-beginning) (region-end)))

(defun my-contract-region ()
  "Used by User
   Change: copy the region when marked
   Origin: contract region"
  (interactive)
  (er/contract-region 1)
  (my-copy-region-as-kill (region-beginning) (region-end)))


(provide 'init-expand-region)
