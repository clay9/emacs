(require 'org-agenda)

;; ****************************************************
;; 按r 刷新
;; ****************************************************
(org-agenda-to-appt t)
(defun my-org-agenda-redo ()
  "Used in agenda-buffer by user;
   Function: refresh agenda bufffer"
  (interactive)
;  (my-org-refile-all-todo)  ;;refile: inbox.org->task.org
  (my-org-archive-all-done) ;;archive: task.org->archive.org
  (my-org-sort-entries "inbox.org") ;;inbox排序
  (my-org-sort-entries "task.org") ;;task排序
  (org-agenda-redo t) ;;call origin redo
  (org-agenda-to-appt))

(defun my-org-refile-all-todo ()
    "Used by org-agenda-redo
     Function: refile all todo|project|waitting item;  inbox.org -> task.org"
  (let ((current_buffer (current-buffer)))
    (set-buffer "inbox.org")
    ;(my-org-refile-all-todo-1)
    (goto-char (point-min))
    (org-refile 2)
    (set-buffer current_buffer)))

(my-org-refile-all-todo)


(defun my-org-refile-all-todo-1 ()
  "Used by my-org-refile-all-todo
   Fucntion:"
  ;; hide org-file all headings 
  (goto-char (point-min))
  (org-show-all '(headings))
  (org-shifttab)
  ;; goto first line
  (goto-char (point-min))
  ;; lootp: next line 
  (while (/= (point) (point-max))      
    (when (or (org-match-line "* TODO")
	      (org-match-line "* WAITING")
	      (org-match-line "* PROJECT"))
      (org-refile ))
    (next-line)))
  
(defun my-org-archive-all-done (&optional tag)
  "Used by org-agenda-redo
  Function: archive all done item;  task.org -> trash.org"
  (let ((current_buffer (current-buffer)))
    (set-buffer "task.org")
    (my-org-archive-all-matches
     (lambda (_beg end)
       (let ((case-fold-search nil))
	 (unless (re-search-forward org-not-done-heading-regexp end t)
	   "no open TODO items")))
     tag)
    (set-buffer current_buffer)))

(defun my-org-archive-all-matches (predicate &optional tag)
  "Used by my-org-archive-all-done
   Fucntion: "
  (let ((rea (concat ".*:" org-archive-tag ":")) re1
	(begm (make-marker))
	(endm (make-marker))
	reason beg end (cntarch 0))

    (setq re1 "^* ")
    (move-marker begm (point-min))
    (move-marker endm (point-max))
    (save-excursion
      (goto-char begm)
      (while (re-search-forward re1 endm t)
	(setq beg (match-beginning 0)
	      end (save-excursion (org-end-of-subtree t) (point)))
	(goto-char beg)
	(if (not (setq reason (funcall predicate beg end)))
	    (goto-char end)
	  (goto-char beg)
	  (if (or (not tag) (not (looking-at rea)))
	      (progn
		(if tag
		    (org-toggle-tag org-archive-tag 'on)
		  (org-archive-subtree))
		(setq cntarch (1+ cntarch)))
	    (goto-char end)))))
    (message "%d trees archived" cntarch)))


;; ****************************************************
;; 返回agenda (n) 中 item的编号
;; ****************************************************
(defun get_item_num ()
  "Used by or-agenda-custom-commands
   Function: return item num"
  (setq item_num (+ item_num 1))
  (format "%s." item_num)
  )


;; ****************************************************
;; 快速切换agenda buffer
;; ****************************************************
;; 标识当前agenda-buffer编号
(defvar my-org-agenda-buffer-no 1)
(setq set_org_buffer_no (lambda (val)
			  (setq my-org-agenda-buffer-no val)
			  (setq item_num 0) ;;切换时候, reset vaule
			  ))

(defun my-org-agenda-forward ()
  "Used by user;
   Function: Move next buffer;"
  (interactive)
  (unless (derived-mode-p 'org-agenda-mode)
    (user-error "Can only append from within agenda buffer"))
  (let ((org-agenda-multi nil))
    (cond
     ((= my-org-agenda-buffer-no 1)
      (org-agenda nil "n"))
     ((= my-org-agenda-buffer-no 2)
      (org-agenda nil "i"))
     ((= my-org-agenda-buffer-no 3)
      (org-agenda nil "a"))     
     )
    (org-agenda-next-item 1)
    (widen)
    (org-agenda-finalize)
    (setq buffer-read-only t)
    (org-agenda-fit-window-to-buffer)))

(defun my-org-agenda-back ()
  "Used by user;
   Function: Move previous buffer"
  (interactive)
  (unless (derived-mode-p 'org-agenda-mode)
    (user-error "Can only append from within agenda buffer"))
  (let ((org-agenda-multi nil))
    (cond
     ((= my-org-agenda-buffer-no 3)
      (org-agenda nil "n"))     
     ((= my-org-agenda-buffer-no 2)
      (org-agenda nil "a"))
     ((= my-org-agenda-buffer-no 1)
      (org-agenda nil "i"))
     )
    (org-agenda-next-item 1)
    (widen)
    (org-agenda-finalize)
    (setq buffer-read-only t)
    (org-agenda-fit-window-to-buffer)))


;; ****************************************************
;; 快速显示关闭 item
;; ****************************************************
(defvar my-last-show-entry "")
(defun my-org-agenda-show ()
  "Used in agenda-buffer by user;
   Fucntion: toggle the item show|hide "
  (interactive)
  (let ((current-show-entry (format "%S" (org-get-at-bol 'org-marker))))
    (when current-show-entry
      (if (string-equal my-last-show-entry current-show-entry)
          (funcall (lambda ()
                     (setq my-last-show-entry "")
                     (org-agenda-goto t)
                     (delete-window)))
        (setq my-last-show-entry current-show-entry)
        (org-agenda-show)))))


;; ****************************************************
;; 对agenda-file 进行排序
;; ****************************************************
(defun my-org-sort-entries (buffer-name)
  "Used by my-org-agenda-redo
   Function: sort agenda entries"
  (let (start  ;; beg of first heading 
	beg    ;; = start
	end    ;; end of buffer
	stars  ;; *
	re
	re2
        txt    ;; the contents of buffer
	(current_buffer (current-buffer)))
    
    ;; 设置buffer
    (set-buffer buffer-name)
    
    ;; 找到start
    (goto-char (point-min))
    (or (org-at-heading-p) (outline-next-heading))
    (setq start (point)) 
    ;; 找到end
    (goto-char (point-max))      
    (beginning-of-line 1)
    (when (looking-at ".*?\\S-")
      ;; File ends in a non-white line
      (end-of-line 1)
      (insert "\n"))      
    (setq end (point-max))
    
    ;;全部展开
    (goto-char start)
    (org-show-all '(headings blocks))

    ;; 没有heading, 则返回
    (setq beg (point))
    (when (>= beg end) (goto-char start) (user-error "Nothing to sort"))

    ;; 寻找匹配 (*+) -- 会影响match-string
    (looking-at "\\(\\*+\\)")    
    (setq stars (match-string 1)  ;; 第一个匹配(*+)的值
	  re (concat "^" (regexp-quote stars) " +")
	  re2 (concat "^" (regexp-quote (substring stars 0 -1)) "[ \t\n]")
	  txt (buffer-substring beg end)) ;; buffer content

    ;; 确保txt 以 \n结尾
    (unless (equal (substring txt -1) "\n") (setq txt (concat txt "\n")))

    ;; txt不是以 *[ \t\n]  开头
    (when (and (not (equal stars "*")) (string-match re2 txt))
      (user-error "Region to sort contains a level above the first entry"))

    ;; sort enrties
    (save-restriction ;;
      (narrow-to-region start end)
      (org-preserve-local-variables ;; execute body while preserving local variables
       (let ((fun1 (lambda nil
		     ;; This function moves to the beginning character of the "record" to be sorted.
		     (if (re-search-forward re nil t)
			 (goto-char (match-beginning 0))
		       (goto-char (point-max)))))
	     (fun2 (lambda nil
		     ;; This function moves to the last character of the "record" being sorted
		     (save-match-data
		       (condition-case nil
			   (outline-forward-same-level 1)
			 (error
			  (goto-char (point-max)))))))
	     (compare1 (lambda ()
			 ;; todo key
			 (when (looking-at org-complex-heading-regexp)
			   (let* ((m (match-string 2))
				  (s (if (member m org-done-keywords) '- '+)))
			     (- 99 (funcall s (length (member m org-todo-keywords-1))))))))
	     (compare2 (lambda nil
			 ;; priority
			 (if (re-search-forward org-priority-regexp (point-at-eol) t)
			     (string-to-char (match-string 2))
			   org-default-priority)))
	     (compare3 (lambda nil
			 ;; case
			 (downcase (org-sort-remove-invisible (org-get-heading t t t t)))))
	     )
	 ; sort -- case
	 (sort-subr nil fun1 fun2 compare3 nil nil)
	 (sort-subr nil fun1 fun2 compare2 nil nil)
	 (sort-subr nil fun1 fun2 compare1 nil nil))
       ))
      (org-shifttab 1)
      (save-buffer)
    (set-buffer current_buffer)))


;; ****************************************************
;; bulk动作
;; ****************************************************
(defun org-agenda-bulk-action (&optional arg)
  "Used by user;
   Change: 修改提示样式
   Origin: bulk动作"
  (interactive "P")
  ;; TODONOW 如果没有marked enrty, 则对当前所在entry操作
  (unless org-agenda-bulk-marked-entries (user-error "No entries are marked"))
  (dolist (m org-agenda-bulk-marked-entries)
    (unless (and (markerp m)
		 (marker-buffer m)
		 (buffer-live-p (marker-buffer m))
		 (marker-position m))
      (user-error "Marker %s for bulk command is invalid" m)))

  ;; Prompt for the bulk command.
  (message
"
_w_: refile      _y_ : archive
_t_: todo        _+-_: tag         _,_: prority
_s_: schedule    _d_ : deadline    _S_: Scatter
")
  
  (catch 'exit
    (let* ((org-log-refile (if org-log-refile 'time nil))
	   (entries (reverse org-agenda-bulk-marked-entries))
	   (org-overriding-default-time
	    (and (get-text-property (point) 'org-agenda-date-header)
		 (org-get-cursor-date)))
	   redo-at-end
	   cmd)
      (pcase (read-char-exclusive)
	(?y
	 (setq cmd #'org-agenda-archive))

	(?w
	 (let ((refile-location
		(org-refile-get-location
		 "Refile to"
		 (marker-buffer (car entries))
		 org-refile-allow-creating-parent-nodes)))
	   (when (nth 3 refile-location)
	     (setcar (nthcdr 3 refile-location)
		     (move-marker
		      (make-marker)
		      (nth 3 refile-location)
		      (or (get-file-buffer (nth 1 refile-location))
			  (find-buffer-visiting (nth 1 refile-location))
			  (error "This should not happen")))))

	   (setq cmd `(lambda () (org-agenda-refile nil ',refile-location t)))
	   (setq redo-at-end t)))

	(?t
	 (let ((state (completing-read
		       "Todo state: "
		       (with-current-buffer (marker-buffer (car entries))
			 (mapcar #'list org-todo-keywords-1)))))
	   (setq cmd `(lambda ()
			(let ((org-inhibit-blocking t)
			      (org-inhibit-logging 'note))
			  (org-agenda-todo ,state))))))

	((and (or ?- ?+) action)
	 (let ((tag (completing-read
		     (format "Tag to %s: " (if (eq action ?+) "add" "remove"))
		     (with-current-buffer (marker-buffer (car entries))
		       (delq nil
			     (mapcar (lambda (x) (and (stringp (car x)) x))
				     org-current-tag-alist))))))
	   (setq cmd
		 `(lambda ()
		    (org-agenda-set-tags ,tag
					 ,(if (eq action ?+) ''on ''off))))))

	((and (or ?s ?d) c)
	 (let* ((schedule? (eq c ?s))
		(prompt (if schedule? "(Re)Schedule to" "(Re)Set Deadline to"))
		(time
		 (and (not arg)
		      (let ((new (org-read-date
				  nil nil nil prompt org-overriding-default-time)))
			;; A "double plus" answer applies to every
			;; scheduled time.  Do not turn it into
			;; a fixed date yet.
			(if (string-match-p "\\`[ \t]*\\+\\+"
					    org-read-date-final-answer)
			    org-read-date-final-answer
			  new)))))
	   ;; Make sure to not prompt for a note when bulk
	   ;; rescheduling/resetting deadline as Org cannot cope with
	   ;; simultaneous notes.  Besides, it could be annoying
	   ;; depending on the number of marked items.
	   (setq cmd
		 (if schedule?
		     `(lambda ()
			(let ((org-log-reschedule
			       (and org-log-reschedule 'time)))
			  (org-agenda-schedule arg ,time)))
		   `(lambda ()
		      (let ((org-log-redeadline (and org-log-redeadline 'time)))
			(org-agenda-deadline arg ,time)))))))

	(action
	 (pcase (assoc action org-agenda-bulk-custom-functions)
	   (`(,_ ,f) (setq cmd f) (setq redo-at-end t))
	   (_ (user-error "Invalid bulk action: %c" action)))))

      ;; Sort the markers, to make sure that parents are handled
      ;; before children.
      (setq entries (sort entries
			  (lambda (a b)
			    (cond
			     ((eq (marker-buffer a) (marker-buffer b))
			      (< (marker-position a) (marker-position b)))
			     (t
			      (string< (buffer-name (marker-buffer a))
				       (buffer-name (marker-buffer b))))))))

      ;; Now loop over all markers and apply CMD.
      (let ((processed 0)
	    (skipped 0))
	(dolist (e entries)
	  (let ((pos (text-property-any (point-min) (point-max) 'org-hd-marker e)))
	    (if (not pos)
		(progn (message "Skipping removed entry at %s" e)
		       (cl-incf skipped))
	      (goto-char pos)
	      (let (org-loop-over-headlines-in-active-region) (funcall cmd))
	      ;; `post-command-hook' is not run yet.  We make sure any
	      ;; pending log note is processed.
	      (when (or (memq 'org-add-log-note (default-value 'post-command-hook))
			(memq 'org-add-log-note post-command-hook))
		(org-add-log-note))
	      (cl-incf processed))))
	(when redo-at-end (org-agenda-redo))
	(unless org-agenda-persistent-marks (org-agenda-bulk-unmark-all))
	(message "Acted on %d entries%s%s"
		 processed
		 (if (= skipped 0)
		     ""
		   (format ", skipped %d (disappeared before their turn)"
			   skipped))
		 (if (not org-agenda-persistent-marks) "" " (kept marked)"))))))


(provide 'init-org-gtd-fun)
