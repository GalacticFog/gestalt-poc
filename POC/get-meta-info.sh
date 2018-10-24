#!/bin/bash
kubectl describe deploy --all-namespaces | grep GESTALT_SECURITY_KEY
kubectl describe deploy --all-namespaces | grep GESTALT_SECURITY_SECRET