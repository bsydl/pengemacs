;; init.el
; 在全局上显示列号
(global-linum-mode t)

;; all backups goto ~/.backups instead in the current directory
(setq backup-directory-alist (quote (("." . "~/.emacs-backups"))))

;在 Window 显示行号
;;(global-display-line-numbers-mode 1)

;;高亮当前行
(global-hl-line-mode t)
