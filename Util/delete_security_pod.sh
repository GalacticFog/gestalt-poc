kubectl delete pod -n gestalt-system `kubectl get pod -n gestalt-system  | grep gestalt-security | awk '{print $1}'`