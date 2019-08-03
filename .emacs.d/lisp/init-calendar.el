;; ****************************************************
;; Calendar && Diary
;; ****************************************************
;; set first day is monday
(setq calendar-week-start-day 1)
;; diary file
(setq diary-file "~/GTD/BigDay/BigDay")
;; open diary
(diary)

;; open appt
(appt-activate t)
(setq appt-audible nil)
(setq appt-display-format (quote window))
(setq appt-display-duration 40)
(setq appt-display-interval 1)
(setq appt-message-warning-time 4)

;; 
(setq diary-display-function (quote diary-fancy-display))


(provide 'init-calendar)
