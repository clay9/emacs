(require 'org-agenda)
(require 'init-org-mode-fun);; 加载重载函数


;; ****************************************************
;; files, todo, tag, priority
;; ****************************************************
;; agenda files
(setq org-agenda-files
      (list "~/GTD/inbox.org"
	    "~/GTD/task.org"
	    "~/GTD/habit.org"
	    "~/GTD/project.org"
	    "~/GTD/archive.org"
	    "~/GTD/trash.org"))

;; todo keywords
(setq org-todo-keywords
      '((type  "TODO(t)" "WAITING(w)" "PROJECT(p)" "|"  "DONE(d)" "CANCEL(c)")))
;; only sub done, parents done
(setq org-enforce-todo-dependencies t)
;;
(setq org-closed-keep-when-no-todo 'nil)

;; tags; obsoleted; use priority instead
(setq org-tag-alist
      '((:startgroup . nil)
	("urgent" . ?u)
	(:endgroup . nil)
	(:startgroup . nil)
	("important" . ?i)
	(:endgroup . nil)))
;; ignore tags in agenda buffer
(setq org-agenda-hide-tags-regexp
      "company\\|home\\|urgent\\|important\\|habit")
;; ignore tags of sublevel
(setq org-tags-match-list-sublevels 'nil)
;; forbid tag inheritance
(setq org-use-tag-inheritance 'nil)

;; 设置Priority[min, max] && default priority
(setq org-highest-priority ?A)
(setq org-lowest-priority  ?D)
(setq org-default-priority ?D)
(setq org-priority-faces
      '((?A . (:background "" :foreground "red" :weight bold))
        (?B . (:background "" :foreground "DarkOrange" :weight bold))
        (?C . (:background "" :foreground "yellow" :weight bold))
        (?D . (:background "" :foreground "DodgerBlue" :weight bold))
        ))


;; ****************************************************
;; capture, refile, archive, log
;; ****************************************************
 ;; capture
(setq org-capture-templates
 '(("i" "Idea -> inbox.org" entry (file "~/GTD/inbox.org")
    "* %?\n  - %u [capture]\n %i\n")))
 ;; refile
(setq org-refile-targets
      '(("~/GTD/task.org" :maxlevel . 1)
	("~/GTD/project.org" :maxlevel . 2)
	("~/GTD/trash.org" :level . 1)))
;; archive
(setq org-archive-location "~/GTD/archive.org::* Finished Tasks")

 ;; log note headings, olny effected when log set to note
(setq org-log-note-headings '((done . "%d [done]")
			      (state . "State %-12s from %-12S %t")
			      (not . "Note taken on %t")
			      (reschedule . "Reschedule from %S on %t")
			      (redeadline . "New deadline form %S on %t")
			      (deldeadline . "Removed deadline was %S on %t")
			      (refile . "%d [refile]")
			      (clock-out . "")))

;; log type
(setq org-log-done 'note)
(setq org-log-refile 'time)
; store new notes at the begin
(setq org-reverse-note-order t)


;; ****************************************************
;; schedule, deadline
;; ****************************************************
;; 显示标准: 天
(setq org-agenda-span 'day)

;; 设置agenda中 时间样式表
(setq org-agenda-time-grid '((daily today) (1100 1400 1800 2000) "..... " "----------------"))

;; 设置Schedule 和 Deadline的提示样式
(setq org-agenda-scheduled-leaders '("Start" "Start %2dd"));
(setq org-agenda-deadline-leaders '("Dead" "In %3dd" "Dead %2dd"));


;; ****************************************************
;; agenda buffers
;; ****************************************************
;; set which itmes can show
;; ignore todo
(setq org-agenda-todo-ignore-scheduled 'all)
(setq org-agenda-todo-ignore-deadlines 'all)
(setq org-agenda-todo-ignore-timestamp 'all)
(setq org-agenda-tags-todo-honor-ignore-options 't)
;; not show sublevels in agenda 
(setq org-agenda-todo-list-sublevels 'nil)
(setq org-habit-show-habits-only-for-today t)
(setq org-agenda-skip-scheduled-if-done t)
(setq org-agenda-skip-deadline-if-done t)
(setq org-deadline-warning-days 0)

;; items sort
(setq org-agenda-sorting-strategy
      (quote ((agenda time-up todo-state-up scheduled-up deadline-up priority-up)
              (todo priority-down category-keep)
              (tags priority-down category-keep)
              (search category-keep))))
      
;; 设置agenda中bulk mark时候的标志
(setq org-agenda-bulk-mark-char "x")

;; 扩展agenda中bulk 操作命令
(setq org-agenda-bulk-custom-functions
      '((?w org-agenda-refile) 
	(?y org-agenda-archive)
	(?, org-agenda-priority)
	))

;; (dir) - Org mode - Agenda Views - Custom agenda views
(setq org-agenda-custom-commands
      '(
	; agent && main task
	("a" "agenda"
	 ((agenda "+TODO=\"TODO\""))
	 ((local_temp (funcall set_org_buffer_no 1))
	  (org-agenda-prefix-format "%?-7t%-12:s ")
	  (org-agenda-sorting-strategy
	   '(time-up todo-state-up scheduled-up deadline-up priority-up))))
	;inbox文件
	("i" "Inbox"
	 ((tags "+LEVEL=1"
		((org-agenda-overriding-header "Inbox Things"))))
	 ((local_temp (funcall set_org_buffer_no 2))
	  (org-agenda-files '("~/GTD/inbox.org"))
	  (org-agenda-sorting-strategy
	   '(priority-down alpha-up effort-up))
	  (org-agenda-prefix-format "%-10:s "))) ;inbox中不存在Schedule, 这么写只是为了前面空格而已
	;四象限 todo
	("f" "TAGS 四象限"
	 ;; Project
	 ((tags-todo "+TODO=\"PROJECT\""
		     ((local_temp (funcall set_org_buffer_no 3))
		      (org-agenda-overriding-header "Project")
		      (org-agenda-todo-ignore-scheduled 'nil)
		      (org-agenda-todo-ignore-deadlines 'nil)
		      (org-agenda-todo-ignore-timestamp 'nil)
		      (org-agenda-prefix-format "%?-12t%-10:s")
		      (org-agenda-sorting-strategy
		       '(priority-down alpha-up effort-up))
		      (org-agenda-files '("~/GTD/project.org"))))
	  ;; Task
	  (tags "+LEVEL=1-TODO=\"TODO\"-TODO=\"WAITING\"-TODO=\"CANCEL\"-TODO=\"DONE\""
		((local_temp (funcall set_org_buffer_no 3))
		 (org-agenda-overriding-header "TAG")
		 (org-agenda-prefix-format "%-10:s ")
		 (org-agenda-sorting-strategy
		  '(priority-down alpha-up effort-up))
		 ;(org-agenda-block-separator "")
		 (org-agenda-files '("~/GTD/task.org"))))))
	;next step
	("n" "Next Step"
	 ((todo "TODO"
		((org-agenda-overriding-header "TODO")))
	  (todo "WAITING"
		((org-agenda-overriding-header "WAITING"))))
	 ((local_temp (funcall set_org_buffer_no 4))
	  (org-agenda-prefix-format "%-10:c")
	  (org-agenda-sorting-strategy
	   '(priority-down alpha-up effort-up))
	  (org-agenda-todo-keyword-format "")
	  ))))


;; ****************************************************
;; others
;; ****************************************************
;; diary
(setq org-agenda-include-diary t)

;; agenda的出现模式
(setq org-agenda-window-setup 'current-window)

 ;; 编辑折叠的内容时候 提示错误
(setq org-catch-invisible-edits 'error)

 ;; 
(setq org-modules
    (quote
     (org-bbdb org-bibtex org-docview org-gnus org-habit org-info org-irc org-mhe org-rmail org-w3m)))

;; (dir) - Org mode - Capture_Refile_Archive - Capture - Setting up capture
;(setq org-default-notes-file (expand-file-name "~/GTD/inbox.org"))

;(setq org-refile-use-outline-path 'file)


;; ****************************************************
;; color && format
;; ****************************************************
(custom-set-faces
 '(org-agenda-date ((t (:inherit org-agenda-structure :foreground "white"))) t)
 '(org-agenda-date-today ((t (:foreground "white" :underline t :slant normal :weight normal))) t)
 '(org-agenda-date-weekend ((t (:foreground "white"))) t)
 '(org-time-grid ((t (:foreground "white"))))
 '(org-scheduled-previously ((t (:foreground "PaleGreen"))))
 '(org-habit-alert-face ((t (:background "orange" :foreground "black"))))
 '(org-list-dt ((t nil)))
 '(org-tag ((t nil)))
 '(org-agenda-structure ((t (:foreground "white"))))
 '(org-todo ((t (:foreground "Pink"))))
 '(org-warning ((t (:foreground "red")))))

(custom-set-variables
 '(org-agenda-block-separator 42)
 '(org-agenda-menu-show-matcher nil)
 '(org-todo-keyword-faces (quote (("WAITING" . "tan1")
				  ("TODO" . "brown1")))))


;; ****************************************************
;; 设置启动界面
;; ****************************************************
(setq org-agenda-prefix-format "%?-7t%-12:s ")
(org-agenda-list)
(delete-other-windows)


(provide 'init-org-mode)
