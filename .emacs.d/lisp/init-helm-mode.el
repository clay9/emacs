;(require 'helm)
(require 'helm-config)
(require 'helm-lib)
(require 'helm-buffers)
(require 'helm-files)

(helm-mode 1)
(setq helm-display-header-line nil)
(setq helm-move-to-line-cycle-in-source t)
(setq helm-etags-execute-action-at-once-if-one nil)


;; ****************************************************
;; 1. helm-buffers
;; ****************************************************
;; ignore file for helm-buffer
(setq helm-skip-boring-buffers t)
(setq helm-boring-buffer-regexp-list
   (quote
    ("\\` " "\\`\\*helm" "\\`\\*Echo Area" "\\`\\*Minibuf" "\\*Messages\\*" "\\*GNU Emacs\\*"
     "\\*Color.*" "BigDay" "\\*Completions\\*" "\\*Flycheck error message"
     "Backtrace" "new snippet"  "Fancy Diary Entries" "\\*Org LATEX Export"
     "\\*Customize Option*" "\\*Customize Group.*" "\\*Warnings\\*" "\\.DS_Store"
     "habit.org" "project.org" "trash.org" "diary" "\\*scratch\\*"
     "\\*threads of .*" "\\*input/output of .*" "\\*breakpoints of .*" "\\*locals of .*" "\\*stack frames of" "\\*Buffer List\\*"
     "\\.d$" "\\*Org Agenda\\*" "\\*Compile-Log\\*"
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
     "\\.kys$" "\\.pgs$" "\\.tps$" "\\.vrs$" "\\.pyc$" "\\.pyo$" "\\.DS_Store$" "\\.#.*$"
     "\\#$" "\\.^[0-9]*$" "\\.d$" "\.svn/?")))


;; ****************************************************
;; 3. helm-ff-run-grep
;; ****************************************************
(when (executable-find "ack-grep")
  (setq helm-grep-default-command "ack-grep -Hn --no-group --no-color %e %p %f"
        helm-grep-default-recurse-command "ack-grep -H --no-group --no-color %e %p %f"))


(provide 'init-helm-mode)
