terraform {
  source = "${include.root.locals.base_source_url}//composite/services/eks"
}
include "root" {
  path   = find_in_parent_folders()
  expose = true
}
include "env" {
  path   = find_in_parent_folders("env.hcl")
  expose = true
}
include "eks" {
  path = "${dirname(find_in_parent_folders())}/_envcommon/eks.hcl"
}
inputs = {
  cluster_version = "1.27"
}