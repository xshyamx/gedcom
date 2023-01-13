;;; gedcom-xref.el --- xref backend for GEDCOM files

;; Author:   S. Shyam Sundar (xshyamx@users.noreply.github.com)
;; Version:  0.1

;; Additional stuff
;; Keywords: genealogy, lifelines, gedcom, xref

;;; Commentary (S. Shyam Sundar):

;; Added `xref-backend' to support jumping to definition & references
;; As long as the line contains a valid GEDCOM identifer reference
;; you can use the following standard xref keys
;;
;; Use M-. to jump to a definition (M-, to jump back)
;; And M-? to view references
;;

(defun gedcom-xref-backend ()
  "xref-gedcom backend for Xref."
  'xref-gedcom)

(cl-defmethod xref-backend-identifier-at-point ((_backend (eql xref-gedcom)))
  (save-excursion
    (beginning-of-line)
    (let ((case-fold-search t))
      (if (re-search-forward "@[[:alpha:]][[:alnum:]]+@" (line-end-position) t)
	  (progn
	    (message "Found ref at point: %s" (match-string-no-properties 0))
	    (match-string-no-properties 0))
	(user-error "No reference found"))
      )
    ))

					;  (symbol-name (symbol-at-point)))

(cl-defmethod xref-backend-identifier-completion-table ((_backend (eql xref-gedcom)))
  "Return a list of terms for completions from symbols in the current buffer.
The current implementation returns all the identifiers in the current buffer"
  (let (words)
    (save-excursion
      (save-restriction
        (widen)
        (goto-char (point-min))
        (while (re-search-forward "@[[:alpha:]][[:alnum:]]+@" nil t)
          (add-to-list 'words (match-string-no-properties 0)))
        (seq-uniq words)))))

(cl-defmethod xref-backend-definitions ((_backend (eql xref-gedcom)) symbol)
  (gedcom--xref-find-definitions symbol))

(cl-defmethod xref-backend-references ((_backend (eql xref-gedcom)) symbol)
  (gedcom--xref-find-references symbol))



(defun gedcom--xref-find-references (symbol)
  "Return a list of reference candidates matching SYMBOL."
  (message "Symbol: %s" symbol)
  (save-excursion
    (save-restriction
      (widen)				; widen buffer before searching
      (goto-char (point-min)) 		; move to beginning of buffer
      (let ((case-fold-search t)	; case-sensitive search
	    (ref-regexp (gedcom--reference-regexp symbol))
	    (i 0)
	    (matches))
	(while (re-search-forward ref-regexp nil t)
	  (setq i (1+ i))
	  (push (xref-make
		 (buffer-substring-no-properties (line-beginning-position) (line-end-position))
		 (xref-make-buffer-location (current-buffer) (match-beginning 0))
		 ) matches)
	  )
	matches
	)
      ))
  )


;; xref-backend helper
(defun gedcom--xref-find-definitions (ref)
  "Return a list of definitions for REF"
  (save-excursion
    (save-restriction
      (widen)
      (goto-char (point-min))
      (let ((case-fold-search t)
	    (def-regexp (gedcom--definition-regexp ref)))
	(if (re-search-forward def-regexp nil t)
	    (list (xref-make ref (xref-make-buffer-location (current-buffer) (match-beginning 0))))
	  (error "Reference not found")
	  )
	)
      )
    )
  )


(defun gedcom--reference-regexp (ref)
  "Return a regular expression to search for REF reference."
  (rx-to-string `(: ,ref eol)))

(defun gedcom--definition-regexp (ref)
  "Return a regular expression to search for REF definition."
  (rx-to-string `(: bol "0 " ,ref)))


;; (add-hook xref-backend-functions #'gedcom-xref-backend)
(provide 'gedcom-xref)
