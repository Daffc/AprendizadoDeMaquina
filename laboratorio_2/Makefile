PYTHON := python3.9
PIP := pip3.9

.DEFAULT_GOAL := all
.PHONY := install all clean purge

venv:
	virtualenv -p $(PYTHON) venv

install: venv
	. $</bin/activate && $(PIP) install -r requirements.txt	

all: install

clean:
	-rm tempo || true

purge: clean
	-rm -rf venv || true