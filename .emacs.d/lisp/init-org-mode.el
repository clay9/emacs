
 ;; ******************
 ;; org-mode
;; ******************

;; agenda的出现模式
(setq org-agenda-window-setup 'current-window)

 ;; (dir) - Org mode - Document Structure - Visibility cycling - Catching invisible edits
(setq org-catch-invisible-edits 'error)

 ;; (dir) - Org mode - TODO Items -TODO extensions - Fast access to TODO states
(setq org-todo-keywords
      '((type  "TODO(t)" "WAITING(w)" "PROJECT(p)" "|"  "DONE(d)" "CANCEL(c)")))

 ;; (dir) - Org mode - TODO Items - TODO extensions - TODO dependencies
(setq org-enforce-todo-dependencies t)

 ;; (dir) - Org mode - TODO Items - Progress logging - closing items
(setq org-closed-keep-when-no-todo 'nil)
(setq org-log-done 'note)

 ;; (dir) - Org mode - TODO Items - Progress logging - Tracking TODO state changes
(setq org-log-note-headings '((done . "%s Note in %d")
			      (state . "State %-12s from %-12S %t")
			      (not . "Note taken on %t")
			      (reschedule . "Reschedule from %S on %t")
			      (redeadline . "New deadline form %S on %t")
			      (deldeadline . "Removed deadline was %S on %t")
			      (refile . "Refiled on %t")
			      (clock-out . "")))

 ;; (dir) - Org mode - TODO Items - Progress logging - Tracking your habits
(setq org-modules
    (quote
        (org-bbdb org-bibtex org-docview org-gnus org-habit org-info org-irc org-mhe org-rmail org-w3m)))
(setq org-habit-show-habits-only-for-today t)

 ;; (dir) - Org mode - Tags - Tag inheritance
(setq org-tags-match-list-sublevels 'nil)
(setq org-use-tag-inheritance 'nil)

 ;; (dir) - Org mode - Tags - Setting tags
(setq org-tag-alist
      '((:startgroup . nil)
	("urgent" . ?u)
	(:endgroup . nil)
	(:startgroup . nil)
	("important" . ?i)
	(:endgroup . nil)))

 ;; (dir) - Org mode - Dates and Times - Deadlines and scheduling
(setq org-agenda-skip-scheduled-if-done t)
(setq org-agenda-skip-deadline-if-done t)
(setq org-deadline-warning-days 0)

 ;; (dir) - Org mode - Capture_Refile_Archive - Capture - Setting up capture
(setq org-default-notes-file (expand-file-name "~/GTD/inbox.org"))

 ;; (dir) - Org mode - Capture_Refile_Archive - Capture - Capture templates
(setq org-capture-templates
 '(("i" "Idea -> inbox.org" entry (file "~/GTD/inbox.org")
    "* %?\n  %u from %F\n  content:\n  %i\n")))

 ;; (dir) - Org mode - Capture_Refile_Archive - Refile and copy
(setq org-refile-targets
      (quote(("~/GTD/task.org" :level . 1)
	     ("~/GTD/project.org" :level . 2)
	     ("~/GTD/trash.org" :level . 1))))
(setq org-refile-use-outline-path 'file)
(setq org-reverse-note-order t)
(setq org-log-refile (quote nil))

;; (dir) - Org mode -Capture_Refile_Archive - Archiving  - Moving a tree to the archive file
(setq org-archive-location "~/GTD/archive.org::* Finished Tasks")

(setq org-agenda-sorting-strategy
      (quote ((agenda time-up habit-up todo-state-up scheduled-down deadline-down)
              (todo priority-down category-keep)
              (tags priority-down category-keep)
              (search category-keep))))


 ;; (dir) - Org mode - Agenda views - Agenda files
(setq org-agenda-files
      (list "~/GTD/inbox.org"
	    "~/GTD/task.org"
	    "~/GTD/habit.org"
	    "~/GTD/project.org"
	    "~/GTD/trash.org"));;因四象限屏蔽掉archive.org

 ;; (dir) - Org mode - Agenda Vies - Built_in agenda views - Weekly/daily agenda
(setq org-agenda-include-diary t)

(org-agenda-to-appt t)
(defadvice  org-agenda-redo (after org-agenda-redo-add-appts)
  "Pressing `r' on the agenda will also add appointments."
  (progn
    (org-agenda-to-appt)))
(ad-activate 'org-agenda-redo)

 ;; (dir) - Org mode - Agenda views - Built_in agenda views - weekly/daily agenda
(setq org-agenda-span 'day)
      
 ;; (dir) - Org mode - Agenda Views - Built_in agenda views - Global TODO list
(setq org-agenda-todo-ignore-scheduled 'all)
(setq org-agenda-todo-ignore-deadlines 'all)
(setq org-agenda-todo-ignore-timestamp 'all)
(setq org-agenda-tags-todo-honor-ignore-options 't)
(setq org-agenda-todo-list-sublevels 'nil)

 ;; (dir) - Org mode - Agenda Views - Presentation and sortind - Time of day specifications
;(setq org-agenda-time-grid '((daily today) "----------------" (800 1000 1200 1400 1600 1800 2000)))

 ;; (dir) - Org mode - Agenda Views - Custom agenda views
(setq org-agenda-custom-commands
      '(("a" "agenda && waiting"
	 ((agenda)))
	;四象限 project
	("p" "Project 四象限"
	 ((tags-todo "+important+urgent/PROJECT"
		     	 ((org-agenda-overriding-header "第一象限")))
	  (tags-todo "+important-urgent/PROJECT"
		     	 ((org-agenda-overriding-header "第二象限")))
	  (tags-todo "-important+urgent/PROJECT"
		     	 ((org-agenda-overriding-header "第三象限")))
	  (tags-todo "-important-urgent/PROJECT"
		     ((org-agenda-overriding-header "第四象限")))))
	;四象限 todo (仅限task.org)
	("f" "TAGS 四象限"
	 ((tags "+important+urgent+LEVEL=1-TODO=\"TODO\"-TODO=\"WAITING\"-TODO=\"CANCEL\"-TODO=\"DONE\""
		((org-agenda-overriding-header "TAG 第一象限")))
	  (tags "+important-urgent+LEVEL=1-TODO=\"TODO\"-TODO=\"WAITING\"-TODO=\"CANCEL\"-TODO=\"DONE\""
		((org-agenda-overriding-header "TAG 第二象限")))	
	  (tags "-important+urgent+LEVEL=1-TODO=\"TODO\"-TODO=\"WAITING\"-TODO=\"CANCEL\"-TODO=\"DONE\""
		((org-agenda-overriding-header "TAG 第三象限")))	  
	  (tags "-important-urgent+LEVEL=1-TODO=\"TODO\"-TODO=\"WAITING\"-TODO=\"CANCEL\"-TODO=\"DONE\""
		((org-agenda-overriding-header "TAG 第四象限"))))
	 ((org-agenda-files '("~/GTD/task.org"))
	  (org-agenda-overriding-header "Inbox")))
	;场景
	("n" "Next Step"
	 ((todo "TODO"
		((org-agenda-overriding-header "TODO")))
	  (todo "WAITING"
		((org-agenda-overriding-header "WAITING")))))))

 ;; others M-x customize group
(setq org-agenda-hide-tags-regexp
      "company\\|home\\|urgent\\|important\\|habit")


;; ****************
;; color && format
;; ****************
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


;; ****************
;; 设置启动界面
;; ****************
(org-agenda-list)
(delete-other-windows)

(provide 'init-org-mode)
