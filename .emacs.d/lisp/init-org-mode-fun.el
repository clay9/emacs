
(defun my-org-archive-all-done (&optional tag)
  "Archive sublevels of the current tree without open TODO items.
If the cursor is not on a headline, try all level 1 trees.  If
it is on a headline, try all direct children.
When TAG is non-nil, don't move trees, but mark them with the ARCHIVE tag."
  (interactive "P")
  (set-buffer "task.org")
  (my-org-archive-all-matches
   (lambda (_beg end)
     (let ((case-fold-search nil))
       (unless (re-search-forward org-not-done-heading-regexp end t)
	 "no open TODO items")))
   tag))

(defun my-org-archive-all-matches (predicate &optional tag)
  "Archive sublevels of the current tree that match PREDICATE.

PREDICATE is a function of two arguments, BEG and END, which
specify the beginning and end of the headline being considered.
It is called with point positioned at BEG.  The headline will be
archived if PREDICATE returns non-nil.  If the return value of
PREDICATE is a string, it should describe the reason for
archiving the heading.

If the cursor is not on a headline, try all level 1 trees.  If it
is on a headline, try all direct children.  When TAG is non-nil,
don't move trees, but mark them with the ARCHIVE tag."
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



(defun my-org-agenda-bulk-action (&optional arg)
  "Execute an remote-editing action on all marked entries.
The prefix arg is passed through to the command if possible."
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
;; added by WangChengQing 2019.7.7 修改样式
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


(provide 'init-org-mode-fun)
