(setq ring-bell-function 'ignore)
(setq inhibit-splash-screen 1)
(setq make-backup-files nil)
(setq org-src-fontify-natively t)

(add-hook 'org-mode-hook 'word-like-count-mode)

(add-hook 'org-mode-hook 'toggle-truncate-lines)

(setq package-archives '(
    ;;("melpa" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")
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


;;设置窗口位置为屏库左上角(0,0)
(set-frame-position (selected-frame) 105 25)
;;设置宽和高,我的十寸小本是110,33,大家可以调整这个参数来适应自己屏幕大小
(set-frame-width (selected-frame) 99)
(set-frame-height (selected-frame) 27);; 更改显示字体大小 16pt
;; http://stackoverflow.com/questions/294664/how-to-set-the-font-size-in-emacs
(set-face-attribute 'default nil :height 160)
;; 快速打开配置文件
(defun open-init-file()
  (interactive)
  (find-file "~/.emacs.d/init.el"))

;; 这一行代码，将函数 open-init-file 绑定到 <f2> 键上
(global-set-key (kbd "<f2>") 'open-init-file)

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

;;(add-to-list 'load-path "~/.emacs.d/myinit.org")

(setq inhibit-startup-message t)
(tool-bar-mode -1)
(fset 'yes-or-no-p 'y-or-n-p)
;;(global-set-key (kbd "<f5>") 'revert-buffer)

(use-package monokai-pro-theme
:ensure t
:config (load-theme 'monokai-pro-machine t))


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
    (borg unicad ace-window counsel auto-complete monokai-pro-theme tabbar which-key try use-package restart-emacs org-bullets))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(aw-leading-char-face ((t (:inherit ace-jump-face-foreground :height 3.0)))))
