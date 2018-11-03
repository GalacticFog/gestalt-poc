
fog admin apply-entitlements --group devs -f entitlements/all-org.yaml --path /poc
fog admin apply-entitlements --group devs -f entitlements/all-workspace.yaml --path /poc/sample
fog admin apply-entitlements --group devs -f entitlements/all-environment.yaml --path /poc/sample/dev
