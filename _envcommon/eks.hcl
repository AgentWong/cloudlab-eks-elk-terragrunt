locals {
  # Automatically load environment-level variables
  env_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  env      = local.env_vars.locals.env

  # Automatically load region-level variables
  region_vars = read_terragrunt_config(find_in_parent_folders("region.hcl"))
  region      = local.region_vars.locals.region
}
dependency "vpc" {
  config_path = "${dirname(find_in_parent_folders("region.hcl"))}/vpc"
  mock_outputs = {
    private_subnets_ids  = ["temporary-dummy-id"]
    private_subnet_cidrs = "8.8.8.8/16"
    vpc_id               = "temporary-dummy-id"
    vpc_cidr             = "10.0"
  }
  mock_outputs_allowed_terraform_commands = ["validate", "init"]
}
inputs = {
  private_subnets = dependency.vpc.outputs.private_subnets
  vpc_id          = dependency.vpc.outputs.vpc_id
  env             = local.env
  region          = local.region
}
