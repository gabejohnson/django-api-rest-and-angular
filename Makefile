clean:
	rm -f example.sqlite
	rm -rf example/assets/
	rm -rf node_modules/

create_database:
	./manage.py syncdb --noinput
	./manage.py migrate --noinput
	./manage.py createsuperuser --username=root --email=root@example.com --noinput

make_fixtures:
	DJANGO_SETTINGS_MODULE='example.settings' ./create_users.py
	DJANGO_SETTINGS_MODULE='example.settings' ./create_posts.py
	DJANGO_SETTINGS_MODULE='example.settings' ./create_photos.py

install_python:
	pip install -r requirements.txt
	python setup.py develop

install_assets:
	npm install
	bower install

compile_assets:
	grunt

all: clean install_python install_assets compile_assets create_database make_fixtures
