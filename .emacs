(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(current-language-environment "Japanese")
 '(custom-safe-themes
   '("dad622637530638a2140b83812e159a06b4791eb2f67ffd4abb4ff671b062d0b" "3b8284e207ff93dfc5e5ada8b7b00a3305351a3fb222782d8033a400a48eca48" default))
 '(package-archives
   '(("gnu" . "https://elpa.gnu.org/packages/")
     ("melpa" . "https://melpa.org/packages/")))
 '(package-selected-packages
   '(## cyberpunk-theme solidity-flycheck pdf-tools exec-path-from-shell jedi elpy imenu-list flycheck company mwim zenburn-theme)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


;;shellの文字化け
(setenv "LC_ALL" "ja_JP.UTF-8")

;; load environment variables
(let ((envs '("PATH" "VIRTUAL_ENV" "GOROOT" "GOPATH")))
  (exec-path-from-shell-copy-envs envs))

;;highlight
(add-hook 'prig-mode-hook 'highlight-indent-guides-mode)

;;zunburn
;; GUI
(when window-system (progn
    ;;(load-theme 'cyberpunk t)
    ;;(load-theme 'zenburn t)
    ;;(set-face-attribute 'highlight nil :foreground 'unspecified)
    (load-theme 'modus-vivendi)
))
;; CUI
(when (not window-system) (progn
    ;;(load-theme 'tango-dark t)
    ;;(load-theme 'manoj-dark t)
    ;;(load-theme 'zenburn t)
    (load-theme 'modus-vivendi)
    (set-face-attribute 'highlight nil :foreground 'unspecified)
))

;;beep sound
(setq ring-bell-function 'ignore)

;; C-l clear shell
(defun eshell-clear-buffer ()
  "Clear terminal"
  (interactive)
  (let ((inhibit-read-only t))
    (erase-buffer)
    (eshell-send-input)))
(add-hook 'eshell-mode-hook
      '(lambda()
          (local-set-key (kbd "C-l") 'eshell-clear-buffer)))

;;補完
(require 'company)
(global-company-mode) ; 全バッファで有効にする 
(setq company-idle-delay 0) ; デフォルトは0.5
(setq company-minimum-prefix-length 2) ; デフォルトは4
(setq company-selection-wrap-around t) ; 候補の一番下でさらに下に行こうとすると一番上に戻る

;;flycheck
(add-hook 'after-init-hook #'global-flycheck-mode)

;;flycheck for solidity
(require 'flycheck)
(require 'solidity-mode)
(add-to-list 'flycheck-checkers 'solidity-checker)

;;再度読み込み
(defun revert-buffer-no-confirm (&optional force-reverting)
  "Interactive call to revert-buffer. Ignoring the auto-save
 file and not requesting for confirmation. When the current buffer
 is modified, the command refuses to revert it, unless you specify
 the optional argument: force-reverting to true."
  (interactive "P")
  ;;(message "force-reverting value is %s" force-reverting)
  (if (or force-reverting (not (buffer-modified-p)))
      (revert-buffer :ignore-auto :noconfirm)
    (error "The buffer has been modified")))

; reload buffer
(global-set-key (kbd "M-r") 'revert-buffer-no-confirm)


;; スタート時のスプラッシュ非表示
(setq inhibit-startup-message t)

;;; 色を付ける
(global-font-lock-mode t)

;;; バックアップファイルを作らない
(setq backup-inhibited t)

;;; スクロールバーを右側に表示する
;; GUI
(when window-system (progn
   (scroll-bar-mode -1)
))
;; CUI
(when (not window-system) (progn
))

;;; 画面右端で折り返さない
(setq-default truncate-lines t)
(setq truncate-partial-width-windows t)

;;; 現在の関数名をモードラインに表示
(which-function-mode 1)

;;; タブをスペース4字
(setq-default tab-width 4 indent-tabs-mode nil)

;; 行番号の表示
(if (version<= "26.0.50" emacs-version)
    (progn
      (global-display-line-numbers-mode)
      (set-face-attribute 'line-number nil
                          :foreground "gray")
                          ;;:background "#131521")
      (set-face-attribute 'line-number-current-line nil
                          :foreground "gold")))

;; フルスクリーン化
(global-set-key (kbd "<M-return>") 'toggle-frame-fullscreen)

(setq scroll-preserve-screen-position t)

(define-key global-map (kbd "C-\\") 'hs-toggle-hiding)

;;スクロール
;;(setq scroll-conservatively 1)(
(setq next-screen-context-lines 40)


(setq default-frame-alist
      (append '((width                . 100)  ; フレーム幅
                (height               . 50 ) ; フレーム高
             ;; (left                 . 70 ) ; 配置左位置
             ;; (top                  . 28 ) ; 配置上位置
                (line-spacing         . 0  ) ; 文字間隔
                ;;(left-fringe          . 10 ) ; 左フリンジ幅
                ;;(right-fringe         . 11 ) ; 右フリンジ幅
                (menu-bar-lines       . 1  ) ; メニューバーCS
                (tool-bar-lines       . -1  ) ; ツールバー
                ;;(vertical-scroll-bars . 1  ) ; スクロールバー
                ;;(scroll-bar-width     . 1 ) ; スクロールバー幅
                (cursor-type          . box) ; カーソル種別
                (alpha                . 100) ; 透明度
                ) default-frame-alist) )
(setq initial-frame-alist default-frame-alist)

(add-hook 'c++-mode-hook
          '(lambda ()
             (hs-minor-mode 1)))
(add-hook 'c-mode-hook
          '(lambda ()
             (hs-minor-mode 1)))
(add-hook 'scheme-mode-hook
          '(lambda ()
             (hs-minor-mode 1)))
(add-hook 'emacs-lisp-mode-hook
          '(lambda ()
             (hs-minor-mode 1)))
(add-hook 'lisp-mode-hook
          '(lambda ()
             (hs-minor-mode 1)))
(add-hook 'python-mode-hook
          '(lambda ()
             (hs-minor-mode 1)))
(add-hook 'ruby-mode-hook
          '(lambda ()
             (hs-minor-mode 1)))
(add-hook 'xml-mode-hook
          '(lambda ()
             (hs-minor-mode 1)))

;;PDFファイルをdoc viewで開き、自動更新する
(add-hook 'doc-view-mode-hook 'auto-revert-mode)

(defun move-line-down ()
  (interactive)
    (forward-line 5))

(defun move-line-up ()
    (interactive)
    (if (>= emacs-major-version 24)
    (forward-line -5)))          

(global-set-key (kbd "M-p") 'move-line-up)
(global-set-key (kbd "M-n") 'move-line-down)
