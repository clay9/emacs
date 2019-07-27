
(defun my-org-agenda (&optional arg org-keys restriction)
  (catch 'exit
    (let* ((prefix-descriptions nil)
	   (org-agenda-buffer-name org-agenda-buffer-name)
	   (org-agenda-window-setup (if (equal (buffer-name)
					       org-agenda-buffer-name)
					'current-window
				      org-agenda-window-setup))
	   (org-agenda-custom-commands-orig org-agenda-custom-commands)
	   (org-agenda-custom-commands
	    ;; normalize different versions
	    (delq nil
		  (mapcar
		   (lambda (x)
		     (cond ((stringp (cdr x))
			    (push x prefix-descriptions)
			    nil)
			   ((stringp (nth 1 x)) x)
			   ((not (nth 1 x)) (cons (car x) (cons "" (cddr x))))
			   (t (cons (car x) (cons "" (cdr x))))))
		   org-agenda-custom-commands)))
	   (org-agenda-custom-commands
	    (org-contextualize-keys
	     org-agenda-custom-commands org-agenda-custom-commands-contexts))
	   (buf (current-buffer))
	   (bfn (buffer-file-name (buffer-base-buffer)))
	   entry key type org-match lprops ans)
      ;; Turn off restriction unless there is an overriding one,
      (unless org-agenda-overriding-restriction
	(unless org-agenda-keep-restricted-file-list
	  ;; There is a request to keep the file list in place
	  (put 'org-agenda-files 'org-restrict nil))
	(setq org-agenda-restrict nil)
	(move-marker org-agenda-restrict-begin nil)
	(move-marker org-agenda-restrict-end nil))
      ;; Delete old local properties
      (put 'org-agenda-redo-command 'org-lprops nil)
      ;; Delete previously set last-arguments
      (put 'org-agenda-redo-command 'last-args nil)
      ;; Remember where this call originated
      (setq org-agenda-last-dispatch-buffer (current-buffer))
      
      (unless org-keys
	(message "valid org-keys"))
      
      ;; If we have sticky agenda buffers, set a name for the buffer,
      ;; depending on the invoking keys.  The user may still set this
      ;; as a command option, which will overwrite what we do here.
      (if org-agenda-sticky
	  (setq org-agenda-buffer-name
		(format "*Org Agenda(%s)*" org-keys)))
      ;; Establish the restriction, if any
      (when (and (not org-agenda-overriding-restriction) restriction)
	(put 'org-agenda-files 'org-restrict (list bfn))
	(cond
	 ((eq restriction 'region)
	  (setq org-agenda-restrict (current-buffer))
	  (move-marker org-agenda-restrict-begin (region-beginning))
	  (move-marker org-agenda-restrict-end (region-end)))
	 ((eq restriction 'subtree)
	  (save-excursion
	    (setq org-agenda-restrict (current-buffer))
	    (org-back-to-heading t)
	    (move-marker org-agenda-restrict-begin (point))
	    (move-marker org-agenda-restrict-end
			 (progn (org-end-of-subtree t)))))))

      ;; For example the todo list should not need it (but does...)
      (cond
       ((setq entry (assoc org-keys org-agenda-custom-commands))
	(if (or (symbolp (nth 2 entry)) (functionp (nth 2 entry)))
	    (progn
	      (setq type (nth 2 entry) org-match (eval (nth 3 entry))
		    lprops (nth 4 entry))
	      (if org-agenda-sticky
		  (setq org-agenda-buffer-name
			(or (and (stringp org-match) (format "*Org Agenda(%s:%s)*" org-keys org-match))
			    (format "*Org Agenda(%s)*" org-keys))))
	      (put 'org-agenda-redo-command 'org-lprops lprops)
	      (cond
	       ((eq type 'agenda)
		(org-let lprops '(org-agenda-list current-prefix-arg)))
	       ((eq type 'agenda*)
		(org-let lprops '(org-agenda-list current-prefix-arg nil nil t)))
	       ((eq type 'alltodo)
		(org-let lprops '(org-todo-list current-prefix-arg)))
	       ((eq type 'search)
		(org-let lprops '(org-search-view current-prefix-arg org-match nil)))
	       ((eq type 'stuck)
		(org-let lprops '(org-agenda-list-stuck-projects
				  current-prefix-arg)))
	       ((eq type 'tags)
		(org-let lprops '(org-tags-view current-prefix-arg org-match)))
	       ((eq type 'tags-todo)
		(org-let lprops '(org-tags-view '(4) org-match)))
	       ((eq type 'todo)
		(org-let lprops '(org-todo-list org-match)))
	       ((eq type 'tags-tree)
		(org-check-for-org-mode)
		(org-let lprops '(org-match-sparse-tree current-prefix-arg org-match)))
	       ((eq type 'todo-tree)
		(org-check-for-org-mode)
		(org-let lprops
		  '(org-occur (concat "^" org-outline-regexp "[ \t]*"
				      (regexp-quote org-match) "\\>"))))
	       ((eq type 'occur-tree)
		(org-check-for-org-mode)
		(org-let lprops '(org-occur org-match)))
	       ((functionp type)
		(org-let lprops '(funcall type org-match)))
	       ((fboundp type)
		(org-let lprops '(funcall type org-match)))
	       (t (user-error "Invalid custom agenda command type %s" type))))
	  (org-agenda-run-series (nth 1 entry) (cddr entry))))
       
       ((equal org-keys "C")
	(setq org-agenda-custom-commands org-agenda-custom-commands-orig)
	(customize-variable 'org-agenda-custom-commands))
       (t (user-error "Invalid agenda key"))
       ))))


(defun my-org-agenda-forward ()
  "Append another agenda view to the current one.
This function allows interactive building of block agendas.
Agenda views are separated by `org-agenda-block-separator'."
  (interactive)
  (unless (derived-mode-p 'org-agenda-mode)
    (user-error "Can only append from within agenda buffer"))
  (let ((org-agenda-multi nil))
    (cond
     ((= my-org-agenda-buffer-no 1)
      (my-org-agenda nil "i"))
     ((= my-org-agenda-buffer-no 2)
      (my-org-agenda nil "f"))
     ((= my-org-agenda-buffer-no 3)
      (my-org-agenda nil "n"))
     ((= my-org-agenda-buffer-no 4)
      (my-org-agenda nil "a")))
    (widen)
    (org-agenda-finalize)
    (setq buffer-read-only t)
    (org-agenda-fit-window-to-buffer)))

(defun my-org-agenda-back ()
  "Append another agenda view to the current one.
This function allows interactive building of block agendas.
Agenda views are separated by `org-agenda-block-separator'."
  (interactive)
  (unless (derived-mode-p 'org-agenda-mode)
    (user-error "Can only append from within agenda buffer"))
  (let ((org-agenda-multi nil))
    (cond
     ((= my-org-agenda-buffer-no 4)
      (my-org-agenda nil "f"))
     ((= my-org-agenda-buffer-no 3)
      (my-org-agenda nil "i"))
     ((= my-org-agenda-buffer-no 2)
      (my-org-agenda nil "a"))
     ((= my-org-agenda-buffer-no 1)
      (my-org-agenda nil "n")))
    (widen)
    (org-agenda-finalize)
    (setq buffer-read-only t)
    (org-agenda-fit-window-to-buffer)))


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
