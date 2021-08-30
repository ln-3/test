(setq package-archives '(
    ("melpa" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")
    ("gnu" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
    ("org" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/org/")
    ("gnu"   . "http://elpa.emacs-china.org/gnu/")
    ("melpa" . "http://elpa.emacs-china.org/melpa/")
    ("melpa" . "https://melpa.org/packages/")
    ))

(setq package-check-signature nil);;个别时候会出现签名校验失败
(require 'package) ;; 初始化包管理器
(unless (bound-and-true-p package--initialized)
   (package-initialize)) ;; 刷新软件源索引
(unless package-archive-contents
    (package-refresh-contents))

(unless (package-installed-p 'use-package)
   (package-refresh-contents)
   (package-install 'use-package))

(eval-and-compile
    (setq use-package-always-ensure t) ;不用每个包都手动添加:ensure t关键字
    (setq use-package-always-defer t) ;默认都是延迟加载，不用每个包都手动添加:defer t
    (setq use-package-always-demand nil)
    (setq use-package-expand-minimally t)
    (setq use-package-verbose t))

;; 最简洁的格式
(use-package restart-emacs
  :ensure t)







(setq ring-bell-function 'ignore)
(setq inhibit-splash-screen 1)
(setq make-backup-files nil)
(setq org-src-fontify-natively t)

(add-hook 'org-mode-hook 'word-like-count-mode)

(add-hook 'org-mode-hook 'toggle-truncate-lines)

(setq inhibit-startup-message t)
(tool-bar-mode -1)
(fset 'yes-or-no-p 'y-or-n-p)
(global-set-key (kbd "<f5>") 'revert-buffer)

(use-package monokai-pro-theme
:ensure t
:config (load-theme 'monokai-pro-machine t))

(use-package try
  :ensure t)






(defalias 'list-buffers 'ibuffer) ; make ibuffer default
(defalias 'list-buffers 'ibuffer-other-window) ; make ibuffer default

(windmove-default-keybindings)
; add this to init.el
(use-package ace-window
:ensure t
:init
(progn
(global-set-key [remap other-window] 'ace-window)
(custom-set-faces
'(aw-leading-char-face
((t (:inherit ace-jump-face-foreground :height 3.0)))))
))
(winner-mode 1)

;; it looks like counsel is a requirement for swiper
(use-package counsel
:ensure t
)

(use-package swiper
:ensure try
:config
(progn
(ivy-mode 1)
(setq ivy-use-virtual-buffers t)
(global-set-key "\C-s" 'swiper)
(global-set-key (kbd "C-c C-r") 'ivy-resume)
(global-set-key (kbd "<f6>") 'ivy-resume)
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
(global-set-key (kbd "<f1> f") 'counsel-describe-function)
(global-set-key (kbd "<f1> v") 'counsel-describe-variable)
(global-set-key (kbd "<f1> l") 'counsel-load-library)
;;(global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
;;(global-set-key (kbd "<f2> u") 'counsel-unicode-char)
(global-set-key (kbd "C-c g") 'counsel-git)
(global-set-key (kbd "C-c j") 'counsel-git-grep)
(global-set-key (kbd "C-c k") 'counsel-ag)
(global-set-key (kbd "C-x l") 'counsel-locate)
(global-set-key (kbd "C-S-o") 'counsel-rhythmbox)
(define-key read-expression-map (kbd "C-r") 'counsel-expression-history)
))







;; 关闭工具栏，tool-bar-mode 即为一个 Minor Mode
(tool-bar-mode -1)

;; 关闭文件滑动控件
(scroll-bar-mode -1)

;; 显示行号
(global-linum-mode 1)

;; 更改光标的样式（不能生效，解决方案见第二集）
(setq cursor-type 'bar)

;; 关闭启动帮助画面
(setq inhibit-splash-screen 1)

;; 关闭缩进 (第二天中被去除)
;; (electric-indent-mode -1)

;; 更改显示字体大小 16pt
;; http://stackoverflow.com/questions/294664/how-to-set-the-font-size-in-emacs
(set-face-attribute 'default nil :height 160)

;; 快速打开配置文件
(defun open-init-file()
  (interactive)
  (find-file "~/.emacs.d/init.el"))

;; 这一行代码，将函数 open-init-file 绑定到 <f2> 键上
(global-set-key (kbd "<f2>") 'open-init-file)

(setq-default cursor-type 'bar)


(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-item 10)

(delete-selection-mode 1)

;; 这个快捷键绑定可以用之后的插件 counsel 代替
;; (global-set-key (kbd "C-x C-r") 'recentf-open-files)


(add-hook 'emacs-lisp-mode-hook 'show-paren-mode)
(global-hl-line-mode 1)


(defconst *is-mac* (eq system-type 'darwin))
(defconst *is-linux* (eq system-type 'gnu/linux))
(defconst *is-windows* (or (eq system-type 'ms-dos) (eq system-type 'windows-nt)))
(use-package emacs
  :if (display-graphic-p)
  :config
  ;; Font settings
  (if *is-windows*
    (progn
      (set-face-attribute 'default nil :font "宋体")
      (dolist (charset '(kana han symbol cjk-misc bopomofo))
        (set-fontset-font (frame-parameter nil 'font) charset (font-spec :family "宋体" ))))
    (set-face-attribute 'default nil :font "Whitney book")))


;;设置窗口位置为屏库左上角(0,0)
(set-frame-position (selected-frame) 105 25)
;;设置宽和高,我的十寸小本是110,33,大家可以调整这个参数来适应自己屏幕大小
(set-frame-width (selected-frame) 99)
(set-frame-height (selected-frame) 27);; 更改显示字体大小 16pt
;; http://stackoverflow.com/questions/294664/how-to-set-the-font-size-in-emacs
(set-face-attribute 'default nil :height 160)




(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (monokai-pro-machine)))
 '(custom-safe-themes
   (quote
    ("b02eae4d22362a941751f690032ea30c7c78d8ca8a1212fdae9eecad28a3587f" default)))
 '(package-selected-packages
   (quote
    (which-key use-package try restart-emacs monokai-pro-theme))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(aw-leading-char-face ((t (:inherit ace-jump-face-foreground :height 3.0)))))
