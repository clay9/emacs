
;; ********************
;; menu bar
;; ********************
(menu-bar-mode 0)

;; ********************
;; tool bar
;; ********************
(tool-bar-mode 0)


;; ********************
;; scroll bar
;; ********************
(when window-system
  (scroll-bar-mode 0))


;; ********************
;; mode line
;; ********************
(require 'init-nyan)
(require 'init-window-number)
(defun window-number-string ()
  "Returns the string containing the number of the current window"
  (let ((n (window-number)))
    (if (= n 0) ""
      (propertize
       (concat " [" (number-to-string n) "] ")))))

;; 屏蔽某些minor-mode
(defun get-minor-mode-alist ()
  (dolist (var minor-mode-alist)
    (let ((first (format "%s" (car var))))
      (when (or (string= first "company-mode")
		(string= first "smartparens-mode")
		(string= first "disable-mouse-mode")
		(string= first "disable-mouse-global-mode")
		(string= first "smartparens-mode")
		(string= first "hs-minor-mode")
		(string= first "helm-mode")
		)
	(delete var minor-mode-alist))))
  (list minor-mode-alist))

;; 修改mode-line
(setq-default mode-line-format
	      (list
	       "%e"
	       'mode-line-mule-info
	       'mode-line-modified
	       "  "
	       'mode-line-buffer-identification
	       "  "
	       '(:eval (list (nyan-create)))
	       "%l  "
	       '(:propertize ("" mode-name))
	       '(:eval (get-minor-mode-alist))
	       " %n  "
	       'mode-line-process
	       ))


;; ********************
;; frame size
;; ********************
(add-to-list 'default-frame-alist '(width . 130))
(add-to-list 'default-frame-alist '(height . 40))


;; ********************
;; frame transparent
;; ********************
(set-frame-parameter (selected-frame) 'alpha (list 85 50))
(add-to-list 'default-frame-alist (cons 'alpha (list 85 50)))


;; ********************
;; color
;; ********************
(set-foreground-color "white")
(set-background-color "black")


;; ********************
;; indent
;; ********************
(setq tab-always-indent 't)


;; ********************
;; 其他
;; ********************
;; 备份文件目录修改 "XX~"文件
(setq backup-directory-alist '(("." . "~/.backup_emacs"))
      backup-by-copying t    ; Don't delink hardlinks
      version-control t      ; Use version numbers on backups
      delete-old-versions t  ; Automatically delete excess backups
      kept-new-versions 20   ; how many of the newest versions to keep
      kept-old-versions 5    ; and how many of the old
      )
;; 自动保存文件  "#XX#"文件
(setq auto-save-list-file-prefix "~/.autosave_emacs")
;(setq auto-save-list-file-name "~/.autosave_emacs")


;;关闭emacs启动时的画面
(setq inhibit-startup-message t)
;;关闭gnus启动时的画面
(setq gnus-inhibit-startup-message t)

;; 改变Emacs要你回答yes的行为,按y或空格键表示yes，n表示no。
(fset 'yes-or-no-p 'y-or-n-p)



(provide 'init-frame)
