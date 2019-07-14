
;;smartparens mode

(require 'smartparens-config)

;; hooks
(add-hook 'minibuffer-setup-hook 'turn-on-smartparens-strict-mode)
(add-hook 'c-mode-common-hook  'smartparens-mode)
(add-hook 'org-mode-hook 'smartparens-mode)
(add-hook 'emacs-lisp-mode-hook 'smartparens-mode)

(show-smartparens-global-mode t)

;;org-mode
(sp-with-modes 'org-mode
  (sp-local-pair "=" "=" :wrap "C-="))

;;; C++
(sp-with-modes '(malabar-mode c++-mode)
  (sp-local-pair "{" nil :post-handlers '(("||\n[i]" "RET"))))
(sp-local-pair 'c++-mode "/*" "*/" :post-handlers '((" | " "SPC")
                                                    ("* ||\n[i]" "RET")))

;;lisp-mode
(sp-with-modes sp--lisp-modes
  (sp-local-pair "(" nil
                 :wrap "C-("
                 :pre-handlers '(my-add-space-before-sexp-insertion)
                 :post-handlers '(my-add-space-after-sexp-insertion)))

(defun my-add-space-after-sexp-insertion (id action _context)
  (when (eq action 'insert)
    (save-excursion
      (forward-char (sp-get-pair id :cl-l))
      (when (or (eq (char-syntax (following-char)) ?w)
                (looking-at (sp--get-opening-regexp)))
        (insert " ")))))

 (defun my-add-space-before-sexp-insertion (id action _context)
  (when (eq action 'insert)
 (save-excursion
      (backward-char (length id))
      (when (or (eq (char-syntax (preceding-char)) ?w)
                (and (looking-back (sp--get-closing-regexp))
                     (not (eq (char-syntax (preceding-char)) ?'))))
        (insert " ")))))

(provide 'init-smartparens-mode)
