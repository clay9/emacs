;; 破解加密软件

(defun copy-file-from-buffer (dir-name new-dir-name)
  "copy file from buffer; 
   move name extension -> sync"
  ;; make new dir
  (when (file-directory-p new-dir-name)
    (delete-directory new-dir-name t))
  (make-directory new-dir-name nil)  
  ;; write file -> new dir
  (let ((file_list (directory-files dir-name t "\\\w")))
    (dolist (file_name file_list)
      (when (file-directory-p file_name)
	(let ((dir-name-p file_name)
	      (new-dir-name-p (concat new-dir-name "/" (file-name-nondirectory file_name))))
	  (copy-file-from-buffer dir-name-p new-dir-name-p)))      
      ;; get buffer
      (when (and (not (file-directory-p file_name))
                 (or (string= "h" (file-name-extension file_name))
                     (string= "cpp" (file-name-extension file_name))
                     (string= "hpp" (file-name-extension file_name))
                     (string= "cfg" (file-name-extension file_name))
		     (string= "proto" (file-name-extension file_name))
                     (string= "pid" (file-name-extension file_name))
                     (string= "lock" (file-name-extension file_name))
                     (string= "sh" (file-name-extension file_name))
                     (string= "makefile" (file-name-nondirectory file_name))
                     (string= "Makefile" (file-name-nondirectory file_name))))
	(find-file-noselect file_name)
	(let ((file_buffer (get-file-buffer file_name))
	      (new_file_name (concat new-dir-name "/" (file-name-nondirectory file_name) ".sync")))
	  (set-buffer file_buffer)
	  (write-region (point-min) (point-max) new_file_name)
	  (kill-buffer file_buffer))))))

(defun sync-from-file (dir-name)
  "remove name extension .sync"  
  (let ((file_list (directory-files dir-name t "\\\w")))
    (dolist (file_name file_list)
      ;; dir
      (when (file-directory-p file_name)
	(let ((dir-name-p file_name))
	  (sync-from-file dir-name-p)))
      ;; file
      (when (not (file-directory-p file_name))
	(when (string= "sync" (file-name-extension file_name))
	  (rename-file file_name (substring file_name 0 -5)))))))


(defun my-copy ()
  (if (not (file-directory-p "~/code/company"))
      (copy-file-from-buffer "~/code/server" "~/code/temp")))

(defun my-encode ()
  (interactive)
  (sync-from-file "~/code/company"))

(my-copy)


(provide 'init-sync-fun)
