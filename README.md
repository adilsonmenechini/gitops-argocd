# Hands On

## ArgoCD 101

##
```sh
.
├── gitops
│   ├── apps
│   │   ├── default
│   │   │   └── argocd
│   │   │       └── kind-k8s00
│   │   │           ├── argocd-cm.yaml
│   │   │           ├── ingress.yaml
│   │   │           └── kustomization.yaml
│   │   ├── dev
│   │   └── ops
│   │       ├── ingress-nginx
│   │       │   └── kind-k8s00
│   │       │       ├── config.json
│   │       │       └── kustomization.yaml
│   │       └── metrics-server
│   │           └── kind-k8s00
│   │               ├── config.json
│   │               └── kustomization.yaml
│   ├── bootstrap
│   │   ├── argo-bootstrap.yaml
│   │   ├── argo-cd.yaml
│   │   ├── cluster-resources
│   │   │   ├── in-cluster
│   │   │   │   ├── argocd-ns.yaml
│   │   │   │   └── README.md
│   │   │   └── in-cluster.json
│   │   ├── cluster-resources.yaml
│   │   └── root.yaml
│   └── projects
│       ├── ops.yaml
│       └── README.md
├── kind
│   ├── main.tf
│   ├── output.tf
│   ├── plan
│   ├── provider.tf
│   ├── terraform.tfstate
│   └── variables.tf
├── LICENSE
├── Makefile
├── modules
│   ├── argocd
│   │   ├── kustomization.yaml
│   │   └── values.yaml
│   ├── argocd-apps
│   │   ├── kustomization.yaml
│   │   └── values.yaml
│   ├── argo-rollouts
│   │   ├── kustomization.yaml
│   │   └── values.yaml
│   ├── argo-workflows
│   │   ├── kustomization.yaml
│   │   └── values.yaml
│   ├── ingress-nginx
│   │   ├── kustomization.yaml
│   │   └── values.yaml
│   └── metrics-server
│       ├── kustomization.yaml
│       └── values.yaml
├── README.md
└── toolkit
    ├── argo.tf
    ├── ingress.tf
    ├── metrics.tf
    ├── plan
    ├── provider.tf
    ├── terraform.tfstate
    └── variables.tf
```

### Makefile

```sh
> make help

 ------------------------------------
 Terraform
 ------------------------------------

 -- k8s --
 make k8s - install create/deploy
 make k8s - destroy k8s

 -- toolkit --
 make toolkit - install create/deploy {kind, argocd metrics e ingress}
 make toolkit - destroy toolkit
 make argocd - argocd server password and portforward 0.0.0.0:8081

 make clean - remover arquivos terraform
```