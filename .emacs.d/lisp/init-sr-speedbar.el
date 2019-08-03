(require 'speedbar)
(require 'sr-speedbar)


;; ****************************************************
;; basic CFG
;; ****************************************************
(setq sr-speedbar-default-width 30)
(setq sr-speedbar-width 30)
(setq sr-speedbar-max-width 30)
(setq sr-speedbar-right-side nil)
(setq sr-speedbar-auto-refresh t)

(setq speedbar-use-images nil)


;; ****************************************************
;; color && format
;; ****************************************************
(custom-set-faces
 '(speedbar-directory-face ((t (:foreground "Sienna3"))))
 '(speedbar-file-face ((t (:foreground "white")))))


(provide 'init-sr-speedbar)
