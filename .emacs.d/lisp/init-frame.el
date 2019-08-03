
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
