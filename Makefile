# \ var
MODULE  = $(notdir $(CURDIR))
OS      = $(shell uname -s)
MACHINE = $(shell uname -m)
NOW     = $(shell date +%d%m%y)
REL     = $(shell git rev-parse --short=4 HEAD)
BRANCH  = $(shell git rev-parse --abbrev-ref HEAD)
CORES   = $(shell grep processor /proc/cpuinfo| wc -l)
# / var

# \ dir
CWD     = $(CURDIR)
BIN     = $(CWD)/bin
DOC     = $(CWD)/doc
TMP     = $(CWD)/tmp
LIB     = $(CWD)/lib
SRC     = $(CWD)/src
TEST    = $(CWD)/test
GZ      = $(HOME)/gz
# / dir

# \ tool
CURL    = curl -L -o
REBAR   = $(HOME)/bin/rebar3
ERLC    = erlc
ERL     = erl
MIX     = mix
IEX     = iex
# / tool

# \ src
E      += $(shell find src    -type f -regex ".+.erl$$")
X      += $(shell find lib    -type f -regex ".+.ex$$")
X      += $(shell find test   -type f -regex ".+.exs$$")
X      += $(shell find config -type f -regex ".+.exs$$")
X      += .formatter.exs mix.exs
S      += $(E) $(X)
# / src

# \ all
.PHONY: repl
repl:
	$(IEX)  -S mix
	$(MAKE) format
	$(MAKE) $@

.PHONY: test
test:
	$(MIX) test

.PHONY: format
format: tmp/format
tmp/format:
	$(MAKE) test
	$(MIX)  format
# / all

# \ install
.PHONY: install update
install: $(OS)_install
	$(MAKE) rebar
	$(MAKE) update
update: $(OS)_update
	$(MIX)  local.hex local.rebar
	$(MIX)  deps.get
	$(MIX)  deps.compile
	$(MIX)  ecto.create

.PHONY: Linux_install Linux_update
Linux_install Linux_update:
	sudo apt update
	sudo apt install -u `cat apt.txt apt.dev`
# \ erlang
.PHONY: rebar
rebar: $(REBAR)
$(REBAR):
	$(CURL) $@ https://s3.amazonaws.com/rebar3/rebar3 && chmod +x $@
	$(REBAR) local install
# / erlang
# / install

# \ merge
MERGE  = README.md Makefile .gitignore apt.txt apt.dev .vscode $(S)
MERGE += bin doc lib include src test tmp
MERGE += geo

.PHONY: zip
zip:
	git archive \
		--format zip \
		--output $(TMP)/$(MODULE)_$(BRANCH)_$(NOW)_$(REL).src.zip \
	HEAD

.PHONY: dev
dev:
	git push -v
	git checkout $@
	git pull -v
	git checkout ponymuck -- $(MERGE)

.PHONY: ponymuck
ponymuck:
	git push -v
	git checkout $@
	git pull -v
# / merge
