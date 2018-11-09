
set -e

fog admin apply-entitlements --group devs -f entitlements/readonly-org.yaml --path /poc
fog admin apply-entitlements --group devs -f entitlements/readonly-workspace.yaml --path /poc/sample
fog admin apply-entitlements --group devs -f entitlements/developer-dev-environment.yaml --path /poc/sample/dev
