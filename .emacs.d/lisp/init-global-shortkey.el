
;; 目录一栏
;; 0.前缀操作  1.对象操作  2.内容显示  3.GTD


;; *********************************
;; 1. 对象操作
;; 未标明委托mode的为emacs内置
;; *********************************
;; tag对象 string
(global-set-key (kbd "C-t") 'replace-string);;替换

;; tag对象 region
(global-set-key (kbd "C-w") 'kill-region)

;; tag对象 sexp
(global-set-key (kbd "C-M-f") 'forward-sexp)
(global-set-key (kbd "C-M-b") 'backward-sexp)
(global-set-key (kbd "C-M-k") 'kill-sexp)
(global-set-key (kbd "C-M-m") 'mark-sexp)

;; tag对象 function
(global-set-key (kbd "C-M-a") 'beginning-of-defun)
(global-set-key (kbd "C-M-e") 'end-of-defun)
(global-set-key (kbd "C-M-n") 'nil)
(global-set-key (kbd "C-M-p") 'nil)
;; TODONOW 1.C-M-n  2.C-M-p 待定

;; Tag对象 buffer -- 委托: helm-mode
(global-set-key (kbd "C-x C-b") 'helm-buffers-list)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "C-x C-s") 'save-buffer)
(global-set-key (kbd "C-x b") 'nil)
(global-set-key (kbd "C-x f") 'nil)
(global-set-key (kbd "C-x s") 'nil)
;;TODONOW 1.C-x b  2.C-x f  3.C-x s 待定


;; *********************************
;; 2. 文本显示
;; *********************************
(global-set-key (kbd "C-,") 'linum-mode)
(global-set-key (kbd "C-.") 'goto-line)


;; *********************************
;; 3. GTD -- 委托: org-mode
;; *********************************
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c c") 'org-capture)
;;非agenda 模式, 不常用
(global-set-key (kbd "C-c C-w") 'org-refile)
(global-set-key (kbd "C-c C-y") 'org-archive-subtree)
;;agenda 模式, 常用
(global-set-key (kbd "C-c w") 'org-agenda-refile)
(global-set-key (kbd "C-c y") 'org-agenda-archive)

;;TODONOW 1.org-refile  2.org-archive-subtree  其实只对org-mode生效


;; *********************************
;; 其他
;; *********************************
(global-set-key (kbd "C-z") 'nil); suspend-frame最小化在X下作用不大
(global-set-key (kbd "s-n") 'nil); ns-new-frame new-frame不受现在配置影响, 因此删除

(global-set-key (kbd "M-x") 'helm-M-x)

(global-set-key (kbd "C-x C-;") 'sr-speedbar-toggle)

(global-set-key (kbd "C-'")  'hydra-symbol-overlay/body) ;;语法高亮
(global-set-key (kbd "C-j")  'hydra-helm-gtags/body) ;;
(global-set-key (kbd "C-;")  'hydra-yas-minor/body) ;; yasnippets前缀




(provide 'init-global-shortkey)
