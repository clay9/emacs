;; org-info.js 与 hexo 配合

(defun write-link-to-hexo (dir-name hexo-file)
  "write file:link --> hexo/archive.org"
  (let ((file_list (directory-files dir-name t "\\\w")))
    ;; open file
    (find-file-noselect hexo-file)
    ;; set buffer
    (set-buffer (get-file-buffer hexo-file))
    ;; clear buffer
    (delete-region (point-min) (point-max))
    ;; write into buffer
    (dolist (file_name file_list)
      (when (not (file-directory-p file_name))
	(when (string= "org" (file-name-extension file_name))
	  (newline 2)
	  (goto-char (point-max))
	  (let* ((insert_name (concat "["
				      (file-name-sans-extension (file-name-nondirectory file_name))
				      "]"))
		 (insert_link (concat "[http:"
				      "../org-info-new/"
				      (file-name-sans-extension (file-name-nondirectory file_name))
				      ".html]"))
		 (inser_str (concat "["
				    insert_link
				    insert_name
				    "]")))
	    (insert inser_str)))))
    ;; save file
    (save-buffer)
    (kill-buffer (get-file-buffer hexo-file))))


(defun export-org-to-html (dir-name)
  "export org-files to html"
  (let ((file_list (directory-files dir-name t "\\\w")))
    (dolist (file_name file_list)      
      (when (file-directory-p file_name)
	(let ((dir-name-p file_name))
	  (export-org-to-html dir-name-p)))
      (when (not (file-directory-p file_name))
	(when (string= "org" (file-name-extension file_name))
	  ;; open file
	  (find-file-noselect file_name)
	  ;; set buffer
	  (set-buffer (get-file-buffer file_name))
	  (org-html-export-to-html)
 	  ;; kill buffer
	  (kill-buffer (get-file-buffer file_name)))))))




(write-link-to-hexo "/Users/clay/hexo/blog/source/org-info"
		      "/Users/clay/hexo/blog/source/about/index.org")

(export-org-to-html "/Users/clay/hexo/blog/source/org-info")



(provide 'init-hexo-fun)
