(defun org-refile (&optional arg default-buffer rfloc msg)
  (interactive "P")
  (let* ((actionmsg (cond (msg msg)
			  ((equal arg 3) "Refile (and keep)")
			  (t "Refile")))
	 (region-start (and regionp (region-beginning)))
	 (region-end (and regionp (region-end)))
	 (org-refile-keep (if (equal arg 3) t org-refile-keep))
	 pos it nbuf file level reversed)
    (setq last-command nil)

    (when (or
	   (and (equal arg 2)
		org-clock-hd-marker (marker-buffer org-clock-hd-marker)
		(prog1
		    (setq it (list (or org-clock-heading "running clock")
				   (buffer-file-name
				    (marker-buffer org-clock-hd-marker))
				   ""
				   (marker-position org-clock-hd-marker)))
		  (setq arg nil))))

	(setq file (nth 1 it)
	      pos (nth 3 it))
	(when (and (not arg)
		   pos
		   (equal (buffer-file-name) file)
		   (if regionp
		       (and (>= pos region-start)
			    (<= pos region-end))
		     (and (>= pos (point))
			  (< pos (save-excursion
				   (org-end-of-subtree t t))))))
	  (error "Cannot refile to position inside the tree or region"))
	(setq nbuf (or (find-buffer-visiting file)
		       (find-file-noselect file)))
	(if (and arg (not (equal arg 3)))
	    (progn
	      (pop-to-buffer-same-window nbuf)
	      (goto-char (cond (pos)
			       ((org-notes-order-reversed-p) (point-min))
			       (t (point-max))))
	      (org-show-context 'org-goto))
	  (if regionp
	      (progn
		(org-kill-new (buffer-substring region-start region-end))
		(org-save-markers-in-region region-start region-end))
	    (org-copy-subtree 1 nil t))
	  (with-current-buffer (setq nbuf (or (find-buffer-visiting file)
					      (find-file-noselect file)))
	    (setq reversed (org-notes-order-reversed-p))
	    (org-with-wide-buffer
	     (if pos
		 (progn
		   (goto-char pos)
		   (setq level (org-get-valid-level (funcall outline-level) 1))
		   (goto-char
		    (if reversed
			(or (outline-next-heading) (point-max))
		      (or (save-excursion (org-get-next-sibling))
			  (org-end-of-subtree t t)
			  (point-max)))))
	       (setq level 1)
	       (if (not reversed)
		   (goto-char (point-max))
		 (goto-char (point-min))
		 (or (outline-next-heading) (goto-char (point-max)))))
	     (unless (bolp) (newline))
	     (org-paste-subtree level nil nil t)
	     ;; Record information, according to `org-log-refile'.
	     ;; Do not prompt for a note when refiling multiple
	     ;; headlines, however.  Simply add a time stamp.
	     (cond
	      ((not org-log-refile))
	      (regionp
	       (org-map-region
		(lambda () (org-add-log-setup 'refile nil nil 'time))
		(point)
		(+ (point) (- region-end region-start))))
	      (t
	       (org-add-log-setup 'refile nil nil org-log-refile)))
	     (and org-auto-align-tags
		  (let ((org-loop-over-headlines-in-active-region nil))
		    (org-align-tags)))
	     (let ((bookmark-name (plist-get org-bookmark-names-plist
					     :last-refile)))
	       (when bookmark-name
		 (with-demoted-errors
		     (bookmark-set bookmark-name))))
	     ;; If we are refiling for capture, make sure that the
	     ;; last-capture pointers point here
	     (when (bound-and-true-p org-capture-is-refiling)
	       (let ((bookmark-name (plist-get org-bookmark-names-plist
					       :last-capture-marker)))
		 (when bookmark-name
		   (with-demoted-errors
		       (bookmark-set bookmark-name))))
	       (move-marker org-capture-last-stored-marker (point)))
	     (when (fboundp 'deactivate-mark) (deactivate-mark))
	     (run-hooks 'org-after-refile-insert-hook)))
	  (unless org-refile-keep
	    (if regionp
		(delete-region (point) (+ (point) (- region-end region-start)))
	      (org-preserve-local-variables
	       (delete-region
		(and (org-back-to-heading t) (point))
		(min (1+ (buffer-size)) (org-end-of-subtree t t) (point))))))
	  (when (featurep 'org-inlinetask)
	    (org-inlinetask-remove-END-maybe))
	  (setq org-markers-to-move nil)
	  (message "%s to \"%s\" in file %s: done" actionmsg
		   (car it) file))))))
