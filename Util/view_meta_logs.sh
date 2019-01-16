pod=`kubectl get pod -n gestalt-system  | grep gestalt-meta | awk '{print $1}'`
kubectl logs -n gestalt-system $pod --follow --tail 10
