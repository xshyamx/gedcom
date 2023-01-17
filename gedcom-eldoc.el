;;; gedcom-eldoc.el --- Provide eldoc for GEDCOM tags

;; Author:   S. Shyam Sundar (xshyamx@users.noreply.github.com)
;; Version:  0.1

;; Additional stuff
;; Keywords: genealogy, lifelines, gedcom, eldoc

(require 'gedcom-tags)

(defconst gedcom--tag-regexp
  (rx-to-string
   `(seq bol digit
	 (? space "@" (one-or-more alphanumeric) "@")
	 space (group (repeat 3 4 upper))
	 (zero-or-more any)
	 eol))
  "Regexp to extract the GEDCOM tag in a line")


(defun gedcom-eldoc-function()
  "Return the help text at point"
  (save-excursion
    (save-restriction
      (goto-char (line-beginning-position))
      (when (re-search-forward gedcom--tag-regexp (line-end-position) t)
	  (gedcom-tag-help (match-string-no-properties 1))
	  )
      )
    )
  )

(defun turn-on-gedcom-eldoc ()
  "When `gedcom-enable-edoc' is `t' enable eldoc mode to provide help"
  (when gedcom-enable-eldoc
    (set
     (make-local-variable 'eldoc-documentation-function)
     'gedcom-eldoc-function)
    (eldoc-mode)
    )
  )

(provide 'gedcom-eldoc)
