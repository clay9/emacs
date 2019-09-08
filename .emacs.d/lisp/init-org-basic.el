(require 'ox-publish)
(require 'ox-html)
(require 'org-bullets)

;; 使用图标代替heading中的*
(add-hook 'org-mode-hook
          (lambda ()
            (org-bullets-mode t)))
;; ⤵ 替换 省略号
(setq org-ellipsis "⤵")


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
	 :html-link-up "http://wcq.fun/org-info/emacs_IDE.html"
	 :html-use-infojs t)
        ("org-info" :components ("root" "script" "emacs_IDE"))))


;; ****************************************************
;; 设置启动界面
;; ****************************************************
(setq org-agenda-prefix-format "%?-7t%-12:s ")
(org-agenda-list)
(org-agenda-next-item 1)
(delete-other-windows)

(provide 'init-org-basic)
