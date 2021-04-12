# \ var
MODULE  = $(notdir $(CURDIR))
OS      = $(shell uname -s)
MACHINE = $(shell uname -m)
NOW     = $(shell date +%d%m%y)
REL     = $(shell git rev-parse --short=4 HEAD)
CORES   = $(shell grep processor /proc/cpuinfo| wc -l)
# / var

# \ dir
CWD     = $(CURDIR)
BIN     = $(CWD)/bin
DOC     = $(CWD)/doc
TMP     = $(CWD)/tmp
LIB     = $(CWD)/lib
SRC     = $(CWD)/src
# / dir

# \ tool
CURL    = curl -L -o
ERL     = erl
ERLC    = erlc
MIX     = mix
IEX     = iex
# / tool

# \ src
E      += $(shell find src    -type f -regex ".+.erl$$")
X      += $(shell find lib    -type f -regex ".+.ex$$")
X      += $(shell find config -type f -regex ".+.exs$$")
X      += mix.exs
S      += $(E) $(X)
# / src

# \ all
.PHONY: all
all: $(E) $(X)
.PHONY: repl
repl:
	$(IEX) -S mix phx.server
	$(MIX)    format
	$(MAKE)   $@
.PHONY: web
web: $(E) $(X)
	$(MIX)    phx.server
# / all

# \ doc
.PHONY: doc
doc: \
	doc/Erlang/LYSE_ru.pdf doc/Erlang/Armstrong_ru.pdf \
	doc/Erlang/ElixirInAction.pdf doc/Erlang/Phoenix.pdf

doc/Erlang/LYSE_ru.pdf:
	$(CURL) $@ https://github.com/mpyrozhok/learnyousomeerlang_ru/raw/master/pdf/learnyousomeerlang_ru.pdf
doc/Erlang/Armstrong_ru.pdf:
	$(CURL) $@ https://github.com/dyp2000/Russian-Armstrong-Erlang/raw/master/pdf/fullbook.pdf
doc/Erlang/ElixirInAction.pdf:
	$(CURL) $@ https://github.com/levunguyen/CGDN-Ebooks/raw/master/Java/Elixir%20in%20Action%2C%202nd%20Edition.pdf
doc/Erlang/Phoenix.pdf:
	$(CURL) $@ http://www.r-5.org/files/books/computers/languages/erlang/phoenix/Chris_McCord_Bruce_Tate_Jose_Valim-Programming_Phoenix-EN.pdf
# / doc

# \ install
.PHONY: install
install: $(OS)_install js doc
	$(MAKE) $(PIP)
	$(MAKE) update
	$(MIX) archive.install hex phx_new 1.5.8
	$(MIX) ecto.create
.PHONY: update
update: $(OS)_update
	$(MIX) local.hex local.rebar
	$(MIX) deps.get
	$(MIX) deps.compile
.PHONY: Linux_install Linux_update
Linux_install Linux_update:
	sudo apt update
	sudo apt install -u `cat apt.txt apt.dev`

# \ js
.PHONY: js
js:
# / js
# / install

# \ merge
MERGE += README.md Makefile .gitignore apt.txt apt.dev LICENSE $(S)
MERGE += .vscode bin doc tmp src test
MERGE += config lib test mix.exs .formatter.exs
MERGE += assets priv
MERGE += geo

.PHONY: main
main:
	git push -v
	git checkout $@
	git pull -v
	git checkout shadow -- $(MERGE)
.PHONY: shadow
shadow:
	git push -v
	git checkout $@
	git pull -v
.PHONY: release
release:
	git tag $(NOW)-$(REL)
	git push -v && git push -v --tags
	$(MAKE) shadow
.PHONY: zip
zip:
	git archive \
		--format zip \
		--output $(TMP)/$(MODULE)_$(NOW)_$(REL).src.zip \
	HEAD
# / merge
