
(require 'smartparens-config)

(add-hook 'c-mode-common-hook  #'smartparens-mode)
(add-hook 'org-mode-hook #'smartparens-mode)



(provide 'init-smartparens-mode)
