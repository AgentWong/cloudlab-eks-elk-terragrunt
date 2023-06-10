terraform {
  source = "${include.root.locals.base_source_url}//composite/configurations/eks/eck/elastic"
}
include "root" {
  path   = find_in_parent_folders()
  expose = true
}
include "env" {
  path   = find_in_parent_folders("env.hcl")
  expose = true
}
include "eck" {
  path = "${dirname(find_in_parent_folders())}/_envcommon/eck.hcl"
}
dependencies {
  paths = ["../crds"]
}