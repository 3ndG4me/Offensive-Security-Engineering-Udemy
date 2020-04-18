Add nix User:
  user.present:
    - name: gretchen
    - password: password
    - hash_password: True
    - home: /home/gretchen
    - optional_groups:
      - wheel
      - sudoers
      - root