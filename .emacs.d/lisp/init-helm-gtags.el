
(require 'helm-gtags)

;; ******************
;; hooks
;; ******************
(add-hook 'c-mode-common-hook 'helm-gtags-mode)
;(add-hook 'dired-mode-hook 'helm-gtags-mode)  ;;TODONOW 因为报错, 暂时屏蔽
;(add-hook 'eshell-mode-hook 'helm-gtags-mode) ;;TODONOW 因为报错, 暂时屏蔽
(add-hook 'asm-mode-hook 'helm-gtags-mode)


;; helm-gtags
(setq
 helm-gtags-ignore-case nil
 helm-gtags-auto-update t
 helm-gtags-use-input-at-cursor t
 helm-gtags-pulse-at-cursor nil
 helm-gtags-prefix-key nil
 helm-gtags-suggested-key-mapping nil
 )



(provide 'init-helm-gtags)
