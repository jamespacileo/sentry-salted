postgresql-pkgs:
  pkg.installed:
    - pkgs:
      - postgresql-9.1
      - postgresql-contrib-9.1
      - postgresql-server-dev-9.1
#      - python-psycopg2

postgresql:
  service.running:
    - reload: True
    # - watch:
    #   - file: /etc/postgresql/9.1/main/pg_hba.conf
    - require:
      - pkg: postgresql-pkgs
      - file: postgresql-hba
      # - pip: psycopg2

postgresql-hba:
  file.managed:
    - name: /etc/postgresql/9.1/main/pg_hba.conf
    - source: salt://postgres/pg_hba.conf
    - user: postgres
    - group: postgres
    - mode: 644
    - require:
      - pkg: postgresql-pkgs

{{ pillar['sentry_server']['db_user'] }}:
   postgres_user.present:
     - password: {{ pillar['sentry_server']['db_password'] }}
     - require:
       - service: postgresql

{{ pillar['sentry_server']['db_name'] }}:
   postgres_database.present:
     - owner: pg_sentry
     - require:
       - postgres_user: pg_sentry