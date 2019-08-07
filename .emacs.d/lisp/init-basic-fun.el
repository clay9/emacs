
(setq yank-point 0)
(defun my-yank-pop()
  "Used by Fun:my-yank
  Fcuntion: yank-pop && record point"
  (yank-pop)
  (setq yank-point (point)))
(defun my-yank ()
  "Used by user, key: C-y
   Function: first call yank; then call yank-pop"
  (interactive)
  ;; after yank && position not change, call yank-pop
  (if (= (point) yank-point)
      (my-yank-pop)
    (yank)
    (setq yank-point (point))
    ))

(provide 'init-basic-fun)
