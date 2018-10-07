
;; ********************
;; font size
;; ********************

;;Setting English Font  13 16
(set-face-attribute 'default nil :font "Monaco 14")

;;Chinese Font
(dolist (charset '(kana han symbol cjk-misc bopomofo))
  (set-fontset-font (frame-parameter nil 'font) charset (font-spec :family "楷体-简" :size 16))) 



 (provide 'init-font)
