
(require 'yasnippet)
(yas-global-mode t)

;; ********************
;; color && format
;; ********************
(setq yas-snippet-dirs
       '("~/.emacs.d/yasnippets"))

(yas-load-directory "~/.emacs.d/yasnippets/")


;; ********************
;; color && format
;; ********************
(custom-set-faces
  '(yas-field-highlight-face ((t (:foreground "green" :background "black" :inherit (quote region))))))



(provide 'init-yasnippet-mode)
