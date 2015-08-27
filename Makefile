clean:

	rm -rf *.egg-info build dist && find . -name "*.pyc" -exec rm -rf {} \;

clean_sc:

	rm -rf *.egg-info build dist && find ~/.newslynx/sous-chefs -name "*.pyc" -exec rm -rf {} \;

fresh_env:

	-make clean > /dev/null
	-pip uninstall --yes newslynx 2> /dev/null  > /dev/null
	-mkdir ~/.newslynx > /dev/null
	sleep 1 > /dev/null > /dev/null
	-mkdir ~/.newslynx/sous-chefs > /dev/null
	-mkdir ~/.newslynx/defaults > /dev/null
	sleep 1 > /dev/null
	pip install -q . 2> /dev/null

app_install:

	make  -s fresh_env 2> /dev/null
	newslynx init --empty
	make -s clean_sc > /dev/null
	cat newslynx/app/sous-chefs.txt | xargs newslynx sc-install --dev
	sleep 2 > /dev/null
	newslynx init

bare_install:

	-make clean
	-pip uninstall --yes newslynx 
	pip install .
	newslynx init --bare

test_install:

	-rm -rf ~/.newslynx
	-dropdb newslynx 
	sleep 2
	-createdb newslynx
	sleep 2
	make app_install 

register:

	python setup.py register

distribute:

	python setup.py sdist bdist_wininst upload