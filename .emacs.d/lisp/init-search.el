;; set default search: regex 
(setq search-default-mode t)

;; forbid normal search
(setq search-nonincremental-instead nil)

;; search invisiable region
(setq isearch-hide-immediately nil)


;; ****************************************************
;; Overloaded Function
;; ****************************************************
(defun my-occur (regexp &optional nlines)
  "Used by user
   Change: when search over, switch to result buffer and find the first match item
   Origin: search all match items"
  (interactive (occur-read-primary-args))
  (occur-1 regexp nlines (list (current-buffer)))
  (switch-to-buffer-other-window "*Occur*")
  (occur-next))


(provide 'init-search)
