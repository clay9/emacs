(require 'window-number)

;; 默认开启该mode
(window-number-mode 1)


;; ****************************************************
;; Overloaded Function
;; ****************************************************
(defun window-number-string ()
  "Used by Var: mode-line-format
   Change: cancel font face
   Origin: Returns the string containing the number of the current window"
  (let ((n (window-number)))
    (if (or (= n 0)
	    (= n 1))
	""
      (propertize
       (concat " [" (number-to-string n) "] ")))))


(provide 'init-window-number)
