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
(require 'color-theme)
(color-theme-initialize)
(color-theme-monokai)
;;helm---------------------------------
(add-to-list 'load-path "~/.emacs.d/package/emacs-async")
(add-to-list 'load-path "~/.emacs.d/package/helm")
(require 'helm)
; (global-set-key (kbd "M-x") 'helm-M-x)
; (global-set-key (kbd "C-x C-f") 'helm-find-files)
;;(helm-mode 1)
;;------------------------------------
;;ag------------------------------------begin
(add-to-list 'load-path "~/.emacs.d/package/ag.el")

;;--------------------------------------end
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
;;projectile------------------------------------------------
(require 'projectile )

;; 默认全局使用
; (projectile-global-mode)
;(setq projectile-switch-project-action #'projectile-dired)
;; 默认打开缓存
; (setq projectile-enable-caching t)
; (setq projectile-indexing-method 'native)
(setq projectile-cache-file (expand-file-name ".cache/projectile.cache" user-emacs-directory))
; ; ;;【现在就像浏览自己本地文件目录一样，也可以编辑响应缓慢的问题可以通过添加这行来解决】
; (setq projectile-mode-line "Projectile") 
(projectile-mode 1)
(define-key projectile-mode-map (kbd "C-c C-p") 'projectile-command-map)
;; 使用f5键打开默认文件搜索
; (global-set-key [f6] 'projectile-find-file)
;;---------------------------------------------------------end
;;ffip-------------------------------------------------------
;;导入ffip
; (require 'find-file-in-project)
; (setq ffip-prefer-ido-mode t)
;;---------------------------------------------------------end

;;edwina---------------------------------------
; (add-to-list 'load-path "~/.emacs.d/package/edwina")
; (require 'edwina)

; (setq display-buffer-base-action '(display-buffer-below-selected))
; ;; 以下定义会被 (edwina-setup-dwm-keys) 增加 'M-' 修饰。
; ;; 我自定义了一套按键，因为原版会把我很常用的 M-d 覆盖掉。
; (setq edwina-dwm-key-alist
;       '(("r" edwina-arrange)
;         ("j" edwina-select-next-window)
;         ("k" edwina-select-previous-window)
;         ("J" edwina-swap-next-window)
;         ("K" edwina-swap-previous-window)
;         ("h" edwina-dec-mfact)    ;; 主窗口缩窄
;         ("l" edwina-inc-mfact)    ;; 主窗口拉宽
;         ("D" edwina-dec-nmaster)  ;; 减少主窗口的数量
;         ("I" edwina-inc-nmaster)  ;; 增加主窗口的数量
;         ("C" edwina-delete-window) ;; 关闭窗口
;         ("RET" edwina-zoom t)     ;; 交换「主窗口」和「副窗口」
;         ("return" edwina-zoom t)
;         ("S-RET" edwina-clone-window t) ;; 复制一个本窗口
;         ("S-return" edwina-clone-window t)))
; (edwina-setup-dwm-keys)
; (edwina-mode 1)

; (use-package edwina
;   :ensure t
;   :config
;   (setq display-buffer-base-action '(display-buffer-below-selected))
;   (edwina-setup-dwm-keys)
;   (edwina-mode 1))

;;winum--------------------------------------
(add-to-list 'load-path "~/.emacs.d/package/emacs-winum")
(require 'winum)
(winum-mode)
