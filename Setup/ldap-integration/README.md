
## LDAP

Deploy:
```
#!/bin/bash
set -e

fog admin create-directory -f ./root-directory.yaml --org root

fog admin create-account-store ./root-directory-account-store.yaml --directory root-ldap-directory --org root
```



For other Orgs:
```
fog admin show-account-stores root

(get storeId: 37dd46a1-3942-4f14-b5c7-369e09173c66)

fog admin create-account-store ./root-directory-account-store.yaml --directory root-ldap-directory --org training


$ cat root-directory-account-store.yaml
name: 'root-directory-account-store'
description: 'mapping between root org and ldap.example.com role.galacticfog group'
storeType: DIRECTORY
isDefaultAccountStore: false
isDefaultGroupStore: false

# Set this to the root directory's storeId
accountStoreId: 37dd46a1-3942-4f14-b5c7-369e09173c66

```




Remove:
```
fog admin delete-directory root-ldap-directory --org root
```
