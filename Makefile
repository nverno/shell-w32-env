emacs ?= emacs
batch = $(emacs) -Q --batch
etags ?= etags
wget ?= wget

LOADPATH := -L .
BYTE_COMPILE_FLAGS = \
	--eval '(setq load-prefer-newer t)'
AUTO_FLAGS = \
	--eval "(let ((generated-autoload-file \
	(expand-file-name (unmsys--file-name \"$@\"))) \
	(backup-inhibited t)) \
	(update-directory-autoloads \".\"))"

autoloads = ../loaddefs.el

EL = $(wildcard *.el)
ELC := $(EL:.el=.elc)

.PHONY: all autoloads compile clean

all: $(autoloads) compile README.md TAGS

compile : $(ELC)

%.elc: %.el
	$(batch) $(BYTE_COMPILE_FLAGS) $(LOADPATH) -f batch-byte-compile $<

# generate autoloads
$(autoloads): $(EL)
	$(batch) $(AUTO_FLAGS) 

README.md : el2markdown.el $(EL)
	$(batch) -l $< $(EL) -f el2markdown-write-readme

el2markdown.el:
	$(wget) -q -O $@ "https://github.com/Lindydancer/el2markdown/raw/master/el2markdown.el"

.INTERMEDIATE: el2markdown.el

# Make tags
TAGS: $(EL)
	$(RM) $@
	touch $@
	ls $(EL) | xargs etags -a -o $@

clean:
	$(RM) $(ELC) *~
