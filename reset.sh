sudo rm /var/databases/metagov/db.sqlite3 
sudo rm /var/databases/policykit/db.sqlite3 
cd ../../metagov-prototype/metagov/
sudo chown -R hz:hz /var/databases/
sudo chown -R hz:hz /var/log/django/
source env/bin/activate
python manage.py migrate
python manage.py collectstatic
cd ../../policykit/policykit/
source env/bin/activate
python manage.py migrate
python manage.py shell --command="exec(open('scripts/starterkits.py').read())"
python manage.py collectstatic
sudo chown -R www-data:www-and-celery /var/databases
sudo chown -R www-data:www-and-celery /var/log/django/
sudo chmod -R 775 /var/log/django/
sudo chmod -R 775 /var/databases/
sudo systemctl restart apache2
sudo systemctl restart celery-metagov celerybeat-metagov celery-policykit celerybeat-policykit
