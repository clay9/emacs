
;; 目录一栏
;; 0.helm-mode 1.helm-gtags
;; 2.symbol-overlay-mode  3.hs-hide-mode  4.speedbar  5.yasnippet
;; 6.artist-mode

;; *********************************
;; 0.helm-mode
;; *********************************
(require 'helm)
(require 'helm-config)
(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action)
(define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ;make TAB work in terminal
(define-key helm-map (kbd "C-z") 'helm-select-action)


;; *********************************
;; 1.helm-gtags
;; *********************************
(require 'helm-gtags)
(defhydra hydra-helm-gtags (:color blue
                             :hint nil)
 "
_j_: 相关引用      _p_: 上个位置      _n_: 下个位置
"
 ("j" helm-gtags-dwim)
 ("p" helm-gtags-previous-history)
 ("n" helm-gtags-next-history))
;(global-set-key (kbd "C-j")  'hydra-helm-gtags/body) ;;写入init-global-shortkey中


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
;(global-set-key (kbd "C-'")  'hydra-symbol-overlay/body) ;;写入init-global-shortkey中


;; *********************************
;; 3.hs-minor-mode
;; *********************************
(require 'hideshow)
(define-key hs-minor-mode-map (kbd "<backtab>") 'hs-toggle-hiding);; Shift + Tab
;(define-key hs-minor-mode-map (kbd "") 'hs-hide-all);; TODONOW全部隐藏, 未找到合适的快捷键
;(define-key hs-minor-mode-map (kbd "") 'hs-show-all);; TODONOW全部展开, 未找到合适的快捷键


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
_j_: 扩展   _i_: 增加   _v_: 查看
  
"
 ("j" yas-expand)  ;;<Tab>仍可使用
 ("i" yas-new-snippet)
 ("v" yas-visit-snippet-file))
;(global-set-key (kbd "C-;")  'hydra-yas-minor/body) ;;写入init-global-shortkey中



;; *********************************
;; 6.artist-mode
;; *********************************
(artist-mode 1)
(define-key artist-mode-map (kbd "SPC") 'org-self-insert-command)
(define-key artist-mode-map (kbd "RET") 'org-return)
(define-key artist-mode-map (kbd "DEL") 'org-delete-backward-char)
(define-key artist-mode-map (kbd "TAB") 'org-cycle)
(define-key artist-mode-map (kbd "\C-@")'artist-key-set-point) 

;1) line                 :: C-c C-a l
;   proy_line            :: C-c C-a p
;2) rectngle             :: C-c C-a r
;   squares              :: C-c C-a s
;3) elipse               :: C-c C-a e
;   circle               :: C-c C-a c
;4) spray                :: C-c C-a S
;;TODONOW 使用hydra-mode管理这些artist-mode中的快捷键



(provide 'init-local-shortkey)
