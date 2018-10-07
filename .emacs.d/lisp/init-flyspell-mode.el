
;;; flyspell --- 单词拼写检查
(require 'flyspell)
(flyspell-mode t)


;(add-hook 'prog-mode-hool 'flyspell-mode)
;(add-hook 'c-mode-common-hook 'flyspell-mode)
;(add-hook 'emacs-lisp-mode-hook 'flyspell-mode)
;(add-hook 'org-mode-hook 'flyspell-mode)


;; ********************
;; color && format
;; ********************
(custom-set-faces
  '(flyspell-incorrect ((t (:inherit warning :underline t)))))



(provide 'init-flyspell-mode)

