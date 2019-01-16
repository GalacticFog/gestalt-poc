

# for user in `cat ../../normal-users.txt`; do 
#     echo "Applying entitlements for $user ..."

#     fog admin apply-entitlements --user $user -f ../entitlements/readonly-org.yaml /root
#     fog admin apply-entitlements --user $user -f ../entitlements/readonly-workspace.yaml /root/demo
#     fog admin apply-entitlements --user $user -f ../entitlements/readonly-environment.yaml /root/demo/lambda_chaining
#     fog admin apply-entitlements --user $user -f ../entitlements/readonly-environment.yaml /root/demo/lambda_demo
#     fog admin apply-entitlements --user $user -f ../entitlements/readonly-environment.yaml /root/demo/async_lambdas
#     fog admin apply-entitlements --user $user -f ../entitlements/readonly-environment.yaml /root/demo/periodic_lambdas
#     fog admin apply-entitlements --user $user -f ../entitlements/readonly-environment.yaml /root/demo/vm_provision
#     fog admin apply-entitlements --user $user -f ../entitlements/readonly-environment.yaml /root/demo/url_redirect

# done


time for user in `cat ../../core-users.txt`; do 
    echo "Applying entitlements for $user ..."

    time fog admin apply-entitlements --user $user -f ../entitlements/readonly-org.yaml /root
    time fog admin apply-entitlements --user $user -f ../entitlements/admin-workspace.yaml /root/demo
    time fog admin apply-entitlements --user $user -f ../entitlements/admin-environment.yaml /root/demo/lambda_chaining
    time fog admin apply-entitlements --user $user -f ../entitlements/admin-environment.yaml /root/demo/lambda_demo
    time fog admin apply-entitlements --user $user -f ../entitlements/admin-environment.yaml /root/demo/async_lambdas
    time fog admin apply-entitlements --user $user -f ../entitlements/admin-environment.yaml /root/demo/periodic_lambdas
    time fog admin apply-entitlements --user $user -f ../entitlements/admin-environment.yaml /root/demo/vm_provision
    time fog admin apply-entitlements --user $user -f ../entitlements/admin-environment.yaml /root/demo/url_redirect

done