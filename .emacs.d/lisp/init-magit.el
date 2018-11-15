
(require 'magit)

;; git status的时候 buffer 全屏
(defun my-delete-ohter-windows()
  (delete-other-windows))

(magit-add-section-hook 'magit-status-sections-hook 'my-delete-ohter-windows)



(provide 'init-magit)
