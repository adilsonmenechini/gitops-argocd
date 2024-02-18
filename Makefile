.PHONY: k8s k8s-destroy toolkit toolkit-destroy clean

help: 
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//' 
	
.DEFAULT_GOAL := help
##
## ------------------------------------
## Terraform
## ------------------------------------
##


## -- k8s --
## make k8s - install create/deploy
k8s:
	@cd kind && terraform init
	@cd kind && terraform plan -out=plan
	@cd kind && terraform apply plan

## make k8s - destroy k8s
k8s-destroy:
	@cd kind && terraform apply -destroy

## -- toolkit --
## make toolkit - install create/deploy {kind, argocd metrics e ingress}
toolkit:
	@cd toolkit && terraform init
	@cd toolkit && terraform plan -out=plan
	@cd toolkit && terraform apply plan

## make toolkit - destroy toolkit
toolkit-destroy:
	@cd toolkit && terraform apply -destroy

## make argocd - argocd server password and portforward 0.0.0.0:8081
argocd:
	@echo "---" 
	@echo "Password:" 
	@kubectl get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" -n argocd | base64 --decode ; echo
	@echo "---" 
	kubectl port-forward -n argocd svc/argocd-server 8081:80

##
## make clean - remover arquivos terraform
clean:
	@rm -rf kind/terraform.* kind/.terraform.* kind/.terraform* kind/plan kind/*-config*
	@rm -rf toolkit/terraform.* toolkit/.terraform.* toolkit/.terraform* toolkit/plan

## 
## 
## 
