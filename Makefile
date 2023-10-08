export EMACS ?= $(shell which emacs)
CASK_DIR := $(shell cask package-directory)

$(CASK_DIR): Cask
	cask install
	@touch $(CASK_DIR)

.PHONY: cask
cask: $(CASK_DIR)

build: cask
	cask emacs -Q -batch -l roguemacs.el \
          --eval "(setq byte-compile-error-on-warn t)" \
	  -f batch-byte-compile $$(cask files)

clean: cask
	cask clean-elc

.PHONY: test
test: cask
	cask emacs -Q -batch -l ert \
	-l roguemacs-test.el \
	-f ert-run-tests-batch

.PHONY: lint
lint: cask
	cask emacs -Q -batch -l elisp-lint.el \
	-f elisp-lint-files-batch \
	roguemacs.el roguemacs-test.el && \
	rm *.elc
