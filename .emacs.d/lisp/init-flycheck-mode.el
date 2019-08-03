(require 'flycheck)

(add-hook 'c-mode-common-hook 'flycheck-mode)

(setq flycheck-display-errors-function #'flycheck-display-error-messages-unless-error-list)


;; ****************************************************
;; color && format
;; ****************************************************
(custom-set-faces
 '(flycheck-error-list-highlight ((t (:underline t))))
 '(flycheck-fringe-info ((t (:inherit success :underline t))))
 '(flycheck-fringe-warning ((t (:inherit error :underline t))))
 '(flycheck-warning ((t (:inherit error :underline t)))))


(provide 'init-flycheck-mode)
