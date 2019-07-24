
;; 说明
;; 注释中带major的是major mode

;; *************************
;; 前戏 :)
;; *************************
(package-initialize)
(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))

(require 'init-package)         ;;远端包库
(require 'init-site-lisp)       ;;本地包库


;; *************************
;; Basic CFG
;; *************************
(require 'init-frame)           ;;窗口初始化
(require 'init-font)            ;;字体初始化
(require 'init-disable-mouse)   ;;停用鼠标
(require 'init-local-shortkey)  ;;局部快捷键
(require 'init-global-shortkey) ;;全局快捷键
(require 'init-helm-mode)       ;;Helm
(require 'init-flyspell-mode)   ;;单词拼写检查
(require 'init-smartparens-mode);;智能括号
(require 'init-yasnippet-mode)  ;;模板文件
(require 'init-eshell)          ;;内置命令行


;; *************************
;; 日程排表 && 知识管理 (GTD)
;; *************************
(require 'init-org-mode)        ;;所想所得(major)
(require 'init-calendar)        ;;日历


;; *************************
;; c-comon development (IDE)
;; *************************
;; 1.编辑器 2.编译器 3.调试器 4.版本管理

;; ********编辑器********
(require 'init-cc-mode)        ;;格式提示(major)
(require 'init-company-mode)   ;;补全提示
(require 'init-helm-gtags)     ;;代码跳转,引用显示
(require 'init-hs-minor-mode)  ;;代码折叠
(require 'init-flycheck-mode)  ;;实时语法检查
(require 'init-sr-speedbar)    ;;相关文件目录列表
(require 'init-symbol-overlay-mode);;代码高亮
;; ********编译器********s
(require 'init-compilation-mode) ;;编译器
;; ********调试器********

;; *******版本管理*******
(require 'init-magit)          ;;git版本管理

;; *************************
;; lisp development (IDE)
;; *************************
;; ********编译器********
(require 'init-slime)


;; *************************
;; Other
;; *************************
(require 'init-artist-mode)    ;;简易绘图



;; *************************
;; 自定义
;; *************************
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-agenda-block-separator 42)
 '(org-agenda-menu-show-matcher nil)
 '(org-priority-faces
   (quote
    ((65 :background "red" :foreground "white" :weight bold)
     (66 :background "DarkOrange" :foreground "white" :weight bold)
     (67 :background "yellow" :foreground "DarkGreen" :weight bold)
     (68 :background "DodgerBlue" :foreground "black" :weight bold))))
 '(org-todo-keyword-faces (quote (("WAITING" . "tan1") ("TODO" . "brown1"))))
 '(package-selected-packages
   (quote
    (disable-mouse yasnippet org magit-annex buster-mode magit graphviz-dot-mode markdown-preview-mode markdown-mode ledger-mode csharp-mode hydra company-c-headers symbol-overlay slime flycheck sr-speedbar company))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-tooltip ((t (:foreground "white"))))
 '(flycheck-error-list-highlight ((t (:underline t))))
 '(flycheck-fringe-info ((t (:inherit success :underline t))))
 '(flycheck-fringe-warning ((t (:inherit error :underline t))))
 '(flycheck-warning ((t (:inherit error :underline t))))
 '(flyspell-incorrect ((t (:inherit warning :underline t))))
 '(font-lock-comment-face ((t (:foreground "ForestGreen"))))
 '(helm-buffer-directory ((t (:background "black" :foreground "Sienna3"))))
 '(helm-buffer-file ((t (:background "black" :foreground "white"))))
 '(helm-candidate-number ((t (:background "grey75" :foreground "black"))))
 '(helm-ff-directory ((t (:background "black" :foreground "Sienna3"))))
 '(helm-ff-dotted-directory ((t (:background "black" :foreground "Sienna3"))))
 '(helm-ff-file ((t (:background "black" :foreground "white"))))
 '(helm-ff-invalid-symlink ((t (:foreground "green"))))
 '(helm-ff-symlink ((t (:foreground "green"))))
 '(helm-history-remote ((t (:foreground "red"))))
 '(helm-selection ((t (:underline "cyan"))))
 '(helm-source-header ((t (:background "black" :foreground "white" :weight bold :height 2 :family "微软雅黑"))))
 '(org-agenda-date ((t (:inherit org-agenda-structure :foreground "white"))))
 '(org-agenda-date-today ((t (:foreground "white" :underline t :slant normal :weight normal))))
 '(org-agenda-date-weekend ((t (:foreground "white"))))
 '(org-agenda-structure ((t (:foreground "white"))))
 '(org-habit-alert-face ((t (:background "orange" :foreground "black"))))
 '(org-list-dt ((t nil)))
 '(org-scheduled-previously ((t (:foreground "PaleGreen"))))
 '(org-tag ((t nil)))
 '(org-time-grid ((t (:foreground "white"))))
 '(org-todo ((t (:foreground "Pink"))))
 '(org-warning ((t (:foreground "red"))))
 '(sp-show-pair-enclosing ((t (:inherit nil :underline t))))
 '(sp-show-pair-match-face ((t (:inherit nil :foreground "orange" :underline t))))
 '(sp-show-pair-mismatch-face ((t (:inherit nil :foreground "red" :underline t))))
 '(speedbar-directory-face ((t (:foreground "Sienna3"))))
 '(speedbar-file-face ((t (:foreground "white"))))
 '(yas-field-highlight-face ((t (:foreground "green" :background "black" :inherit (quote region))))))
