
set -e

./user-search $user

fog meta POST /sync

./apply-user-workspace.sh $user
./apply-user-entitlements.sh $user
