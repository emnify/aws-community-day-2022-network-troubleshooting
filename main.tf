module "topology" {
  source = "./modules/topology"
}

provider "aws" {
  default_tags {
    tags = {
      Trouble = "yes"
    }
  }
}