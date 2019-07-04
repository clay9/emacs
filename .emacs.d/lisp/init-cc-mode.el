
;; ********************
;; CC Mode
;; ********************
;; .h关联到c++ mode
(setq auto-mode-alist
      (append '(("\\.h$" . c++-)) auto-mode-alist))

;; (dir) - CC Mode - Sample Init File
(defconst my-cpp-style
  '((c-basic-offset . 4)
    (c-tab-always-inde . t)
    (c-hanging-braces-alist . ((brace-list-open)
			       (brace-entry-open)
			       (statement-cont)))
    (c-offsets-alist . ((block-open  . 0)
			(block-close . 0)
			(comment-intro . 0)
			(case-label . +)
			(substatement-open . 0))))
  "My C++ Programming Style 2017.01.12")
(c-add-style "MY_CPP_STYLE" my-cpp-style)

(defun my-cpp-mode-common-hook()
  (c-set-style "MY_CPP_STYLE")
  (setq tab-width 8
	indent-tabs-mode nil))

(add-hook 'c-mode-common-hook 'my-cpp-mode-common-hook)



(provide 'init-cc-mode)
