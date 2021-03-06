;; use package
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

(use-package lsp-mode
  :commands lsp
  :ensure t
  :config
  (setq lsp-file-watch-threshold 10000)
  )

(use-package lsp-ui
  :commands lsp-ui-mode
  :ensure t
  )

(use-package company-lsp
  :ensure t
  :commands company-lsp
  :config (push 'company-lsp company-backends)
  )

(use-package ccls
  :ensure t
  :config
  (setq ccls-executable "ccls")
  (setq lsp-prefer-flymake nil)
  (setq-default flycheck-disabled-checkers '(c/c++-clang
                                             c/c++-cppcheck
                                             c/c++-gcc))
  :hook ((c-mode c++-mode objc-mode) . (lambda () (require 'ccls) (lsp)))
  )

(use-package lsp-python-ms
  :ensure t
  :init (setq lsp-python-ms-auto-install-server t)
  :hook (python-mode . (lambda () (require 'lsp-python-ms) (lsp)))
  )

(use-package color-theme-sanityinc-tomorrow
  :ensure t
  :init (load-theme 'sanityinc-tomorrow-night t)
  )

(use-package company
  :ensure t
  :config
  (add-hook 'after-init-hook 'global-company-mode)
  (setq company-idle-delay 0)
  (setq company-dabbrev-downcase 0)
  (setq company-minimum-prefix-length 1)
  (setq company-backends
        '((company-dabbrev-code company-keywords company-gtags company-etags company-yasnippet)
          company-bbdb
          company-eclim
          company-semantic
          company-xcode
          company-cmake
          company-capf
          company-files
          company-oddmuse
          company-dabbrev
          )
        )
  )

(use-package yasnippet
  :ensure t
  :config
  (use-package yasnippet-snippets
    :ensure t
    )
  (yas-global-mode 1)
  )

(use-package exec-path-from-shell
  :ensure t
  :config
  (when (eq system-type 'darwin)
    (exec-path-from-shell-initialize)
    )
  )

(use-package docker-tramp
  :ensure t
  )

(use-package git-auto-commit-mode
  :ensure t
  :hook (org-mode . git-auto-commit-mode)
  :config
  (setq gac-automatically-push-p t)
  (setq gac-automatically-add-new-files-p nil)
  )

(use-package ace-window
  :ensure t
  :bind ("<f1>" . 'ace-window)
  )

(use-package shackle
  :ensure t
  :init (shackle-mode 1)
  :config
  (setq shackle-rules '((compilation-mode
                         :noselect t
                         :align 'below
                         :size 0.3
                         :popup t
                         )
                        (vc-annotate-mode
                         :align 'below
                         :size 0.7
                         )
                        (gud-mode
                         :select t
                         :align 'below
                         :size 0.3
                         :popup t
                         )
                        (grep-mode
                         :select t
                         :align 'below
                         :size 0.3
                         :popup t
                         )
                        )
        shackle-default-rule '(:select t))
  (advice-add 'eshell-life-is-too-much :after 'my:close-on-exit)
  )

(use-package markdown-mode
  :ensure t
  )

(use-package protobuf-mode
  :ensure t
  )

(use-package nlinum
  :ensure t
  :hook (prog-mode . nlinum-mode)
  )

(use-package highlight-indentation
  :ensure t
  :hook (python-mode . highlight-indentation-current-column-mode)
  :custom-face (highlight-indentation-current-column-face ((t (:background "dark slate gray"))))
  )

(use-package ivy-xref
  :ensure t
  :init (setq xref-show-xrefs-function #'ivy-xref-show-xrefs)
  :bind ("C-]" . xref-find-definitions-other-window)
  )

(use-package counsel-projectile
  :ensure t
  :init (ivy-mode 1)
  :init (counsel-projectile-mode 1)
  ;; :bind ("C--" . ivy-pop-view)
  ;; :bind ("C-=" . ivy-push-view)
  ;; :bind ([f7] . ivy-switch-view)
  :bind ([f8] . counsel-semantic-or-imenu)
  :bind ([f9] . counsel-projectile)
  :bind (:map projectile-mode-map ("C-c p" . projectile-command-map))
  :config
  ;; (defadvice projectile-project-root (around ignore-remote first activate)
  ;;   (unless (file-remote-p default-directory) ad-do-it))
  )

(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook)
  (setq dashboard-items '((recents  . 16)
                          (projects . 8)
                          (agenda . t)
                          ;; (bookmarks . 8)
                          ;; (registers . 8)
                          )
        )
  (setq projectile-completion-system 'ivy)
  (setq dashboard-org-agenda-categories '("TODO" "IN-PROGRESS"))
  (add-to-list 'recentf-exclude (format "%s/\\.agendas/.*" (getenv "HOME")))
  (add-to-list 'recentf-exclude (format "%s/\\.emacs\\.d/elpa/.*" (getenv "HOME")))
  (add-to-list 'recentf-exclude (format "%s/TAGS" (getenv "HOME")))
  (add-to-list 'dashboard-org-agenda-categories "tasks")
  )

;; global key bindings
(global-set-key (kbd "C-?") 'my:grep-find-at-point)
(global-set-key (kbd "C-;") 'comment-line)
(global-set-key (kbd "C-:") 'goto-line)
(global-set-key (kbd "C-.") 'isearch-repeat-forward)
(global-set-key (kbd "C-,") 'isearch-repeat-backward)
(global-set-key (kbd "C-/") 'isearch-forward-symbol-at-point)
(global-set-key (kbd "C-a") 'mark-whole-buffer)
(global-set-key (kbd "C-f") 'isearch-forward)
(global-set-key (kbd "C-o") 'find-file)
(global-set-key (kbd "C-r") 'replace-string)
(global-set-key (kbd "C-s") 'save-buffer)
(global-set-key (kbd "C-t") 'find-tag)
(global-set-key (kbd "C-w") 'kill-current-buffer)
(global-set-key (kbd "C-q") 'kill-buffer-and-window)
(global-set-key (kbd "C-y") 'my:duplicate-line)
(global-set-key (kbd "C-c a") 'vc-annotate)
(global-set-key (kbd "C-c c") 'my:create-compile_commands.json)
(global-set-key (kbd "C-c f") 'swiper-isearch)
(global-set-key (kbd "C-c t") 'my:create-tags)
(global-set-key (kbd "C-S-f") 'my:grep-find-read-from-minibuffer)
(global-set-key (kbd "C-<prior>") 'other-window---1)
(global-set-key (kbd "C-<next>") 'other-window)
(global-set-key [f5] 'revert-buffer)
;; (global-set-key [f7] 'gdb)
;; (global-set-key [f6] 'backward-sexp)
;; (global-set-key [f7] 'forward-sexp)
;; (global-set-key [f8] 'backward-up-list)
;; (global-set-key [f9] 'my:compile)
(global-set-key [f12] 'switch-to-buffer)
(global-set-key [M-f4] 'kill-emacs)

;; style setups
(add-hook 'c-mode-common-hook 'my:cc-style)
(add-hook 'csharp-mode-hook 'my:cc-style)
(add-hook 'makefile-mode-hook 'my:script-style)
(add-hook 'python-mode-hook 'my:script-style)
(add-hook 'lisp-mode-hook 'my:script-style)
(add-hook 'emacs-lisp-mode-hook 'my:script-style)

;; MacOS
(when (eq system-type 'darwin)
  (global-set-key (kbd "<home>") 'beginning-of-line)
  (global-set-key (kbd "<end>") 'end-of-line)
  )

;; emacs 27: tab-bar-mode
(unless (version< emacs-version "27.1")
  (global-set-key (kbd "C--") 'tab-bar-close-tab)
  (global-set-key (kbd "C-=") 'tab-bar-new-tab)
 )

;; yes-no -> y-n
(fset 'yes-or-no-p 'y-or-n-p)

;; custom functions
(defun other-window---1 ()
  (interactive)
  (other-window -1)
  )

(defun my:forward-out-of-bracket ()
  (interactive)
  (backward-up-list)
  (forward-list)
  )

(defun my:script-style ()
  (setq tab-width 4)
  (setq indent-tabs-mode nil)
  )

(defun my:working-indent ()
  (setq c-basic-offset 2)
  (setq tab-width 2)
  (setq indent-tabs-mode nil)
  )

(defun my:cc-style ()
  (c-set-style "linux")
  (c-set-offset 'inlambda '0)
  (c-set-offset 'innamespace '0)
  (c-set-offset 'inextern-lang '0)
  (c-set-offset 'inline-open '0)
  (c-set-offset 'label '0)
  (c-set-offset 'case-label '0)
  (c-set-offset 'access-label '-)
  (my:working-indent)
  )

(defun my:split-window ()
  "Split window properly."
  (interactive)
  ;; (message "%d %d" (window-pixel-height) (window-pixel-width))
  (if (> (window-pixel-height) (window-pixel-width))
      (split-window-vertically)
    (split-window-horizontally)
    )
  )

(defun my:close ()
  "Close file/window."
  (interactive)
  (if (> (length (get-buffer-window-list)) 1)
      (if (buffer-file-name (previous-buffer))
          ()
        (delete-window)
        )
    (progn
      (kill-this-buffer)
      ;; (message (buffer-file-name (current-buffer)))
      (message "%d" (length (buffer-list)))
      (if (> (count-windows) 1)
          (delete-window)
        )
      )
    )
  )

(defun my:close-on-exit ()
  (when (not (one-window-p))
    (delete-window)
    )
  )

(defun my:close-buffer-and-window ()
  "Close buffer/window."
  (interactive)
  (kill-this-buffer)
  (delete-window)
  )

(defun my:open-term ()
  (interactive)
  (term "/bin/bash")
  )

(defun my:create-workspace () ;; (file-path)
  "Create new workspace."
  ;; (interactive "FNew workspace: ")
  (interactive)
  (eyebrowse-create-window-config)
  ;; (switch-to-buffer "*scratch*")
  (delete-other-windows)
  ;; (find-file file-path)
  )

(defun my:compile (compile-path)
  "Compile."
  (interactive "FCompile in: ")
  (cd compile-path)
  (compile (read-string "Compile command: " "make -j4"))
  )

(defun my:create-tags (dir-path)
  "Create tags file."
  ;; how to browse local TAGS to remote access:
  ;; replace whatever matches local path prefix e.g. /home/[username]/
  ;;                      by remote path prefix e.g. /ssh:[username]/home/[username]/
  (interactive "DCreate TAGS file from: ")
  (let ((save-dir-path
         (completing-read "Save TAGS file to: "
                          tags-table-list nil t (car tags-table-list))))
    (eshell-command
     (format "find %s -follow -type f -name \"*.[ch]\" -or -name \"*.[ch]pp\" -or -name \"*.py\" | %s -f %s/TAGS -e -L -"
             dir-path
             (if (eq system-type 'darwin)
                 "/usr/local/bin/ctags"
               "ctags")
             save-dir-path
             )
     )
    )
  )

(defun my:grep-find (what-to-grep)
  (interactive)
  (setq where-to-grep (read-file-name "Grep in: " default-directory))
  (grep-find (format "grep '%s' -R \"%s\" -rI --color -nH \
--exclude-dir='.ccls-cache' \
--exclude-dir='build' \
--exclude-dir='Debug' \
"
                     what-to-grep
                     (file-relative-name where-to-grep)
                     )
             )
  )

(defun my:grep-find-read-from-minibuffer ()
  "setting up grep-command using sentence read from minibuffer"
  (interactive)
  (my:grep-find (read-string "Grep: "))
  )

(defun my:grep-find-at-point ()
  "setting up grep-command using current word under cursor as a search string"
  (interactive)
  (my:grep-find (symbol-at-point))
  )

(defun my:duplicate-line (arg)
  "Duplicate current line, leaving point in lower line."
  (interactive "*p")
  ;; save the point for undo
  (setq buffer-undo-list (cons (point) buffer-undo-list))
  ;; local variables for start and end of line
  (let ((bol (save-excursion (beginning-of-line) (point)))
        eol)
    (save-excursion
      ;; don't use forward-line for this, because you would have
      ;; to check whether you are at the end of the buffer
      (end-of-line)
      (setq eol (point))
      ;; store the line and disable the recording of undo information
      (let ((line (buffer-substring bol eol))
            (buffer-undo-list t)
            (count arg))
        ;; insert the line arg times
        (while (> count 0)
          (newline)         ;; because there is no newline in 'line'
          (insert line)
          (setq count (1- count))
          )
        )
      ;; create the undo information
      (setq buffer-undo-list (cons (cons eol (point)) buffer-undo-list)))) ; end-of-let
  ;; put the point in the lowest line and return
  (next-line arg)
  )

(defun my:create-compile_commands.json (dir-path)
  (interactive "DCreate compile_commands.json in: ")
  (eshell-command (format "cmake -H%s -B%s/Debug -DCMAKE_BUILD_TYPE=Debug -DCMAKE_EXPORT_COMPILE_COMMANDS=YES"
                          dir-path
                          dir-path
                          )
                  )
  (eshell-command (format "ln -s %s/Debug/compile_commands.json %s"
                          dir-path
                          dir-path
                          )
                  )
  )

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(cua-mode t nil (cua-base))
 '(cua-prefix-override-inhibit-delay 0.1)
 '(custom-safe-themes
   (quote
    ("06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a" "628278136f88aa1a151bb2d6c8a86bf2b7631fbea5f0f76cba2a0079cd910f7d" "7575474658c34b905bcec30a725653b2138c2f2d3deef0587e3abfae08c5b276" "f3ab34b145c3b2a0f3a570ddff8fabb92dafc7679ac19444c31058ac305275e1" "4af38f1ae483eb9335402775b02e93a69f31558f73c869af0d2403f1c72d1d33" default)))
 '(default-frame-alist
    (quote
     ((right-divider-width . 1)
      (alpha . 90)
      (fullscreen . maximized))))
 '(desktop-save-mode nil)
 '(electric-pair-mode t)
 '(eyebrowse-mode-line-style (quote smart))
 '(eyebrowse-switch-back-and-forth t)
 '(eyebrowse-wrap-around t)
 '(global-auto-revert-mode nil)
 '(global-linum-mode nil)
 '(inhibit-startup-screen t)
 '(large-file-warning-threshold 100000000)
 '(make-backup-files nil)
 '(menu-bar-mode nil)
 '(org-agenda-files (quote ("~/.agendas/")))
 '(org-support-shift-select t)
 '(org-todo-keywords
   (quote
    ((sequence "TODO" "IN-PROGRESS" "|" "DONE" "CANCELED"))))
 '(package-selected-packages
   (quote
    (ace-window shackle lsp-ui company-lsp ccls lsp-python-ms zones lsp-mode color-theme-sanityinc-tomorrow exec-path-from-shell docker-tramp yasnippet-snippets git-auto-commit-mode company use-package protobuf-mode nlinum markdown-mode ivy-xref highlight-indentation dashboard counsel-projectile cmake-mode)))
 '(redisplay-dont-pause t t)
 '(save-place-mode t)
 '(scroll-conservatively 10000)
 '(scroll-margin 1)
 '(scroll-preserve-screen-position 1)
 '(scroll-step 1)
 '(select-enable-clipboard t)
 '(show-paren-mode t)
 '(tab-bar-show 1)
 '(tags-table-list (quote ("~/")))
 '(tool-bar-mode nil)
 '(tooltip-mode nil)
 '(truncate-lines t)
 '(window-divider-default-right-width 1)
 '(window-divider-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(font-lock-keyword-face ((t (:weight bold))))
 '(font-lock-type-face ((t (:foreground "#ae81ff" :weight bold))))
 '(highlight-indentation-current-column-face ((t (:background "dark slate gray")))))
