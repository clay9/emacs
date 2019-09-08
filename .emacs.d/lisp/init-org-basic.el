(require 'org-bullets)
(require 'ox-publish)
(require 'ox-html)

;; 使用图标代替heading中的*
(add-hook 'org-mode-hook 'org-bullets-mode)
(setq org-bullets-mode t)

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

(provide 'init-org-basic)
