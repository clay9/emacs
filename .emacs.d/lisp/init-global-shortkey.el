(require 'hydra) ;;使用hydra管理快捷键
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

;; Tag对象 buffer -- 委托: helm-mode
(global-set-key (kbd "C-x a") 'backward-page)
(global-set-key (kbd "C-x e") 'forward-page)

(global-set-key (kbd "C-x p") 'previous-multiframe-window)
(global-set-key (kbd "C-x n") 'next-multiframe-window)

(global-set-key (kbd "C-x b") 'helm-buffers-list)
(global-set-key (kbd "C-x f") 'helm-find-files)
(global-set-key (kbd "C-x s") 'save-buffer)
(global-set-key (kbd "C-x C-b") 'nil)
(global-set-key (kbd "C-x C-f") 'nil)
(global-set-key (kbd "C-x C-s") 'nil)


;; *********************************
;; 3. GTD -- 委托: org-mode
;; *********************************
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c c") 'org-capture)
;;agenda 模式, 常用
(global-set-key (kbd "C-c w") 'org-agenda-refile)
(global-set-key (kbd "C-c y") 'org-agenda-archive)


;; *********************************
;; 其他
;; *********************************
(require 'expand-region)
(global-set-key (kbd "C-=") 'er/expand-region)
(global-set-key (kbd "C--") 'er/contract-region)


(global-set-key (kbd "C-z") 'nil); suspend-frame最小化在X下作用不大
(global-set-key (kbd "s-n") 'nil); ns-new-frame new-frame不受现在配置影响, 因此删除
(global-set-key (kbd "C-9") 'nil)
(global-set-key (kbd "C-0") 'nil)


(global-set-key (kbd "M-x") 'helm-M-x)



(defhydra hydra-search (:color blue
                               :hint nil)
"
_a_: 查找全部    _r_: 向前查找    _s_: 向后查找
"
 ("a" my-occur)
 ("r" isearch-backward)
 ("s" isearch-forward))
(global-set-key (kbd "C-s") 'hydra-search/body)



(provide 'init-global-shortkey)
