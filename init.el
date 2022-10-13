;; init.el
; 在 Mode line 上显示列号
(column-number-mode t)

;; all backups goto ~/.backups instead in the current directory
(setq backup-directory-alist (quote (("." . "~/.emacs-backups"))))

; 在 Window 显示行号
; (global-display-line-numbers-mode 1) ;;ERROR
