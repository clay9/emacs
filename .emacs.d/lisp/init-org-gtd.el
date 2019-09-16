(require 'org-agenda)
(require 'init-org-gtd-fun);; 加载重载函数

;; ****************************************************
;; files, todo, tag, priority
;; ****************************************************
;; agenda files
(setq org-agenda-files
      (list "~/GTD/inbox.org"
	    "~/GTD/task.org"
	    "~/GTD/archive.org"
	    ;"~/GTD/habit.org" ;;暂时屏蔽
	    ))

;; todo keywords
(setq org-todo-keywords
      '((type  "TODO(t)" "WAITING(w)" "PROJECT(p)" "|"  "DONE(d)" "CANCEL(c)")))
;; only sub done, parents done
(setq org-enforce-todo-dependencies t)
;;
(setq org-closed-keep-when-no-todo 'nil)

;; tags; 
;(setq org-tag-alist
;      '((:startgroup . nil)
;	("urgent" . ?u)
;	(:endgroup . nil)
;	(:startgroup . nil)
;	("important" . ?i)
;	(:endgroup . nil)))
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
      '(("i" "info" entry (file "~/GTD/inbox.org")
	 "* INFO [#D] %?\n  - %u [capture]\n %i\n")
	("t" "todo" entry (file "~/GTD/inbox.org")
	 "* TODO [#C] %?\n  - %u [capture]\n %i\n")
	("w" "waiting" entry (file "~/GTD/inbox.org")
	 "* WAITING [#C] %?\n  - %u [capture]\n %i\n")
	("p" "project" entry (file "~/GTD/inbox.org")
	 "* PROJECT [#B] %?\n  - %u [capture]\n %i\n")
	))

;; refile
;; make file as target refiles
(setq org-refile-use-outline-path 'file)
(setq org-refile-targets
      '(("~/GTD/task.org" . (:maxlevel . 1))
	("~/GTD/archive.org" . (:level . 1))
	(nil . (:maxlevel . 2))
	))
;; archive
(setq org-archive-location "~/GTD/archive.org::")

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
;; 显示标准: 月 -- 一览全局
(setq org-agenda-span 'week)

;; 设置agenda中 时间样式表
;(setq org-agenda-time-grid '((daily today) (1100 1400 1800 2000) "..... " "----------------"))

;; 设置Schedule 和 Deadline的提示样式
(setq org-agenda-scheduled-leaders '("Start" "Start %2dd"));
(setq org-agenda-deadline-leaders '("Dead" "In %3dd" "Dead %2dd"));


;; ****************************************************
;; agenda buffers
;; ****************************************************
;; set which itmes can show
;; ignore items in todo view
(setq org-agenda-todo-ignore-scheduled 'all)
(setq org-agenda-todo-ignore-deadlines 'all)
(setq org-agenda-todo-ignore-timestamp 'all)
(setq org-agenda-tags-todo-honor-ignore-options 't)
;; not show sublevels in agenda 
(setq org-agenda-todo-list-sublevels 'nil)
(setq org-habit-show-habits-only-for-today t)

(setq org-agenda-skip-scheduled-if-done t)
(setq org-agenda-skip-deadline-if-done t)
(setq org-deadline-warning-days 1)
      
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
	 ((agenda ""))
	 ((local_temp (funcall set_org_buffer_no 1))
	  (org-agenda-prefix-format "%?-7t%-12:s ")
	  (org-agenda-sorting-strategy
	   '(time-up todo-state-up scheduled-up deadline-up priority-up))))
	;next step
	("n" "Next Step"
	 ((tags-todo "+LEVEL=1/TODO"
		     ((org-agenda-overriding-header "TODO")))
	  (tags-todo "+LEVEL=1/WAITING"
		((org-agenda-overriding-header "WAITING")))
	  (tags-todo "-LEVEL=1/TODO"
		((org-agenda-overriding-header "PROJECT")
		 )))
	 ((local_temp (funcall set_org_buffer_no 2))
	  (org-agenda-sorting-strategy
	   '(priority-down alpha-up effort-up))
	  (org-agenda-prefix-format "%(get_item_num)")
	  (org-agenda-files '("~/GTD/task.org"))
	  (org-agenda-todo-keyword-format "")))
	("i" "inbox"
	 ((search "INFO"
		((org-agenda-overriding-header "Inbox"))))
	 ((local_temp (funcall set_org_buffer_no 3))
	  (org-agenda-sorting-strategy
	   '(priority-down alpha-up effort-up))
	  (org-agenda-prefix-format "%(get_item_num)")
	  (org-agenda-files '("~/GTD/inbox.org"))))))	


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



(provide 'init-org-gtd)
