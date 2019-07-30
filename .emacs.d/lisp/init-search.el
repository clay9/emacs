;;默认为regex搜索  
(setq search-default-mode t)

;;屏蔽普通搜索模式
(setq search-nonincremental-instead nil)

;;不可见区域 同样搜索
(setq isearch-hide-immediately nil)


;;occur函数重载
(defun my-occur ()
  (interactive)
  (occur "hide" nil)
  (switch-to-buffer-other-window "*Occur*")
  )


(provide 'init-search)
