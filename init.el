;;在文件最开头添加地个 文件作用域的变量设置，设置变量的绑定方式
;; -*- lexical-binding: t -*-
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;add package load-path 
; (add-to-list 'load-path "~/.emacs.d/package/company-mode")
; (add-to-list 'load-path "~/.emacs.d/package/company-lua")
; (add-to-list 'load-path "~/.emacs.d/package/f")
; (add-to-list 'load-path "~/.emacs.d/package/s")
; (add-to-list 'load-path "~/.emacs.d/package/dash")
; ; (add-to-list 'load-path "~/.emacs.d/package/lua-mode")
; (add-to-list 'load-path "~/.emacs.d/package/neotree")
; (add-to-list 'load-path "~/.emacs.d/package/projectile")
; (add-to-list 'load-path "~/.emacs.d/package/find-file-in-project")

;;add theme load-path
; (add-to-list 'load-path "~/.emacs.d/theme/color-theme")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;BUG;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(eval-when-compile (setq lexical-binding t))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;基础设置
;; init.el
;;关闭启动画面
(setq inhibit-startup-message t)
; 在全局上显示列号
(global-linum-mode t)

;; all backups goto ~/.backups instead in the current directory
(setq backup-directory-alist (quote (("." . "~/.emacs-backups"))))

;在 Window 显示行号
;;(global-display-line-numbers-mode 1)

;;高亮当前行
(global-hl-line-mode t)

;;关闭滚动条
(scroll-bar-mode -1)
;;工具栏
(tool-bar-mode 0)
;;菜单栏
(menu-bar-mode 1)
;;允许emacs和外部其他程序的粘贴
(setq x-select-enable-clipboard t)

;;设置F9快捷键指定Emacs 的日历系统
(global-set-key [f9] 'calendar)

;; 设置光标为竖线
(setq-default cursor-type '(bar . 5))
;; 设置光标为方块

;; (setq-default cursor-type 'box)
;; 快速打开配置文件
(defun open-init-file()
  (interactive)
  (find-file "~/.emacs.d/init.el"))

;; 这一行代码，将函数 open-init-file 绑定到 <f2> 键上
(global-set-key (kbd "<f2>") 'open-init-file)

;; 更改显示字体大小 16pt
;; http://stackoverflow.com/questions/294664/how-to-set-the-font-size-in-emacs
(set-face-attribute 'default nil :height 120);;

;;让鼠标滚动更好用
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1) ((control) . nil)))
(setq mouse-wheel-progressive-speed nil)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; (custom-set-variables
;  ;; custom-set-variables was added by Custom.
;  ;; If you edit it by hand, you could mess it up, so be careful.
;  ;; Your init file should contain only one such instance.
;  ;; If there is more than one, they won't work right.
;  '(package-selected-packages
;    '(projectile consult embark marginalia orderless vertico company)))
; (custom-set-faces
;  ;; custom-set-faces was added by Custom.
;  ;; If you edit it by hand, you could mess it up, so be careful.
;  ;; Your init file should contain only one such instance.
;  ;; If there is more than one, they won't work right.
;  )
;;-----------------------------------------自定义按键----------------------------------------------
;; copy region or whole line
(global-set-key "\M-w"
(lambda ()
  (interactive)
  (if mark-active
      (kill-ring-save (region-beginning)
      (region-end))
    (progn
     (kill-ring-save (line-beginning-position)
     (line-end-position))
     (message "copied line")))))


;; Kill region or whole line
(global-set-key "\C-w"
(lambda ()
  (interactive)
  (if mark-active
      (kill-region (region-beginning)
   (region-end))
    (progn
     (kill-region (line-beginning-position)
  (line-end-position))
     (message "killed line")))))


;;------------------------------------------------------------------------------------------------
;;load theme
; (require 'color-theme)
; (color-theme-initialize)
; (color-theme-monokai)
;;---------------------------------------------配置源begin---------------------------------------------
(require 'package)
; (setq package-archives '(("gnu"   . "http://elpa.zilongshanren.com/gnu/")

;        ("melpa" . "http://elpa.zilongshanren.com/melpa/")))
(setq package-archives '(("gnu"   . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
                         ("melpa" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")))
; (setq package-archives '(("gnu"   . "http://1.15.88.122/gnu/")
;                           ("melpa" . "http://1.15.88.122/melpa/")))
(package-initialize)

;;防止反复调用 package-refresh-contents 会影响加载速度
(when (not package-archive-contents)
  (package-refresh-contents))

; ;;modeline上显示我的所有的按键和执行的命令
; (package-install 'keycast)
; (keycast-mode t)
;;---------------------------------------------配置源end-------------------------------------------
;;---------------------------------------------包管理begin-------------------------------------------

(global-company-mode 1)
(setq company-minmum-prefix-length 1)
(setq company-idle-delay 0)
;; company mode 默认选择上一条和下一条候选项命令 M-n M-p
(define-key company-active-map (kbd "C-n") 'company-select-next)
(define-key company-active-map (kbd "C-p") 'company-select-previous)

(package-install 'vertico)
(vertico-mode t)

(package-install 'orderless)
(setq completion-styles '(orderless))

(package-install 'marginalia)
(marginalia-mode t)

(package-install 'embark)
(global-set-key (kbd "C-;") 'embark-act)
(setq prefix-help-command 'embark-prefix-help-command)

(package-install 'consult)
;;replace swiper
(global-set-key (kbd "C-c C-s") 'consult-line)
;;consult-imenu

(package-install 'projectile)
(projectile-mode +1)
(define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
;;---------------------------------------------包管理end-------------------------------------------
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(vertico projectile orderless marginalia embark consult company)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
