
;; 目录一栏
;; 0.helm-mode 1.helm-gtags
;; 2.symbol-overlay-mode  3.hs-hide-mode  4.speedbar  5.yasnippet
;; 6.artist-mode  7.org-agenda-mode 8.smartparens-mode

(require 'hydra) ;;使用hydra管理快捷键

;; *********************************
;; 0.helm-mode
;; *********************************
(require 'helm)
(require 'helm-config)
(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action)
(define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ;make TAB work in terminal
(define-key helm-map (kbd "C-z") 'helm-select-action)
(define-key helm-map (kbd "C-x k") 'helm-buffer-run-kill-buffers)


;; *********************************
;; 1.helm-gtags
;; *********************************
(require 'helm-gtags)
(defhydra hydra-helm-gtags (:color blue
                             :hint nil)
 "
_y_: 显示行号    _g_: 跳转行号
_h_: 上个位置    _j_: dwim    _k_: 查找函数    _l_: 查找变量
"
 ("y" linum-mode)
 ("g" goto-line)
 ("h" helm-gtags-pop-stack)
 ("j" helm-gtags-dwim)
 ("k" helm-gtags-find-rtag)
 ("l" helm-gtags-find-symbol))
(define-key helm-gtags-mode-map (kbd "C-j") 'hydra-helm-gtags/body)

;(define-key helm-gtags-mode-map (kbd "C-9") 'helm-gtags-pop-stack)
;(define-key helm-gtags-mode-map (kbd "C-0") 'helm-gtags-dwim)
;(define-key helm-gtags-mode-map (kbd "C--") 'helm-gtags-find-symbol)
;(define-key helm-gtags-mode-map (kbd "C-=") 'helm-gtags-find-rtag)


;; *********************************
;; 2.symbol-overlay-mode
;; *********************************
(require 'symbol-overlay)
(defhydra hydra-symbol-overlay (:color blue
                             :hint nil)
 "
^高亮^               ^跳转^                   ^操作^
^^^^^^-----------------------------------------------------------------
_i_: 高亮            _n_: 下一个位置          _w_: 复制
^ ^                  _p_: 上一个位置          _q_: 查找并替换
^ ^                  ^ ^                      _r_: 全部替换
"
 ("i" symbol-overlay-put)
 ("n" symbol-overlay-jump-next)
 ("p" symbol-overlay-jump-prev)
 ("w" symbol-overlay-save-symbol)
 ("q" symbol-overlay-query-replace)
 ("r" symbol-overlay-rename))
(define-key symbol-overlay-map (kbd "\C-c j") 'hydra-symbol-overlay/body)


;; *********************************
;; 3.hs-minor-mode
;; *********************************
(require 'hideshow)
(require 'init-hs-minor-mode)
(define-key hs-minor-mode-map (kbd "<backtab>") 'my-hs-shift-tab);; Shift + Tab


;; *********************************
;; 4.speedbar
;; *********************************
(require 'speedbar)
(define-key speedbar-mode-map (kbd "u") 'speedbar-up-directory);;移动至上层目录, 类似info


;; *********************************
;; 5.yasnippet
;; *********************************
(require 'yasnippet)
(defhydra hydra-yas-minor (:color blue
				  :hint nil)
"
ya-snippet mode
_i_: 增加   _v_: 查看
"
("i" yas-new-snippet)
("v" yas-visit-snippet-file))
(define-key yas-minor-mode-map (kbd "\C-c s") 'hydra-yas-minor/body)


;; *********************************
;; 6.artist-mode
;; *********************************
(artist-mode 1)
(define-key artist-mode-map (kbd "SPC") 'org-self-insert-command)
(define-key artist-mode-map (kbd "RET") 'org-return)
(define-key artist-mode-map (kbd "DEL") 'org-delete-backward-char)
(define-key artist-mode-map (kbd "TAB") 'org-cycle)

;; 修改默认快捷键
(require 'artist)
(defhydra hydra-artist-mode (:color blue
                             :hint nil)
 "
_o_: 起点,终点
_l_: 线      _p_: 直线
_r_: 四边形  _s_: 正方形
_e_: 椭圆    _c_: 圆
_y_: 水雾
"
 ("o" artist-key-set-point)

 ("l" artist-select-op-line)
 ("p" artist-select-op-poly-line)

 ("r" artist-select-op-rectangle)
 ("s" artist-select-op-square)

 ("e" artist-select-op-ellipse)
 ("c" artist-select-op-circle)

 ("y" artist-select-op-spray-can))
(define-key artist-mode-map (kbd "\C-c g") 'hydra-artist-mode/body)


;; *********************************
;; 7.org-agenda-mode
;; *********************************
(require 'org-agenda)
(define-key org-agenda-mode-map (kbd "m") 'org-agenda-bulk-mark)       ;mark
(define-key org-agenda-mode-map (kbd "M") 'org-agenda-bulk-mark-all)   ;mark all
(define-key org-agenda-mode-map (kbd "u") 'org-agenda-bulk-unmark)     ;unmark
(define-key org-agenda-mode-map (kbd "U") 'org-agenda-bulk-unmark-all) ;unmark all

(define-key org-agenda-mode-map (kbd "a") 'my-org-agenda-bulk-action)     ;执行动作

;; agenda buffer 操作
(define-key org-agenda-mode-map (kbd "C-,") 'my-org-agenda-back)
(define-key org-agenda-mode-map (kbd "C-.") 'my-org-agenda-forward)


;; *********************************
;; 8.smartparens
;; *********************************
(require 'smartparens)
(defhydra hydra-smartparens (:color blue
				    :hint nil)
 "
^高亮^               ^跳转^                   ^操作^
^^^^^^-----------------------------------------------------------------
_p_: 上一个sexp      _n_: 下一个sexp          ^ ^
_b_: sexp开头        _f_: sexp结尾            ^ ^
_k_: kill sexp       _w_: copy sexp           ^ ^
_m_: wrap sexp       _u_: unwrap sexp         _r_: rewrap sexp
"
 ("p" sp-forward-sexp)
 ("n" sp-backward-sexp)
 ("b" sp-beginning-of-sexp)
 ("f" sp-end-of-sexp)
 ("k" sp-kill-sexp)
 ("w" sp-copy-sexp)
 ("m" sp-wrap-round)
 ("u" sp-unwrap-sexp)
 ("r" sp-rewrap-sexp))
(define-key smartparens-mode-map (kbd "\C-c /") 'hydra-smartparens/body)


(provide 'init-local-shortkey)
