(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ac-auto-show-menu 0.1)
 '(ac-trigger-key nil)
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#242424" "#e5786d" "#95e454" "#cae682" "#8ac6f2" "#333366" "#ccaa8f" "#f6f3e8"])
 '(c-basic-offset 2)
 '(c-default-style "linux")
 '(cua-mode t nil (cua-base))
 '(custom-enabled-themes (quote (kaolin-aurora)))
 '(custom-safe-themes
   (quote
    ("571a762840562ec5b31b6a9d4b45cfb1156ce52339e188a8b66749ed9b3b22a2" "0f1733ad53138ddd381267b4033bcb07f5e75cd7f22089c7e650f1bb28fc67f4" "fa477d10f10aa808a2d8165a4f7e6cee1ab7f902b6853fbee911a9e27cf346bc" "b13f76a2eb776abe9c17379d6d90f36cdac716678cd8b9138ba4b6c2a8fca378" "6e38567da69b5110c8e19564b7b2792add8e78a31dfb270168509e7ae0147a8d" "bee55ba5e878d0584db9b2fb33f75c348a3008fcfe8e05ab8cae897ca604fd95" "f07729f5245b3c8b3c9bd1780cbe6f3028a9e1ed45cad7a15dd1a7323492b717" "9f08dacc5b23d5eaec9cccb6b3d342bd4fdb05faf144bdcd9c4b5859ac173538" "030346c2470ddfdaca479610c56a9c2aa3e93d5de3a9696f335fd46417d8d3e4" "886fe9a7e4f5194f1c9b1438955a9776ff849f9e2f2bbb4fa7ed8879cdca0631" "ef07cb337554ffebfccff8052827c4a9d55dc2d0bc7f08804470451385d41c5c" "51043b04c31d7a62ae10466da95a37725638310a38c471cc2e9772891146ee52" default)))
 '(default-frame-alist
    (quote
     ((tool-bar-lines . 0)
      (menu-bar-lines . 1)
      (alpha . 90))))
 '(desktop-save-mode nil)
 '(electric-pair-mode t)
 '(eyebrowse-mode-line-style (quote smart))
 '(eyebrowse-switch-back-and-forth t)
 '(eyebrowse-wrap-around t)
 '(global-auto-revert-mode t)
 '(global-linum-mode t)
 '(indent-tabs-mode nil)
 '(inhibit-startup-screen t)
 '(line-number-mode nil)
 '(make-backup-files nil)
 '(org-support-shift-select (quote always))
 '(package-selected-packages
   (quote
    (kaolin-themes eyebrowse markdown-mode ## auto-complete auto-complete-clang)))
 '(prog-mode-hook (quote (auto-complete-mode eyebrowse-mode)))
 '(save-place-mode t)
 '(scroll-step 1)
 '(select-enable-clipboard t)
 '(show-paren-mode t)
 '(tab-always-indent t)
 '(tab-width 4)
 '(tags-table-list (quote ("~/")))
 '(tool-bar-mode nil))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(font-lock-comment-face ((t (:slant italic))))
 '(font-lock-keyword-face ((t (:weight bold))))
 '(font-lock-type-face ((t (:weight bold))))
 '(highlight-indentation-face ((t (:inherit fringe)))))

;; custom surface
(when (>= emacs-major-version 24)
  (require 'package)
  (package-initialize)
  (add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
  )

(when (null (boundp 'init-toggled-maximized))
  (toggle-frame-maximized)
  (setq init-toggled-maximized t)
  )

(load-theme 'kaolin-aurora)
;(set-background-color "gray3")
(set-background-color "black")
;(set-foreground-color "wheat")
;(set-foreground-color "cornsilk")
(fset 'yes-or-no-p 'y-or-n-p)

(add-hook 'c-mode-common-hook 'my-cc-style)
(add-hook 'csharp-mode-hook 'my-cc-style)
;; set haskell indentation
(add-hook 'haskell-mode-hook 'haskell-indentation-mode)
;; indent
(add-hook 'makefile-mode-hook 'my-script-indent)
(add-hook 'python-mode-hook 'my-script-indent)
(add-hook 'lisp-mode-hook 'my-script-indent)
(add-hook 'emacs-lisp-mode-hook 'my-script-indent)
;(add-to-list 'write-file-functions 'delete-trailing-whitespace)



(when (eq system-type 'darwin)
  ;(setq mac-command-modifier 'meta)
  ;(setq mac-option-modifier 'control)
  ;(setq mac-command-modifier 'control)
  ;(setq mac-function-modifier 'meta)
  ;(define-key key-translation-map (kbd "M-<left>") (kbd "<home>"))
  ;(define-key key-translation-map (kbd "M-<right>") (kbd "<end>"))
  ;(define-key key-translation-map (kbd "M-<up>") (kbd "<prior>"))
  ;(define-key key-translation-map (kbd "M-<down>") (kbd "<next>"))
  (global-set-key (kbd "<home>") 'beginning-of-line)
  (global-set-key (kbd "<end>") 'end-of-line)
  ;; (global-set-key (kbd "C-M-<left>") 'previous-buffer)
  ;; (global-set-key (kbd "C-M-<right>") 'next-buffer)
  ;; (global-set-key (kbd "M-<backspace>") 'delete-forward-char)
  )

;; key binding
(global-set-key (kbd "RET") 'newline-and-indent)
(global-set-key (kbd "C-y") 'duplicate-line)
(global-set-key (kbd "C-s") 'save-buffer)
(global-set-key (kbd "C-a") 'mark-whole-buffer)
;; (global-set-key (kbd "C-o") 'find-file)
(global-set-key (kbd "C-o") 'my-open-file)
;; (global-set-key (kbd "C-S-o") 'find-name-dired)
;; (global-set-key (kbd "C-w") 'kill-this-buffer)
(global-set-key (kbd "C-w") 'my-close-file)
(global-set-key (kbd "C-k") 'kill-emacs)
(global-set-key (kbd "C-q") 'replace-string)
(global-set-key (kbd "C-f") 'isearch-forward)
(global-set-key (kbd "C-.") 'isearch-repeat-forward)
(global-set-key (kbd "C-,") 'isearch-repeat-backward)
(global-set-key (kbd "C-]") 'xref-find-definitions-other-window)
(global-set-key (kbd "C-/") 'isearch-forward-symbol-at-point)
(global-set-key (kbd "C-S-f") 'my-grep-find-read-from-minibuffer)
(global-set-key (kbd "C-?") 'my-grep-find-at-point)
(global-set-key (kbd "C-l") 'goto-line)
(global-set-key (kbd "C-;") 'comment-line)
(global-set-key (kbd "C-b") 'buffer-menu)
(global-set-key (kbd "C-t") 'my-create-tags)
(global-set-key [C-tab] 'other-window)
(global-set-key [C-S-iso-lefttab] 'other-window---1)
(global-set-key (kbd "C-<prior>") 'previous-buffer)
(global-set-key (kbd "C-<next>") 'next-buffer)
;; (global-set-key (kbd "C-n") 'eyebrowse-create-window-config)
(global-set-key (kbd "C-n") 'my-create-window-config)
(global-set-key (kbd "C-'") 'eyebrowse-close-window-config)
(global-set-key (kbd "C-<home>") 'eyebrowse-prev-window-config)
(global-set-key (kbd "C-<end>") 'eyebrowse-next-window-config)
(global-set-key [M-f4] 'kill-emacs)
(global-set-key [f7] 'gdb)
(global-set-key [C-f7] 'jdb)
(global-set-key [f9] 'my-compile)
(global-set-key [C-f9] 'my-run)

;; custom functions
(defun duplicate-line (arg)
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
          (setq count (1- count)))
        )
      ;; create the undo information
      (setq buffer-undo-list (cons (cons eol (point)) buffer-undo-list)))
    ) ; end-of-let
  ;; put the point in the lowest line and return
  (next-line arg))

(defun my-create-window-config (file-path)
  "Create tags file."
  (interactive "FNew window config: ")
  (eyebrowse-create-window-config)
  (delete-other-windows)
  (find-file file-path))

(defun my-split-window ()
  "Split window properly."
  (interactive)
  ;; (message "%d %d" (window-pixel-height) (window-pixel-width))
  (if (> (window-pixel-height) (window-pixel-width))
      (split-window-vertically)
    (split-window-horizontally)))

(defun my-open-file (file-path)
  "Open file in proper new window."
  (interactive "FOpen file: ")
  (my-split-window)
  (find-file file-path))

(defun my-close-file ()
  "Open file in proper new window."
  (interactive)
  (kill-this-buffer)
  (delete-window))

(defun my-create-tags (dir-path)
  "Create tags file."
  (interactive "DCreate TAGS file from: ")
  (let ((save-dir-path
         (completing-read "Save TAGS file to: "
                          tags-table-list nil t (car tags-table-list)
                          )
         )
        )
    (eshell-command
     (format "find %s -follow -type f -name \"*.[ch]\" -or -name \"*.[ch]pp\" -or -name \"*.py\" | ctags -f %s/TAGS -e -L -"
             dir-path save-dir-path)
     )
    )
  )

(defun my-script-indent ()
  (setq tab-width 4)
  (setq indent-tabs-mode nil)
  )

(defun my-working-indent ()
  (setq c-basic-offset 2)
  (setq tab-width 2)
  (setq indent-tabs-mode nil)
  )

(defun my-cc-style()
  (c-set-style "linux")
  (c-set-offset 'inlambda '0)
  (c-set-offset 'innamespace '0)
  (c-set-offset 'inextern-lang '0)
  (c-set-offset 'inline-open '0)
  (c-set-offset 'label '0)
  (c-set-offset 'case-label '0)
  (c-set-offset 'access-label '-)
  (my-working-indent)
  ;(setq c-basic-offset 4)
  ;(setq tab-width 4)
  ;(setq indent-tabs-mode t)
  )

(defun my-toggle-comment ()
  (interactive)
  (comment-or-uncomment-region (line-beginning-position) (line-end-position)))

(defun my-grep-find (what-to-grep)
  (interactive)
  (setq where-to-grep (read-directory-name "Grep in: " default-directory))
  (grep-find (format "find %s -type f -exec grep --color -nH --exclude='TAGS' --include='*.h' --include='*.cpp' --include='*.py' --include='*.c' -e \"%s\" \{\} +"
                     where-to-grep what-to-grep))
  )
(defun my-grep-find-read-from-minibuffer ()
  "setting up grep-command using sentence read from minibuffer"
  (interactive)
  (my-grep-find (read-string "Grep: "))
  )
(defun my-grep-find-at-point ()
  "setting up grep-command using current word under cursor as a search string"
  (interactive)
  (my-grep-find (symbol-at-point))
  )

(defun other-window---1 ()
  (interactive)
  (other-window -1))

(defun my-compile ()
  "Function for compiling source files."
  (interactive)
  (if (null buffer-file-name)
      (compile (compilation-read-command (car compile-history)))
    (let ((full (file-name-nondirectory buffer-file-name))
          (pref nil)
          (comm nil)
          )
      (setq pref (file-name-sans-extension full))
      (cond
       ((eq major-mode 'c-mode)
        (setq comm (concat "gcc -o " pref " " full " -g -Wall -lm" "-std=c99"))
        )
       ((eq major-mode 'c++-mode)
        (setq comm (concat "g++ -o " pref " " full " -g -Wall"))
        )
       ((eq major-mode 'java-mode)
        (setq comm (concat "javac -g " full))
        )
       ((eq major-mode 'pascal-mode)
        (setq comm (concat "fpc -g " full))
        )
       ((eq major-mode 'python-mode)
        (setq comm (concat "python " full))
        )
       ((eq major-mode 'haskell-mode)
        (setq comm (concat "ghc -o " pref " " full))
        )
       ((eq major-mode 'lisp-mode)
        (setq comm (concat "clisp " full))
        )
       ((eq major-mode 'latex-mode)
        (setq comm (concat "pdflatex " full))
        )
       (t (setq comm nil))
       )
      (if (null comm)
          (if (eq major-mode 'cython-mode)
              (my-cython-compile pref)
            (compile (compilation-read-command (car compile-history)))
            )
        (compile (compilation-read-command comm))
        )
      (setq my-compiled-flag t)
      )
    )
  )

(defun my-run ()
  "Function for running compiled execs."
  (interactive)
  (let ((full nil)
        (pref nil)
        (comm nil)
        )
    (if (null buffer-file-name)
        (when (= my-gud-flag 1)
          (when (eq (current-buffer) gud-comint-buffer)
            (setq full (file-name-nondirectory (buffer-file-name my-gud-entry)))
            (setq pref (file-name-sans-extension full))
            )
          )
      (progn
        (setq full (file-name-nondirectory buffer-file-name))
        (setq pref (file-name-sans-extension full))
        )
      )
    (cond
     ((eq major-mode 'java-mode)
      (setq comm (concat "java " pref))
      )
     ((eq major-mode 'python-mode)
      (setq comm (concat "python " full))
      )
     ((not (string= pref full))
      (setq comm (concat "./" pref))
      )
     (t (setq comm nil))
     )
    (if (null comm)
        (shell-command (read-shell-command "Shell command: " (car shell-command-history)))
      (shell-command (read-shell-command "Shell command: " comm))
      )
    )
  )
