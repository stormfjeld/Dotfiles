
(setq inhibit-startup-message t)

(scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)
(set-fringe-mode 10)

(menu-bar-mode -1)

(set-face-attribute 'default nil :font "Fira Code" :height 100)

;; package-management
(require 'package)

(setq package-archives ' (("melpa" . "https://melpa.org/packages/")
			  ("org" . "https://orgmode.org/elpa/")
			  ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; use-package
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(load-file "/home/storm/.emacs.d/discord-emacs.el")
(discord-emacs-run "384815451978334208")

(require 'use-package)
(setq use-package-always-ensure t)

(column-number-mode)
(global-display-line-numbers-mode t)

;; Disable it in some modes
(dolist(mode '(org-mode-hook
	       term-mode-hook
	       eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

;; Ivy Completions
(use-package ivy
  :diminish
  :bind (("C-s" . swiper)
	 :map ivy-minibuffer-map
	 ("TAB" . ivy-alt-done)
	 ("C-l" . ivy-alt-done)
	 ("C-j" . ivy-next-line)
	 ("C-k" . ivy-previous-line)
	 :map ivy-switch-buffer-map
	 ("C-k" . ivy-previous-line)
	 ("C-d" . ivy-reverse-i-search-kill))
  :config
  (ivy-mode 1))

(use-package counsel
  :bind (("M-x" . counsel-M-x)
	 ("C-x b" . counsel-ibuffer)
	 ("C-x C-f" . counsel-find-file)
	 :map minibuffer-local-map
	 ("C-r" . counsel-minibuffer-history)))

;; Bindings
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

;; General Keybinding setup
(use-package general
  :config
  (general-evil-setup t))

;; Buffers & Bookmarks
(nvmap :prefix "SPC"
  "b b"   '(ibuffer :which-key "Ibuffer")
  "b c"   '(clone-indirect-buffer-other-window :which-key "Clone indirect buffer other window")
  "b k"   '(kill-current-buffer :which-key "Kill current buffer")
  "b n"   '(next-buffer :which-key "Next buffer")
  "b p"   '(previous-buffer :which-key "Previous buffer")
  "b B"   '(ibuffer-list-buffers :which-key "Ibuffer list buffers")
  "b K"   '(kill-buffer :which-key "Kill buffer"))

;; Eval
(nvmap :states '(normal visual) :keymaps 'override :prefix "SPC"
  "e b"   '(eval-buffer :which-key "Eval elisp in buffer")
  "e d"   '(eval-defun :which-key "Eval defun")
  "e e"   '(eval-expression :which-key "Eval elisp expression")
  "e l"   '(eval-last-sexp :which-key "Eval last sexression")
  "e r"   '(eval-region :which-key "Eval region"))

;; File management keybinds
(nvmap :states '(normal visual) :keymaps 'override :prefix "SPC"
       "."     '(counsel-find-file :which-key "Find file")
       "f f"   '(find-file :which-key "Find file")
       "f r"   '(counsel-recentf :which-key "Recent files")
       "f s"   '(save-buffer :which-key "Save file")
       "f u"   '(sudo-edit-find-file :which-key "Sudo find file")
       "f y"   '(dt/show-and-copy-buffer-path :which-key "Yank file path")
       "f C"   '(copy-file :which-key "Copy file")
       "f D"   '(delete-file :which-key "Delete file")
       "f R"   '(rename-file :which-key "Rename file")
       "f S"   '(write-file :which-key "Save file as...")
       "f U"   '(sudo-edit :which-key "Sudo edit file"))

;; Evil mode
(use-package evil
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-want-vsplit-window-right t)
  (setq evil-want-split-window-below t)
  (evil-mode))
(use-package evil-collection
  :after evil
  :config
  (setq evil-collection-mode-list '(dashboard-dired ibuffer))
  (evil-collection-init))

;; Window Management
(winner-mode 1)
(nvmap :prefix "SPC"
       ;; Window splits
       "w c"   '(evil-window-delete :which-key "Close window")
       "w n"   '(evil-window-new :which-key "New window")
       "w s"   '(evil-window-split :which-key "Horizontal split window")
       "w v"   '(evil-window-vsplit :which-key "Vertical split window")
       ;; Window motions
       "w h"   '(evil-window-left :which-key "Window left")
       "w j"   '(evil-window-down :which-key "Window down")
       "w k"   '(evil-window-up :which-key "Window up")
       "w l"   '(evil-window-right :which-key "Window right")
       "w w"   '(evil-window-next :which-key "Goto next window")
       ;; winner mode
       "w <left>"  '(winner-undo :which-key "Winner undo")
       "w <right>" '(winner-redo :which-key "Winner redo"))

;; Elfeed
(use-package elfeed)

;; Org Roam
(use-package org-roam)

;; All-the-icons
;; M-x all-the-icons-install-fonts
(use-package all-the-icons)

;; Doom modeline
(use-package doom-modeline
  :init (doom-modeline-mode 1)
  :custom ((doom-modeline-height 15)))

;; Doom Themes
(use-package doom-themes
  :init (load-theme 'doom-gruvbox t))

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

;; Dashboard


;; Which Key
(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 0.3))

;; Helpful
(use-package helpful
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . counsel-describe-function)
  ([remap describe-command] . helpful-command)
  ([remap describe-variable] . counsel-describe-variable)
  ([remap describe-key] . helpful-key))

;; EXWM
;; defun storm/exwm-update-class ()
;;  (exwm-workspace-rename-buffer exwm-class-name))
;;
;; use-package exwm
;;  :config
;;  ;; Set the default number of workspaces
;;  (setq exwm-workspace-number 5)
;;
;;  ;; When window "class" updates, use it to set the buffer name
;;  ;; (add-hook 'exwm-update-class-hook #'efs/exwm-update-class)
;;
;;  ;; These keys should always pass through to Emacs
;;  (setq exwm-input-prefix-keys
;;    '(?\C-x
;;      ?\C-u
;;      ?\C-h
;;      ?\M-x
;;      ?\M-`
;;      ?\M-&
;;      ?\M-:
;;      ?\C-\M-j  ;; Buffer list
;;      ?\C-\ ))  ;; Ctrl+Space

  ;; Ctrl+Q will enable the next key to be sent directly
;;  (define-key exwm-mode-map [?\C-q] 'exwm-input-send-next-key)

  ;; Set up global key bindings.  These always work, no matter the input state!
  ;; Keep in mind that changing this list after EXWM initializes has no effect.
;;  (setq exwm-input-global-keys
;;        `(
;;          ;; Reset to line-mode (C-c C-k switches to char-mode via exwm-input-release-keyboard)
;;          ([?\s-r] . exwm-reset)
;;
;;          ;; Move between windows
;;          ([s-left] . windmove-left)
;;          ([s-right] . windmove-right)
;;          ([s-up] . windmove-up)
;;          ([s-down] . windmove-down)
;;
;;          ;; Launch applications via shell command
;;          ([?\s-&] . (lambda (command)
;;                       (interactive (list (read-shell-command "$ ")))
;;                       (start-process-shell-command command nil command)))
;;
;;          ;; Switch workspace
;;          ([?\s-w] . exwm-workspace-switch)
;;
;;          ;; 's-N': Switch to certain workspace with Super (Win) plus a number key (0 - 9)
;;          ,@(mapcar (lambda (i)
;;                      `(,(kbd (format "s-%d" i)) .
;;                        (lambda ()
;;                          (interactive)
;;                          (exwm-workspace-switch-create ,i))))
;;                    (number-sequence 0 9))))
;;
;;  (exwm-enable))

;; Dired

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(elfeed-feeds '("https://www.vg.no/rss/feed?categories=1069%2C1070"))
 '(package-selected-packages
   '(emacsql-sqlite3 doom-themes which-key rainbow-delimiters rainbow-delimeters use-package exwm)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
