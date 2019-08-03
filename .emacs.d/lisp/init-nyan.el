
(require 'nyan-mode)
(nyan-mode t)

(setq nyan-animate-nyancat nil)
(setq nyan-wavy-trail nil)
(setq nyan-cat-face-number 2)

(setq nyan-minimum-window-width 30)


;; 屏蔽某些minor-mode
(defun get-minor-mode-alist ()
  (dolist (var minor-mode-alist)
    (let ((first (format "%s" (car var))))
      (when (or (string= first "company-mode")
		(string= first "smartparens-mode")
		(string= first "disable-mouse-mode")
		(string= first "disable-mouse-global-mode")
		(string= first "smartparens-mode")
		(string= first "hs-minor-mode")
		(string= first "helm-mode")
		)
	(delete var minor-mode-alist))))
  (list minor-mode-alist))


;; 修改mode-line
(setq-default mode-line-format
	      (list
	       "%e"
	       'mode-line-mule-info
	       'mode-line-modified
	       "  "
	       'mode-line-buffer-identification
	       "  "
	       '(:eval (list (nyan-create)))
	       "%l  "
	       '(:propertize ("" mode-name))
	       '(:eval (get-minor-mode-alist))
	       " %n  "
	       'mode-line-process
	       ))

(provide 'init-nyan)
