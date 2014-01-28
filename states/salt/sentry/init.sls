base-pkgs:
  pkg.installed:
    - names:
      - python-dev
      - python-virtualenv
      - python-psycopg2
      - expect
      - python-pip

web-group:
  group.present:
    - name: web
    - system: True

web-user:
  user.present:
    - name: web
    - groups:
      - web
    - required:
      - group: web

/srv/webapps/:
  file.directory:
    - user: web
    - group: web
    - makedirs: True
    - required:
      - user: web-user

/srv/envs/:
  file.directory:
    - user: web
    - group: web
    - makedirs: True
    - required:
      - user: web-user


sentry-virtualenv:
    virtualenv.managed:
        - name: /srv/envs/sentry
        - no_site_packages: True
        - runas: web
        - requirements: salt://sentry/requirements.txt
        - require:
            - pkg: base-pkgs
            - service: postgresql
            - file: /srv/envs/
            - file: /etc/sentry.conf.py
            - postgres_database: {{ pillar['sentry_server']['db_name'] }}

/etc/sentry.conf.py:
  file.managed:
    - source: salt://sentry/sentry.conf.py
    - user: web
    - group: root
    - mode: 640
    - template: jinja

/etc/init/sentry.conf:
  file.managed:
    - source: salt://sentry/upstart.conf
    - template: jinja