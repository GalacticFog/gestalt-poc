
## Gestalt Security


Add Certs to Gestalt Security keystore
```
pod=`kubectl get pod -n gestalt-system | grep gestalt-security- | awk '{print $1}'`

kubectl cp gestalt-system/$pod:/etc/ssl/certs/java/cacerts .

cp cacerts.orig cacerts

for f in CERT1 CERT2 CERT3; do
  keytool -importcert -v -trustcacerts -alias $f -file ./Certs/$f.cer -keystore cacerts -storepass changeit -noprompt -storetype JKS
done

kubectl create configmap -n gestalt-system gestalt-security-cacerts --from-file=cacerts
```


Configure Debug Logging
```
kubectl delete configmap  -n gestalt-system gestalt-security-logback-config
kubectl create configmap -n gestalt-system gestalt-security-logback-config --from-file=gestalt-security-logback-config.xml

```