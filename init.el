;;在文件最开头添加地个 文件作用域的变量设置，设置变量的绑定方式
;; -*- lexical-binding: t -*-
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(add-to-list 'load-path "~/.emacs.d/package/company-ctags/company-ctags")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;BUG;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(eval-when-compile (setq lexical-binding t))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;基础设置
;; init.el
;;关闭启动画面
(setq inhibit-startup-message t)
; 在全局上显示列号
;;(global-linum-mode t)

;; all backups goto ~/.backups instead in the current directory
(setq backup-directory-alist (quote (("." . "~/.emacs-backups"))))

;在 Window 显示行号
(global-display-line-numbers-mode 1)

;;高亮当前行
(global-hl-line-mode t)

;;关闭滚动条
;(scroll-bar-mode -1)
;;工具栏
;(tool-bar-mode 0)
;;菜单栏
;(menu-bar-mode 1)

;;隐藏式（）
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode 1))


;;允许emacs和外部其他程序的粘贴
(setq x-select-enable-clipboard t)

;;设置F9快捷键指定Emacs 的日历系统
(global-set-key [f9] 'calendar)

;; 设置光标为竖线
(setq-default cursor-type '(bar . 5))

;; 更改显示字体大小 16pt
;; http://stackoverflow.com/questions/294664/how-to-set-the-font-size-in-emacs
(set-face-attribute 'default nil :height 120);;

;;让鼠标滚动更好用
;(setq mouse-wheel-scroll-amount '(1 ((shift) . 1) ((control) . nil)))
;(setq mouse-wheel-progressive-speed nil)

;;快速窗口跳转 shift + 方向键
;; use Shift+arrow_keys to move cursor around split panes
(windmove-default-keybindings)

;; when cursor is on edge, move to the other side, as in a toroidal space
(setq windmove-wrap-around t )
;;-----------------------------------------org_mode----------------------------------------------
;;日期
(setq org-log-done 'time)
;；开启自动转行
(setq truncate-lines 1)

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

;;忽略本行新建新的一行
(global-set-key (kbd "C-<return>")
(lambda ()
  (interactive)
     (end-of-line)
     (newline)))

;; (setq-default cursor-type 'box)
;; 快速打开配置文件
(defun open-init-file()
  (interactive)
  (find-file "~/.emacs.d/init.el"))

;; 这一行代码，将函数 open-init-file 绑定到 <f2> 键上
(global-set-key (kbd "<f2>") 'open-init-file)

;;------------------------------------------------主题theme------------------------------------------------
;;load theme
; (require 'monokai-theme)
; (load-theme 'monokai t)



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


;;---------------------------------------------配置源end-------------------------------------------
;;---------------------------------------------包管理begin-------------------------------------------
; ;;modeline上显示我的所有的按键和执行的命令
(package-install 'keycast)
(require 'keycast)
(keycast-mode t)

(package-install 'company)
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
(global-set-key [f5] 'project-find-file)
(global-set-key [f6] 'project-switch-project)

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

(package-install 'monokai-theme)
(load-theme 'monokai t)

(package-install 'lua-mode)
;; (load-theme 'monokai t)
(require 'company-ctags)
(with-eval-after-load 'company
  (company-ctags-auto-setup))

;;C/C++ begin------------
;; eglot begin
(require 'eglot)
(add-to-list 'eglot-server-programs '((c++-mode c-mode) "clangd"))
(add-hook 'c-mode-hook #'eglot-ensure)
(add-hook 'c++-mode-hook #'eglot-ensure)
;; eglot end
;; C/C++ end

;; Erlang begin ----------
;;emacs 是erlang选中的官方IDE，所以自带erlang配置但需要下面这段配置
(setq load-path (cons  "C:/Program Files/Erlang OTP/lib/tools-3.5.3/emacs" load-path))
(setq erlang-root-dir "C:/Program Files/Erlang OTP")
(setq exec-path (cons "C:/Program Files/Erlang OTP/bin" exec-path))

(require 'erlang-start)
(put 'narrow-to-region 'disabled nil)


(add-to-list 'auto-mode-alist '("\\.erl?$" . erlang-mode))
(add-to-list 'auto-mode-alist '("\\.hrl?$" . erlang-mode))
;; Erlang end ---------

(add-to-list 'load-path
              "~/.emacs.d/package/yasnippet")
(require 'yasnippet)
(yas-global-mode 1) ;;设置为全局模式，在任何mode中是生效的
(setq yas-snippet-dirs
      '("~/.emacs.d/snippets"                 ;; personal snippets
        "~/.emacs.d/elpa/yasnippet-snippets-20240221.1621/snippets"
        ))

;;multiple-cursors
(require 'multiple-cursors)
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)
;;---------------------------------------------包管理end-------------------------------------------
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(multiple-cursors vertico projectile orderless marginalia embark consult company)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'scroll-left 'disabled nil)
