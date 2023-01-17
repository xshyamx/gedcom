;;; gedcom-tags.el --- tag help for GEDCOM files

;; Author:   S. Shyam Sundar (xshyamx@users.noreply.github.com)
;; Version:  0.1

;; Additional stuff
;; Keywords: genealogy, lifelines, gedcom, tags

;;; Commentary (S. Shyam Sundar):

;; GEDCOM tag expansion/help

(defconst gedcom--tag-help
  '(("ABBR" . "Abbreviation for a name or title")
    ("ADDR" . "Address, usually mailing address")
    ("ADOP" . "Adoption")
    ("ADR1" . "First line of an address")
    ("ADR2" . "Second line of an address")
    ("AFN" . "Ancestral File number (LDS)")
    ("AGE" . "Age at time of event")
    ("ALIA" . "Alias")
    ("ANUL" . "Annulment")
    ("ARVL" . "Arrival")
    ("AUTH" . "Author of the information")
    ("BAPL" . "Baptism, LDS")
    ("BAPM" . "Baptism")
    ("BARM" . "Bar Mitzvah")
    ("BASM" . "Bas Mitzvah")
    ("BIRT" . "Birth")
    ("BLES" . "Blessing")
    ("BURI" . "Burial")
    ("CAST" . "Caste")
    ("CAUS" . "Cause of event, such as death")
    ("CENS" . "Census")
    ("CHIL" . "Child -- natural or adopted")
    ("CHR" . "Christening")
    ("CHRA" . "Adult Christening")
    ("CITY" . "City")
    ("CONC" . "Continue with the previous text; do not leave spaces")
    ("CONF" . "Confirmation")
    ("CONL" . "Confirmation, LDS")
    ("CREM" . "Cremation")
    ("CTRY" . "Country (name or code)")
    ("DATE" . "Date")
    ("DEAT" . "Death")
    ("DESC" . "Descendants")
    ("DIV" . "Divorce")
    ("DIVF" . "Divorce Filed")
    ("DSCR" . "Physical description of a person, place, or thing")
    ("EDUC" . "Education")
    ("EMIG" . "Emigration")
    ("ENDL" . "Endownment, LDS")
    ("ENGA" . "Engagement")
    ("EVEN" . "Event (noteworthy event)")
    ("FAM" . "Family")
    ("FAMC" . "Child in Family")
    ("FAMS" . "Spouse in Family")
    ("FCOM" . "First Communion")
    ("FOST" . "Foster")
    ("GIVN" . "Given name")
    ("GRAD" . "Graduation")
    ("HEAD" . "Header")
    ("HUSB" . "Husband")
    ("ILLE" . "Illegitimate")
    ("IMMI" . "Immigration")
    ("INDI" . "Individual")
    ("LANG" . "Language")
    ("LEGA" . "Legatee")
    ("LVG" . "Living")
    ("MARB" . "Marriage Bann")
    ("MARC" . "Marriage Contract")
    ("MARL" . "Marriage License")
    ("MARR" . "Marriage")
    ("MARS" . "Marriage Settlement")
    ("MISC" . "Miscellaneous")
    ("NAME" . "Name")
    ("NATI" . "Nationality")
    ("NATU" . "Naturalization")
    ("NICK" . "Nickname")
    ("NOTE" . "Additional information")
    ("NPFX" . "Name prefix")
    ("NSFX" . "Name suffix (Jr. or Sr. etc.)")
    ("OCCU" . "Occupation")
    ("ORDI" . "Ordinance (religious)")
    ("ORDL" . "Ordination (LDS)")
    ("ORDN" . "Ordination (non-LDS)")
    ("PHON" . "Phone number")
    ("PLAC" . "Place")
    ("POST" . "Postal code")
    ("PRIV" . "Private")
    ("PROB" . "Probate")
    ("RACE" . "Race")
    ("REFN" . "Reference Number")
    ("RELI" . "Religion (denomination)")
    ("RESI" . "Residence")
    ("RETI" . "Retirement")
    ("SEX" . "Sex (male or female)")
    ("SLGC" . "SealChild, LDS")
    ("SLGS" . "SealSpouse, LDS")
    ("SOUR" . "Source")
    ("SPFX" . "Surname prefix")
    ("SSN" . "Social Security number")
    ("STAE" . "State")
    ("STIL" . "Stillborn")
    ("SUBM" . "Submitter")
    ("SURN" . "Surname")
    ("TEL" . "Telephone Number")
    ("TEMP" . "Temple (LDS)")
    ("TIME" . "Time")
    ("TITL" . "Title")
    ("TRLR" . "Trailer, end of document")
    ("WIFE" . "Wife")
    ("WILL" . "Will"))
  "GEDCOM tag help")

(defun gedcom-tag-help (tag)
  "Return a displayable help for the TAG"
  (when (assoc tag gedcom--tag-help)
    (format "%s: %s"
	  (propertize tag 'face 'font-lock-function-name-face)
	  (cdr (assoc tag gedcom--tag-help))
	  )))

(provide 'gedcom-tags)
