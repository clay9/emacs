(require 'hydra) ;;使用hydra管理快捷键

;; 目录一栏
;; 0.helm-mode 1.helm
;; 2.symbol-overlay-mode  3.hs-hide-mode  4.speedbar  5.yasnippet
;; 6.artist-mode  7.org-agenda-mode 8.smartparens-mode
;; 9.compilation-mode 10.search (ocuur)


;; ****************************************************
;; 0.helm-mode
;; ****************************************************
(require 'helm)
(require 'helm-config)
(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action)
(define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ;make TAB work in terminal
(define-key helm-map (kbd "C-z") 'helm-select-action)
(define-key helm-map (kbd "C-x k") 'helm-buffer-run-kill-buffers)


;; ****************************************************
;; 1.helm-gtags
;; ****************************************************
(require 'helm-gtags)
(require 'init-expand-region)
(defhydra hydra-helm-gtags (:color blue
                             :hint nil)
 "
**************** Symbol Overlay **********************************
_i_: 高亮        _w_: 复制        _r_: 全部替换
_n_: 下个位置    _p_:上个位置

*****************  helm gtags  ***********************************
_h_: 上个位置    _j_: dwim        _k_: 查找函数    _l_: 查找变量

*******************  others  *************************************
_g_: 跳转行号
"
 ;;
 ("i" symbol-overlay-put)
 ("w" symbol-overlay-save-symbol)
 ("r" symbol-overlay-rename)
 ("n" symbol-overlay-jump-next)
 ("p" symbol-overlay-jump-prev)
 ;;
 ("h" helm-gtags-pop-stack)
 ("j" helm-gtags-dwim)
 ("k" helm-gtags-find-rtag)
 ("l" helm-gtags-find-symbol)
 ;;
 ("g" goto-line))
(define-key helm-gtags-mode-map (kbd "C-j") 'hydra-helm-gtags/body)


;; ****************************************************
;; 2.symbol-overlay-mode
;; ****************************************************
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
;;(define-key symbol-overlay-map (kbd "\C-c j") 'hydra-symbol-overlay/body)


;; ****************************************************
;; 3.hs-minor-mode
;; ****************************************************
(require 'init-hs-minor-mode)
(define-key hs-minor-mode-map (kbd "<backtab>") 'my-hs-shift-tab);;shift + tab


;; ****************************************************
;; 4.speedbar
;; ****************************************************
(require 'speedbar)
(define-key speedbar-mode-map (kbd "u") 'speedbar-up-directory);;移动至上层目录, 类似info


;; ****************************************************
;; 5.yasnippet
;; ****************************************************
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


;; ****************************************************
;; 6.artist-mode
;; ****************************************************
(require 'init-artist-mode)
;;(define-key artist-mode-map (kbd "SPC") 'org-self-insert-command)
;;(define-key artist-mode-map (kbd "RET") 'org-return)
;;(define-key artist-mode-map (kbd "DEL") 'org-delete-backward-char)
;;(define-key artist-mode-map (kbd "TAB") 'org-cycle)

(defhydra hydra-artist-mode (:color blue
                             :hint nil)
 "
_l_: 线      _p_: 直线
_r_: 四边形  _s_: 正方形
_e_: 椭圆    _c_: 圆
_w_: cut     _y_: yank    _k_: kill
"
 ("l" artist-select-op-line)
 ("p" artist-select-op-poly-line)
 ("r" artist-select-op-rectangle)
 ("s" artist-select-op-square)
 ("e" artist-select-op-ellipse)
 ("c" artist-select-op-circle)
; ("y" artist-select-op-spray-can) ;;水雾
; ("t" artist-select-op-text-overwrite) ;;艺术字
; ("T" artist-select-op-text-see-thru)  ;; 艺术字
; ("f" artist-select-op-flood-fill) ;;洪水效果, 填充整个图
 ("w" artist-select-op-cut-rectangle)
 ("y" artist-select-op-paste)
 ("k" artist-select-op-erase-rectangle))
(define-key artist-mode-map (kbd "C-j") 'hydra-artist-mode/body)


;; ****************************************************
;; 7.org-agenda-mode
;; ****************************************************
(require 'init-org-gtd)
;; agenda buffer keys
(define-key org-agenda-mode-map (kbd "m") 'org-agenda-bulk-mark)       ;mark
(define-key org-agenda-mode-map (kbd "M") 'org-agenda-bulk-mark-all)   ;mark all
(define-key org-agenda-mode-map (kbd "u") 'org-agenda-bulk-unmark)     ;unmark
(define-key org-agenda-mode-map (kbd "U") 'org-agenda-bulk-unmark-all) ;unmark all
(define-key org-agenda-mode-map (kbd "a") 'org-agenda-bulk-action)     ;action
(define-key org-agenda-mode-map (kbd "r") 'my-org-agenda-redo)         ;refresh

(define-key org-agenda-mode-map (kbd "C-p") 'org-agenda-previous-item) ;previous item
(define-key org-agenda-mode-map (kbd "C-n") 'org-agenda-next-item)     ;next item

;; agenda buffer选择
;(define-key org-agenda-mode-map (kbd "C-p") 'my-org-agenda-back)
(define-key org-agenda-mode-map (kbd "SPC") 'my-org-agenda-forward)
(define-key org-agenda-mode-map (kbd "<spc>") 'my-org-agenda-forward)

(define-key org-agenda-mode-map (kbd "TAB") 'my-org-agenda-show)
(define-key org-agenda-mode-map (kbd "<tab>") 'my-org-agenda-show)

;; agenda mode
(define-key org-mode-map (kbd "M-n") 'org-next-visible-heading)
(define-key org-mode-map (kbd "M-p") 'org-previous-visible-heading)

(define-key org-mode-map (kbd "C-c j") 'org-edit-special)         ;editor for the element at point
(define-key org-src-mode-map (kbd "C-c j") 'org-edit-src-exit)    ;exit when in src block


;; ****************************************************
;; 8.smartparens
;; ****************************************************
(require 'init-smartparens-mode)
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
;(define-key smartparens-mode-map (kbd "\C-c /") 'hydra-smartparens/body)


;; ****************************************************
;; 9.compilation-mode
;; ****************************************************
(require 'init-compile)
(define-key compilation-mode-map (kbd "n") 'compilation-next-error)
(define-key compilation-mode-map (kbd "p") 'compilation-previous-error)
(define-key compilation-mode-map (kbd "TAB") 'compilation-display-error)
(define-key compilation-mode-map (kbd "RET") 'compile-goto-error)


;; ****************************************************
;; 10. search (ocuur)
;; ****************************************************
(define-key occur-mode-map (kbd "n") 'occur-next)
(define-key occur-mode-map (kbd "p") 'occur-prev)
(define-key occur-mode-map (kbd "TAB") 'occur-mode-display-occurrence)
(define-key occur-mode-map (kbd "<tab>") 'occur-mode-display-occurrence)


(provide 'init-local-shortkey)
