module "commons" {
  source = "./common"

}

module "argocd" {
  depends_on = [
    module.commons
  ]

  source = "./argocd"

}

