(require 'ox-publish)
(require 'ox-html)
(require 'ox)
(require 'org-bullets)
(require 'iimage)

;; 使用图标代替heading中的*
(add-hook 'org-mode-hook
          (lambda ()
            (org-bullets-mode t)
	    (iimage-mode)
	    ))
;; ⤵ 替换 省略号
(setq org-ellipsis "⤵")


;; 显示图片
(add-to-list 'iimage-mode-image-regex-alist
             (cons (concat "\\[\\[file:\\(~?" iimage-mode-image-filename-regex
                           "\\)\\]")  1))

;; when export, do not raise an error on broken links -- 对publish无效
(setq org-export-with-broken-links t)
;; remove validate link
(setq org-html-validation-link nil)
;; alway publish all
(setq org-publish-use-timestamps-flag nil)
;; publish
(setq org-publish-project-alist
      '(("root"
         :base-directory "~/hexo/org-info"
         :publishing-directory "~/hexo/blog/public/org-info"	 
         :publishing-function org-html-publish-to-html
         :with-toc t
	 :with-broken-links t  ;没有效果
	 :html-link-home "http://wcq.fun"
	 :html-use-infojs t)
        ("script"
         :base-directory "~/hexo/org-info/script"
         :base-extension "js"
         :publishing-directory "~/hexo/blog/public/org-info/script"
         :publishing-function org-publish-attachment)
        ("emacs_IDE"
         :base-directory "~/hexo/org-info/emacs_IDE"
         :publishing-directory "~/hexo/blog/public/org-info/emacs_IDE"
         :publishing-function org-html-publish-to-html
	 :with-toc t
	 :html-link-home "http://wcq.fun"
	 :html-link-up "http://wcq.fun/org-info/emacs.html"
	 :html-use-infojs t)
	("emacs_com"
         :base-directory "~/hexo/org-info/emacs_com"
         :publishing-directory "~/hexo/blog/public/org-info/emacs_com"
         :publishing-function org-html-publish-to-html
	 :with-toc t
	 :html-link-home "http://wcq.fun"
	 :html-link-up "http://wcq.fun/org-info/emacs.html"
	 :html-use-infojs t)))
	;; ("company"
	;;  :base-directory "~/code/company/"
        ;;  :publishing-directory "~/hexo/blog/public/org-info"
        ;;  :publishing-function org-html-publish-to-html
        ;;  :with-toc t
	;;  :html-link-home "http://wcq.fun"
	;;  :html-use-infojs t)


;; active Babel languages
(org-babel-do-load-languages
 'org-babel-load-languages
 '((C . t)
   (emacs-lisp . t)
   (dot . t)))


;; ****************************************************
;; 设置启动界面
;; ****************************************************
(setq org-agenda-prefix-format "%?-7t%-12:s ")
(org-agenda-list)
(org-agenda-next-item 1)
(delete-other-windows)

(provide 'init-org-basic)
