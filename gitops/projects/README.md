# GitOps



## Git Authentication
```
export GIT_TOKEN=ghp_PcZ...IP0
export GIT_REPO=https://github.com/adilsonmenechini/gitops-argocd.git
```

## Command

```
# create
argocd-autopilot repo bootstrap

# delete
argocd-autopilot repo uninstall

# projeto
argocd-autopilot project create ops

# application

argocd-autopilot app create argo-events --app github.com/argoproj-labs/argocd-autopilot/examples/demo-app/ -p ops --labels "istio-injection=enabled"  --dest-namespace argo-events


argocd-autopilot app create istio \
 --app https://istio-release.storage.googleapis.com/charts \
  -p ops --labels "istio-injection=enabled"  --dest-namespace istio \
  --type kustomize


argocd-autopilot app create observability/prometheus \
 --app https://prometheus-community.github.io/helm-charts \
 -p ops --dest-namespace observability --labels "istio-injection=enabled"\
 --type kustomize


argocd-autopilot app delete prometheus -p ops


kubectl get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" -n argocd | base64 --decode ; echo
kubectl port-forward -n argocd svc/argocd-server 8080:80


kubectl -n observability port-forward svc/kube-prometheus-stack-grafana 3000:80
kubectl get secret kube-prometheus-stack-grafana -o jsonpath="{.data.admin-password}" -n observability | base64 --decode ; echo



kubectl -n argocd create secret generic autopilot-secret --from-literal GITHUB_CLIENT_ID=https://github.com/adilsonmenechini/argocd --from-literal GITHUB_CLIENT_SECRET=ghp_YXhxvQojxSnMWvKlxvo4dNprEZyJ1HpHhL --dry-run=client -oyaml > secret/argocd-secret.yaml

cat secret/argocd-secret.yaml | kubectl apply -f -
aa
kubeseal --fetch-cert > secret/pub.crt
kubeseal --format yaml --cert=secret/pub.crt < secret/argocd-secret.yaml >  bootstrap/argo-cd/sealed-argocd.yaml 



```