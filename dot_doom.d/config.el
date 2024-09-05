;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:

(setq doom-font (font-spec :name "JetBrainsMono NF" :size 16 :weight 'regular))
;; doom-symbol-font (font-spec :name "Symbols Nerd Font Mono"))

;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")
(setq org-agenda-files '("~/org"))

;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(use-package! org-pandoc-import :after org)
(use-package! org-ql :after org)
(use-package! helm-org-ql :after org-ql)

;; (defun powershell (&optional buffer)
;;   "Launches a powershell in buffer *powershell* and switches to it."
;;   (interactive)
;;   (let ((buffer (or buffer "*powershell*"))
;;     (powershell-prog "c:\\windows\\system32\\WindowsPowerShell\\v1.0\\powershell.exe"))
;;     (make-comint-in-buffer "shell" "*powershell*" powershell-prog)
;;     (switch-to-buffer buffer)))
;; (map! :leader
;;       :desc "Open a powershell buffer"
;;       "o t" #'powershell
;;       "o T" #'powershell)

(map! :leader
      :desc "Switch to last buffer"
      "." #'evil-switch-to-windows-last-buffer)
;; Unbind default "Switch to last buffer"
(map! :leader "`" nil)

(map! :n ";" 'evil-ex)

(after! evil-snipe
  (map! :n ":" 'evil-snipe-repeat)
  (setq evil-snipe-scope 'whole-visible
        evil-snipe-repeat-scope 'whole-visible))

(map! :leader
      (:prefix-map ("n d" . "roam dailies")
       :desc "Goto previous note" "b" #'org-roam-dailies-goto-previous-note
       :desc "Goto date"          "d" #'org-roam-dailies-goto-date
       :desc "Capture date"       "D" #'org-roam-dailies-capture-date
       :desc "Goto next note"     "f" #'org-roam-dailies-goto-next-note
       :desc "Goto tomorrow"      "m" #'org-roam-dailies-goto-tomorrow
       :desc "Capture tomorrow"   "M" #'org-roam-dailies-capture-tomorrow
       :desc "Capture today"      "n" #'org-roam-dailies-capture-today
       :desc "Goto today"         "t" #'org-roam-dailies-goto-today
       :desc "Capture today"      "T" #'org-roam-dailies-capture-today
       :desc "Goto yesterday"     "y" #'org-roam-dailies-goto-yesterday
       :desc "Capture yesterday"  "Y" #'org-roam-dailies-capture-yesterday
       :desc "Find directory"     "-" #'org-roam-dailies-find-directory))

(map! "M-k"   #'drag-stuff-up
      "M-j"   #'drag-stuff-down
      "M-h"   #'drag-stuff-left
      "M-l"   #'drag-stuff-right)

(setq org-journal-file-header "#+FILETAGS: :journal:"
      org-journal-date-prefix "#+TITLE: "
      org-journal-date-format "%a, %Y-%m-%d"
      org-journal-time-prefix "* "
      org-journal-file-format "%Y-%m-%d.org")

(map! :localleader :mode org-journal-mode "j r" #'org-journal--carryover)

(defun org-journal-find-location ()
  ;; Open today's journal, but specify a non-nil prefix argument in order to
  ;; inhibit inserting the heading; org-capture will insert the heading.
  (org-journal-new-entry t)
  ;; Position point on the journal's top-level heading so that org-capture
  ;; will add the new entry as a child entry.
  (goto-char (point-min)))

(after! org-capture
  (setq org-capture-templates
        '(("t" "Personal todo" entry (file+headline +org-capture-todo-file "Inbox")
           "* [ ] %?\n%i\n%a" :prepend t)
          ("n" "Personal notes" entry (file+headline +org-capture-notes-file "Inbox")
           "* %u %?\n%i\n%a" :prepend t)
          ("j" "Journal entry" entry (function org-journal-find-location)
           "* %(format-time-string org-journal-time-format)%^{Title}\n%?\n%i\n%a")
          ("p" "Templates for projects")
          ("pt" "Project-local todo" entry
           (file+headline +org-capture-project-todo-file "Inbox") "* TODO %?\n%i\n%a"
           :prepend t)
          ("pn" "Project-local notes" entry
           (file+headline +org-capture-project-notes-file "Inbox") "* %U %?\n%i\n%a"
           :prepend t)
          ("pc" "Project-local changelog" entry
           (file+headline +org-capture-project-changelog-file "Unreleased")
           "* %U %?\n%i\n%a" :prepend t)
          ("o" "Centralized templates for projects")
          ("ot" "Project todo" entry #'+org-capture-central-project-todo-file
           "* TODO %?\n %i\n %a" :heading "Tasks" :prepend nil)
          ("on" "Project notes" entry #'+org-capture-central-project-notes-file
           "* %U %?\n %i\n %a" :heading "Notes" :prepend t)
          ("oc" "Project changelog" entry #'+org-capture-central-project-changelog-file
           "* %U %?\n %i\n %a" :heading "Changelog" :prepend t))))

(after! org-roam
  (setq org-roam-dailies-capture-templates
        '(("d" "default" entry "* %<%I:%M %p>: %?"
           :if-new (file+head "%<%Y-%m-%d>.org" "#+TITLE: %<%Y-%m-%d>\n")))))
