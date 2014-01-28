nginx:
   pkg:
     - installed
   service:
     - running
     - enable: True
     - require:
       - pkg: nginx
       - file: nginxconf
       - file: /etc/nginx/sites-enabled/default

nginxconf:
  file.managed:
    - name: /etc/nginx/sites-enabled/sentry
    - source: salt://sentry/nginx.conf
    - template: jinja
    - makedirs: True
    - mode: 755

/etc/nginx/sites-enabled/default:
  file.absent

