;; 说明
;; 注释中带major的是major mode

;; *************************
;; 前戏 :)
;; *************************
(package-initialize)
(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))
(add-to-list 'load-path (expand-file-name "lisp/fun" user-emacs-directory))

(require 'init-package)         ;;远端包库
(require 'init-site-lisp)       ;;本地包库


;; *************************
;; Basic CFG
;; *************************
(load-theme 'dracula t)         ;;主题加载
(require 'init-helm-mode)       ;;Helm
(require 'init-frame)           ;;窗口初始化
(require 'init-font)            ;;字体初始化
(require 'init-linum-mode)      ;;行号显示
(require 'init-nyan)            ;;彩虹猫
(require 'init-disable-mouse)   ;;禁用鼠标
(require 'init-bookmark)        ;;书签
(require 'init-smartparens-mode);;智能括号
(require 'init-yasnippet-mode)  ;;模板文件
(require 'init-eshell)          ;;内置命令行
(require 'init-expand-region)   ;;快速选择
(require 'init-search)          ;;搜索替换
(require 'init-window-number)   ;;窗口快速选择
;;(require 'init-dict)          ;;汉英词典(bing词典) TODONOW 待补充
;;(require 'init-completion)    ;;命令补全   TODONOW 待补充
(require 'bm)                   ;;临时bookmarks
(require 'init-basic-fun)       ;;自定义函数(basic)
(require 'init-local-shortkey)  ;;局部快捷键
(require 'init-global-shortkey) ;;全局快捷键


;; *************************
;; 日程排表 && 知识管理 (GTD)
;; *************************
(require 'init-org-basic)       ;;org
(require 'init-org-gtd)         ;;GTD
(require 'init-calendar)        ;;日历


;; *************************
;; c-comon development (IDE)
;; *************************
;; *******1.编辑器********
(require 'init-cc-mode)        ;;格式提示(major)
(require 'init-company-mode)   ;;补全提示
(require 'init-helm-gtags)     ;;代码跳转,引用显示
(require 'init-hs-minor-mode)  ;;代码折叠
(require 'init-flycheck-mode)  ;;实时语法检查
(require 'init-sr-speedbar)    ;;文件目录列表
(require 'init-symbol-overlay) ;;代码高亮
;; *******2.编译器********
(require 'init-compile)        ;;编译器
;; *******3.调试器********
(require 'init-gdb)            ;;gdb调试器


;; *************************
;; lisp development (IDE)
;; *************************
;; ********编译器********
(require 'init-slime)


;; *************************
;; 奇淫技巧
;; *************************
(require 'init-artist-mode)    ;;简易绘图
(require 'init-figlet)         ;;ASCII图形


;; *************************
;; 自定义
;; *************************
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(ebdb-i18n-chn cal-china-x magit bm figlet window-number sr-speedbar hydra graphviz-dot-mode flycheck expand-region dracula-theme disable-mouse company-c-headers)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'narrow-to-page 'disabled nil)
