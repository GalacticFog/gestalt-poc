pod=`kubectl get pod -n gestalt-system  | grep gestalt-security | awk '{print $1}'`
kubectl logs -n gestalt-system $pod --follow --tail 10
