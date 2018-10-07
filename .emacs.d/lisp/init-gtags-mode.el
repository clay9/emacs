
(require 'gtags)

(add-hook 'dired-mode-hook 'gtags-mode)
(add-hook 'eshell-mode-hook 'gtags-mode)
(add-hook 'c-mode-common-hook 'gtags-mode)
(add-hook 'asm-mode-hook 'gtags-mode)



(provide 'init-gtags-mode)
