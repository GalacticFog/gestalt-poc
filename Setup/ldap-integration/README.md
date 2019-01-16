
## LDAP

Deploy:
```
#!/bin/bash
set -e

fog admin create-directory -f ./root-directory.yaml --org root

fog admin create-account-store ./root-directory-account-store.yaml --directory root-ldap-directory --org root
```

Remove:
```
fog admin delete-directory root-ldap-directory --org root
```
