locals {
  region_subscriptions = data.oci_identity_region_subscriptions.regions.region_subscriptions
  home_region          = [for region in local.region_subscriptions : region.region_name if region.is_home_region == true]
  region_key           = [for region in local.region_subscriptions : region.region_key if region.region_name == var.region]
}

data "oci_identity_region_subscriptions" "regions" {
  tenancy_id = var.tenancy_ocid
}

data "oci_core_service_gateways" "service_gateways" {
  #Required
  compartment_id = var.tenancy_ocid

  vcn_id = oci_core_vcn.hub_vcn.id
}

data "oci_core_services" "services" {
}
