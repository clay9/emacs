(require 'calendar)
(require 'appt)
(require 'cal-china)
(require 'cal-china-x)

;; 写入农历日期 获取最近的对应的阳历日期
(defun get-lunar-day (lunar-month lunar-day)
  (let* ((current-month (car (calendar-current-date)))
	 (current-year (cadr (cdr (calendar-current-date))))	 
	 (cn-years (calendar-chinese-year ; calendar-chinese-year counts from 12 for last year
                    (if (and (eq current-month 12) (eq lunar-month 12))
                        (1+ current-year)
                      current-year)))
	 (run-yue (assoc lunar-month cn-years))
	 (date (calendar-gregorian-from-absolute
                (+ (cadr run-yue) (1- lunar-day))))
	 )
    date))

(message "%s" (get-lunar-day 9 17))
;; ****************************************************
;; Calendar && Diary
;; ****************************************************
;; init-cal-china-x 中国节日
(setq mark-holidays-in-calendar t)
(setq cal-china-x-important-holidays cal-china-x-chinese-holidays)
(setq cal-china-x-general-holidays '((holiday-lunar 1 15 "元宵节")))
(setq calendar-holidays
      (append cal-china-x-important-holidays
              cal-china-x-general-holidays))


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

