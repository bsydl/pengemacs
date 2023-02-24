;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;add package load-path 
(add-to-list 'load-path "~/.emacs.d/package/company-mode")
(add-to-list 'load-path "~/.emacs.d/package/company-lua")
(add-to-list 'load-path "~/.emacs.d/package/f")
(add-to-list 'load-path "~/.emacs.d/package/s")
(add-to-list 'load-path "~/.emacs.d/package/dash")
(add-to-list 'load-path "~/.emacs.d/package/luaMode")
(add-to-list 'load-path "~/.emacs.d/package/neotree")
(add-to-list 'load-path "~/.emacs.d/package/projectile")
(add-to-list 'load-path "~/.emacs.d/package/find-file-in-project")
;;add theme load-path
(add-to-list 'load-path "~/.emacs.d/theme/color-theme")

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
(menu-bar-mode 0)
;;允许emacs和外部其他程序的粘贴
(setq x-select-enable-clipboard t)

;;设置F9快捷键指定Emacs 的日历系统
(global-set-key [f9] 'calendar)

;; 设置光标为竖线
(setq-default cursor-type 'box)
;; 设置光标为方块
;; (setq-default cursor-type 'box)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(company)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.x
 ;; If there is more than one, they won't work right.
 )

;;镜像
(require 'package)
(setq package-archives                                                                                           
      '(("melpa"  . "http://elpa.zilongshanren.com/melpa/")
	("gnu"    . "http://elpa.zilongshanren.com/gnu/")
	("nongnu" . "https://mirrors.sjtug.sjtu.edu.cn/emacs-elpa/nongnu/")))

; (package-initialize)

; (unless (package-installed-p 'use-package)
;   (package-refresh-contents)
;   (package-install 'use-package))

; (use-package company
;   :ensure t
;   :init (global-company-mode)
;   :config
;   (setq company-minimum-prefix-length 1) ; 只需敲 1 个字母就开始进行自动补全
;   (setq company-tooltip-align-annotations t)
;   (setq company-idle-delay 0.0)
;   (setq company-show-numbers t) ;; 给选项编号 (按快捷键 M-1、M-2 等等来进行选择).
;   (setq company-selection-wrap-around t)
;   (setq company-transformers '(company-sort-by-occurrence))) ; 根据选择的频率进行排序，读者如果不喜欢可以去掉

;;load theme
(require 'color-theme)
(color-theme-initialize)
(color-theme-monokai)


;;;; This snippet enables lua-mode
(autoload 'lua-mode "lua-mode" "Lua editing mode." t)
(add-to-list 'auto-mode-alist '("\\.lua$" . lua-mode))
(add-to-list 'interpreter-mode-alist '("lua" . lua-mode))

(require 'company)
(require 'company-lua)

(add-hook 'after-init-hook'global-company-mode)

(defun my-lua-mode-company-init ()
  (setq-local company-backends '((company-lua
                                  company-etags
                                  company-dabbrev-code
                                  company-yasnippet))))
(add-hook 'lua-mode-hook #'my-lua-mode-company-init)

;;neotree package
(require 'neotree)
(global-set-key [f5] 'neotree-toggle)
(global-set-key [f8] 'neotree-refresh)

(require 'projectile )

;; 默认全局使用
; (projectile-global-mode)
;;(setq projectile-switch-project-action #'projectile-dired)
;; 默认打开缓存
(setq projectile-enable-caching t)
(setq projectile-indexing-method 'native)
 
; ;;【现在就像浏览自己本地文件目录一样，也可以编辑响应缓慢的问题可以通过添加这行来解决】
; (setq projectile-mode-line "Projectile") 
 
;; 使用f5键打开默认文件搜索
(global-set-key [f6] 'projectile-find-file)
;;导入ffip
(require 'find-file-in-project)

(setq ffip-prefer-ido-mode t)

; ;;emacs neotree/neotree.el
; (defcustom neo-window-width 25
;   "*Specifies the width of the NeoTree window."
;   :type 'integer
;   :group 'neotree)