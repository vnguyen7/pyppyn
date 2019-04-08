
.PHONY: lint all before_install

python_version_full := $(wordlist 2,4,$(subst ., ,$(shell python3 --version 3>&1)))
python_version_major := $(word 1,${python_version_full})
python_version_minor := $(word 2,${python_version_full})
python_version_patch := $(word 3,${python_version_full})

my_cmd := ${python${python_version_major}.${python_version_minor}}
UNAME := $(shell uname)

all :
	@echo ${python_version_full}
	@echo ${python_version_major}
	@echo ${python_version_minor}
	@echo ${python_version_patch}
	@echo ${my_cmd}
	@echo ${UNAME}

lint: 
	@echo " make lint requirements installation "
	pip install -r requirements/pip.txt
	pip install -r requirements/lint.txt
	pip install --editable .

before_install:
ifeq ($(UNAME),Windows)
	choco install python3;	\
    export PATH="/c/Python37:/c/Python37/Scripts:$PATH";	\
	python -m pip install virtualenv;	\
    virtualenv $HOME/venv;	\
    source $HOME/venv/Scripts/activate
endif
ifeq (${UNAME},Darwin)
	python3 -m pip install virtualenv;	\
    virtualenv $HOME/venv -p python3;	\
    source $HOME/venv/bin/activate
endif
	

