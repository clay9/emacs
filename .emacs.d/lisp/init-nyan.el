
(nyan-mode t)

(setq mode-line-format
      (list
       '(:eval (list (nyan-create)))
       ))

(setq nyan-animate-nyancat nil)
(setq nyan-wavy-trail nil)
(setq nyan-cat-face-number 2)

(setq nyan-minimum-window-width 40)


(provide 'init-nyan)
