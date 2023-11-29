(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(blink-cursor-mode nil)
 '(column-number-mode t)
 '(magit-todos-insert-after '(bottom) nil nil "Changed by setter of obsolete option `magit-todos-insert-at'")
 '(size-indication-mode t)
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(setq org-log-done t)

(define-key evil-normal-state-map (kbd "C-s") #'save-buffer)
(define-key evil-insert-state-map (kbd "C-s") #'save-buffer)

;; Move through windows with ctrl
(define-key evil-normal-state-map (kbd "C-k") #'evil-window-up)
(define-key evil-normal-state-map (kbd "C-j") #'evil-window-down)
(define-key evil-normal-state-map (kbd "C-l") #'evil-window-right)
(define-key evil-normal-state-map (kbd "C-h") #'evil-window-left)

(define-key evil-normal-state-map (kbd "C-p") #'find-file)

(setq initial-frame-alist '((width . 125) (height . 55)))

;; (global-unset-key (kbd "S-H"))
;; (global-unset-key (kbd "S-L"))
;; (evil-window-bottom &optional COUNT)
;;
;; (define-key evil-normal-state-map (kbd r ") nil)
;; (define-key evil-normal-state-map (kbd "L") nil)
(define-key evil-normal-state-map (kbd "H") #'centaur-tabs-backward)
(define-key evil-normal-state-map (kbd "L") #'centaur-tabs-forward)

;; Map "SPC SPC" to open the command palette
(setq mac-option-modifier nil)
(setq mac-right-option-modifier nil)
(map! :leader
      :desc "Open command palette"
      :nv "SPC" #'execute-extended-command)

(after! org-capture
  (setq org-capture-templates
        `(("t", "Tasks / Projects")
          ("tt" "Task" entry
           (file+headline "~/Dropbox/org/refile.org" "Tasks")
           "* TODO %?")

          ("ta" "Task with active selection" entry
           (file+headline "~/Dropbox/org/refile.org" "Tasks")
           "* TODO %?\n%a")

          ("n" "Note" entry
           (file+headline "~/Dropbox/org/refile.org" "Notes")
           "* %u %?\n%a")

          ("c" "New candidate" entry
           (file+headline "~/Dropbox/org/synvia_inbox.org" "Novos Candidatos")
           "* TODO %^{Name}\n[[%^{Repo link}][Repo]]%?\n\n** Positivos\n** Neutros\n** Negativos\n** Resumo")

          ("m" "Meeting notes" entry
           (file+headline "~/Dropbox/org/refile.org" "Meetings")
           "* %u - %^{Meeting name} :meetings:\n\n%?\n\n"
           :clock-in :clock-resume
           :empty-lines 1)

          ("j" "Journal" entry (file+datetree "~/Dropbox/org/journal.org")
           ,(concat "* " (format-time-string "%H:%M") " %^{Title}\n\n%?"))))
)

(after! org
  (setq org-agenda-custom-commands
        '(
          ("w" "Work Agenda"
           ((agenda "")
            (tags-todo "synvia"))
           ((org-agenda-tag-filter-preset '("+synvia")))
           )
          ("d" "Work Agenda for the day"
           ((agenda "" ((org-agenda-span 'day)
                        (org-agenda-skip-function '(org-agenda-skip-deadline-if-not-today))))
            (tags-todo "synvia"))
           ((org-agenda-tag-filter-preset '("+synvia")))
           )
          ("p" "Non-work tasks"
           ((agenda "")
            (tags-todo "-synvia"))
           ((org-agenda-tag-filter-preset '("-synvia")))
           )
          )
        )
  )

