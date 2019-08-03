
;; set English Font
(set-face-attribute 'default nil :font "Monaco 14")

;; set Chinese Font
(dolist (charset '(kana han symbol cjk-misc bopomofo))
  (when window-system
    (set-fontset-font (frame-parameter nil 'font) charset (font-spec :family "楷体-简" :size 16)))) 


 (provide 'init-font)
