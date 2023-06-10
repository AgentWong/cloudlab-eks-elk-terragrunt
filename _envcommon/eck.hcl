locals {
  # Automatically load environment-level variables
  env_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  env      = local.env_vars.locals.env

  # Automatically load region-level variables
  region_vars = read_terragrunt_config(find_in_parent_folders("region.hcl"))
  region      = local.region_vars.locals.region
}
dependency "eks" {
  config_path = "${dirname(find_in_parent_folders("region.hcl"))}/services/eks"
  mock_outputs = {
    cluster_endpoint                   = "dummy-string"
    cluster_name                       = "dummy-string"
    cluster_certificate_authority_data = "dummy-string"
  }
  mock_outputs_allowed_terraform_commands = ["validate", "init"]
}
inputs = {
  cluster_endpoint                   = dependency.eks.outputs.cluster_endpoint
  cluster_name                       = dependency.eks.outputs.cluster_name
  cluster_certificate_authority_data = dependency.eks.outputs.cluster_certificate_authority_data
}
