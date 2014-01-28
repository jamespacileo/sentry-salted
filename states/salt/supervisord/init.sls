

supervisor:
  pkg:
    - installed
  service:
    - running
    #- reload: True
    - enable: True
    - watch:
      - pkg: supervisor
      - file: /var/log/supervisord/supervisord.log
      - file: supervisord_conf

supervisord_conf:
  file:
    - managed
    - name: /etc/supervisord.conf
    - source: salt://supervisord/supervisord.conf
    - template: jinja
    - watch:
      - file: /var/log/supervisord/supervisord.log

supervisorctl_reload:
  cmd.wait:
    - name: supervisorctl reload
    - watch:
      - file: supervisord_conf

/var/log/supervisord/supervisord.log:
  file.touch:
    - makedirs: True