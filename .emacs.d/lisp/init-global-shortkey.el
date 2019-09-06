(require 'hydra) ;;使用hydra管理快捷键

;; 目录一栏
;; 1.对象操作  2.内容显示  3.GTD


;; ****************************************************
;; 1. 对象操作
;; ****************************************************
;; char, words 
(require 'init-search)
(defhydra hydra-search (:color blue
                               :hint nil)
"
_a_: 查找全部    _r_: 向前查找    _s_: 向后查找
"
 ("a" helm-occur)
 ("r" isearch-backward)
 ("s" isearch-forward)
 ("t" replace-string))
(global-set-key (kbd "C-s") 'hydra-search/body)

;; region
(require 'init-expand-region)
(global-set-key (kbd "C-w") 'kill-region)         ;;kill
(global-set-key (kbd "C-y") 'my-yank)             ;;yank && yank-pop

(global-set-key (kbd "C-=") 'my-expand-region)    ;;putty不支持C--
(global-set-key (kbd "C--") 'my-contract-region)  ;;putty不支持C-=


;; buffer, file
(global-set-key (kbd "C-x b") 'helm-buffers-list)
(global-set-key (kbd "C-x C-b") 'helm-browse-project)
(global-set-key (kbd "C-x f") 'helm-find-files)
(global-set-key (kbd "C-x s") 'save-buffer)

(global-set-key (kbd "C-x a") 'beginning-of-buffer)   ;; beg of buffer
(global-set-key (kbd "C-x e") 'end-of-buffer)         ;; end of buffer

;; frame
(global-set-key (kbd "C-x o") 'window-number-switch)

;; minor buffer
(global-set-key (kbd "M-x") 'helm-M-x)


;; ****************************************************
;; 3. GTD -- 委托: org-mode
;; ****************************************************
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c c") 'org-capture)
;(global-set-key (kbd "C-c w") 'org-agenda-refile) 以后在C-c a i界面中处理refile


;; ****************************************************
;; others
;; ****************************************************
(global-set-key (kbd "C-z") 'nil); suspend-frame最小化在X下作用不大
(global-set-key (kbd "s-n") 'nil); ns-new-frame new-frame不受现在配置影响, 因此删除


(provide 'init-global-shortkey)
