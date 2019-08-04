(require 'helm)
(require 'helm-config)

(helm-mode 1)
(setq helm-display-header-line nil)
(setq helm-move-to-line-cycle-in-source t)
(setq helm-etags-execute-action-at-once-if-one nil)


;; ****************************************************
;; 1. helm-buffers
;; ****************************************************
;; ignore file for helm-buffer
(setq helm-skip-boring-buffers t)
(customize-set-variable 'helm-boring-buffer-regexp-list
   (quote
    ("\\` " "\\`\\*helm" "\\`\\*Echo Area" "\\`\\*Minibuf" "\\*Messages\\*" "\\*GNU Emacs\\*"
     "\\*Color.*" "BigDay" "\\*Completions\\*" "\\*Flycheck error message"
     "Help" "Backtrace" "new snippet"  "Fancy Diary Entries" "\\*Org LATEX Export"
     "\\*Customize Option*" "\\*Customize Group.*" "\\*Warnings\\*" "\\.DS_Store"
     "habit.org" "project.org" "trash.org" "inbox.org" "diary" "\\*scratch\\*"
     "\\*threads of .*" "\\*input/output of .*" "\\*breakpoints of .*" "\\*locals of .*" "\\*stack frames of" "\\*Buffer List\\*"
     )))


;; ****************************************************
;; 2. helm-find-files
;; ****************************************************
;; ignore file for helm-find
(setq helm-ff-skip-boring-files t)
(customize-set-variable 'helm-boring-file-regexp-list
   (quote
    ("\\.o$" "~$" "\\.bin$" "\\.lbin$" "\\.so$" "\\.a$" "\\.ln$" "\\.blg$" "\\.bbl$" "\\.elc$"
     "\\.lof$" "\\.glo$" "\\.idx$" "\\.lot$" "\\.svn/" "\\.hg/" "\\.git/" "\\.bzr/" "CVS/"
     "_darcs/" "_MTN/" "\\.fmt$" "\\.tfm$" "\\.class$" "\\.fas$" "\\.lib$" "\\.mem$" "\\.x86f$"
     "\\.sparcf$" "\\.dfsl$" "\\.pfsl$" "\\.d64fsl$" "\\.p64fsl$" "\\.lx64fsl$" "\\.lx32fsl$"
     "\\.dx64fsl$" "\\.dx32fsl$" "\\.fx64fsl$" "\\.fx32fsl$" "\\.sx64fsl$" "\\.sx32fsl$"
     "\\.wx64fsl$" "\\.wx32fsl$" "\\.fasl$" "\\.ufsl$" "\\.fsl$" "\\.dxl$" "\\.lo$" "\\.la$" "\\.gmo$"
     "\\.mo$" "\\.toc$" "\\.aux$" "\\.cp$" "\\.fn$" "\\.ky$" "\\.pg$" "\\.tp$" "\\.vr$" "\\.cps$" "\\.fns$"
     "\\.kys$" "\\.pgs$" "\\.tps$" "\\.vrs$" "\\.pyc$" "\\.pyo$" "\\.DS_Store$" "^[a-z].*\\.d$" "\\.#.*$"
     "\\#$" "\\.^[0-9]*$"))) 


;; ****************************************************
;; 3. helm-ff-run-grep
;; ****************************************************
(when (executable-find "ack-grep")
  (setq helm-grep-default-command "ack-grep -Hn --no-group --no-color %e %p %f"
        helm-grep-default-recurse-command "ack-grep -H --no-group --no-color %e %p %f"))


;; ****************************************************
;; 4. Color && format
;; ****************************************************
(custom-set-faces
  '(helm-ff-directory ((t (:background "black" :foreground "Sienna3"))))
  '(helm-ff-dotted-directory ((t (:background "black" :foreground "Sienna3"))))
  '(helm-ff-file ((t (:background "black" :foreground "white"))))
  '(helm-ff-invalid-symlink ((t (:foreground "green"))))
  '(helm-ff-symlink ((t (:foreground "green")))))

(custom-set-faces
   '(helm-buffer-directory ((t (:background "black" :foreground "Sienna3"))))
   '(helm-buffer-file ((t (:background "black" :foreground "white"))))
   '(helm-candidate-number ((t (:background "grey75" :foreground "black")))))

(custom-set-faces
  '(helm-history-remote ((t (:foreground "red"))))
  '(helm-selection ((t (:underline "cyan"))))
  '(helm-source-header ((t (:background "black" :foreground "white" :weight bold :height 2 :family "微软雅黑")))))


(provide 'init-helm-mode)
