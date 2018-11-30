#!/bin/bash

set -e

fog admin apply-entitlements --group devs -f entitlements/readonly-org.yaml --path /poc
fog admin apply-entitlements --group devs -f entitlements/readonly-workspace.yaml --path /poc/sample
fog admin apply-entitlements --group devs -f entitlements/developer-dev-environment.yaml --path /poc/sample/dev


# /root
echo "Applying entitlements for /root..."
for g in `cat groups.txt`; do
  echo "Processing $g ..."
  fog admin apply-entitlements --group $g -f readonly-org.yaml /root --add-only
done

# /poc
echo "Applying entitlements for /poc..."
for g in `cat groups.txt`; do
  echo "Processing $g ..."
  fog admin apply-entitlements --group $g -f readonly-org.yaml /poc --add-only
done

# /poc/sample
echo "Applying entitlements for /poc/sample..."
for g in `cat groups.txt`; do
  echo "Processing $g ..."
  fog admin apply-entitlements --group $g -f readonly-workspace.yaml /poc/sample --add-only
done

# /poc/sample/dev
echo "Applying entitlements for /poc/sample/dev..."
for g in `cat groups.txt`; do
  echo "Processing $g ..."
  fog admin apply-entitlements --group $g -f readonly-environment.yaml /poc/sample/dev --add-only
done
