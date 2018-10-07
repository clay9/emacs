
 ;; ******************
 ;; Calendar && Diary
 ;; ******************

 ;; (dir) - emacs - Calendar/Diary - calendar motion - move to Beginning or end
(setq calendar-week-start-day 1)

 ;; (dir) - eamcs - Calendar/Diary - Diary - Displaying the Diary
(setq diary-file "~/GTD/BigDay/BigDay")
(diary)

 ;; (dir) - emacs - Calendar/Diary - Appointments
(appt-activate t)
(setq appt-audible nil)
(setq appt-display-format (quote window))
(setq appt-display-duration 40)
(setq appt-display-interval 1)
(setq appt-message-warning-time 4)


;; (dir) - emacs - Calendar/Diary - Advanced Calendar/Diary Usage - Diary Display
(setq diary-display-function (quote diary-fancy-display))



(provide 'init-calendar)
