;; ****************************************************
;; company-mode
;; ****************************************************
;; start up company-mode
(add-hook 'after-init-hook 'global-company-mode)

;; chose backends
(setq company-backends
   (quote
    (company-bbdb company-nxml company-css company-eclim company-xcode company-cmake company-capf company-files
		  (company-dabbrev-code company-gtags company-etags company-keywords)
		  company-oddmuse company-dabbrev)))


;; ****************************************************
;; company-c-headers
;; ****************************************************
;; include-system-path
(setq company-c-headers-path-system
   (quote
    ("/usr/include/" "/usr/local/include/" "/usr/include/c++/5.4.0/"
     "/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk/usr/include/"
     "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/usr/include/"
     "/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator.sdk/usr/include/"
     "/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/include/c"
     "/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk/usr/include/c++/4.2.1/"
     "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/usr/include/c++/4.2.1/"
     "/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator.sdk/usr/include/c++/4.2.1/"
    "/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/include/c++/v1/"
     )))
(add-to-list 'company-backends 'company-c-headers)


;; ****************************************************
;; color && format
;; ****************************************************
(custom-set-faces
 '(company-tooltip ((t (:foreground "white")))))


(provide 'init-company-mode)
