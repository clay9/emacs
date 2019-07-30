;;默认为regex搜索  
(setq search-default-mode t)

;;屏蔽普通搜索模式
(setq search-nonincremental-instead nil)

;;不可见区域 同样搜索
(setq isearch-hide-immediately nil)


;;occur函数重载
(defun my-occur (regexp &optional nlines)
  (interactive (occur-read-primary-args))
  (occur-1 regexp nlines (list (current-buffer)))
  (switch-to-buffer-other-window "*Occur*")
  ;;增加跳转到 第一个 匹配处
  (occur-next)
  )


(provide 'init-search)
