
set -e

user=$1

./user-search.sh $user

fog meta POST /sync

./apply-user-workspace.sh $user
./apply-user-entitlements.sh $user
