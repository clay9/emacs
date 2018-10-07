
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
;; ********编译器********
(require 'init-gtags-mode)     ;;语法解析
(require 'init-compilation-mode) ;;编译器
;; ********调试器********

;; *******版本管理*******


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
 '(package-selected-packages
   (quote
    (csharp-mode hydra yasnippet-snippets company-c-headers symbol-overlay slime flycheck smartparens sr-speedbar company))))
