
;; 增加eshell搜索范围 -- 否则回报错误"找不到global"
(setenv "PATH" (concat (getenv "PATH") ":/usr/local/bin"))
(setq exec-path (append exec-path '("/usr/local/bin")))



(provide 'init-eshell)
