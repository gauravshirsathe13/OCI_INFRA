locals {
  home_compartment = {
    name        = var.home_compartment_name
    description = "OCI Parent Compartment"
  }

  environment_compartment = {
    name        = var.environment_compartment_name
    description = "Environment Compartment"
  }

  network_compartment = {
    name        = "CMP-P-NET-${local.region_key[0]}"
    description = "Network Compartment"
  }

  security_compartment = {
    name        = "CMP-P-SEC-${local.region_key[0]}"
    description = "Security Compartment"
  }

  application_compartment = {
    name        = "CMP-P-APP-${local.region_key[0]}"
    description = "Application Compartment"
  }

  database_compartment = {
    name        = "CMP-P-DB-${local.region_key[0]}"
    description = "Database Compartment"
  }

  hub_compartment = {
    name        = "CMP-P-HUB-${local.region_key[0]}"
    description = "Hub Compartment"
  }

  hub_management_compartment = {
    name        = "CMP-P-HUB-MGMT-${local.region_key[0]}"
    description = "Hub Management Compartment"
  }

  hub_security_compartment = {
    name        = "CMP-P-HUB-SEC-${local.region_key[0]}"
    description = "Hub Database Compartment"
  }

  hub_network_compartment = {
    name        = "CMP-P-HUB-NET-${local.region_key[0]}"
    description = "Hub Network Compartment"
  }
}

# -----------------------------------------------------------------------------
#                               COMPARTMENT                                   #
# -----------------------------------------------------------------------------


resource "oci_identity_compartment" "home_compartment" {
  compartment_id = var.tenancy_ocid
  name           = local.home_compartment.name
  description    = local.home_compartment.description
}

resource "oci_identity_compartment" "environment_compartment" {

  compartment_id = oci_identity_compartment.home_compartment.id
  name           = local.environment_compartment.name
  description    = local.environment_compartment.description

}

resource "oci_identity_compartment" "network_compartment" {

  compartment_id = oci_identity_compartment.environment_compartment.id
  name           = local.network_compartment.name
  description    = local.network_compartment.description

}

resource "oci_identity_compartment" "security_compartment" {

  compartment_id = oci_identity_compartment.environment_compartment.id
  name           = local.security_compartment.name
  description    = local.security_compartment.description

}

resource "oci_identity_compartment" "application_compartment" {

  compartment_id = oci_identity_compartment.environment_compartment.id
  name           = local.application_compartment.name
  description    = local.application_compartment.description

}

resource "oci_identity_compartment" "database_compartment" {

  compartment_id = oci_identity_compartment.environment_compartment.id
  name           = local.database_compartment.name
  description    = local.database_compartment.description

}

resource "oci_identity_compartment" "hub_compartment" {

  compartment_id = oci_identity_compartment.home_compartment.id
  name           = local.hub_compartment.name
  description    = local.hub_compartment.description

}

resource "oci_identity_compartment" "hub_security_compartment" {

  compartment_id = oci_identity_compartment.hub_compartment.id
  name           = local.hub_security_compartment.name
  description    = local.hub_security_compartment.description

}

resource "oci_identity_compartment" "hub_management_compartment" {

  compartment_id = oci_identity_compartment.hub_compartment.id
  name           = local.hub_management_compartment.name
  description    = local.hub_management_compartment.description

}

resource "oci_identity_compartment" "hub_network_compartment" {

  compartment_id = oci_identity_compartment.hub_compartment.id
  name           = local.hub_network_compartment.name
  description    = local.hub_network_compartment.description

}

# -----------------------------------------------------------------------------
#                               HUB VCN                                       #
# -----------------------------------------------------------------------------

resource "oci_core_vcn" "hub_vcn" {

  compartment_id = oci_identity_compartment.hub_network_compartment.id
  cidr_blocks    = var.hub_vcn_cidr_blocks
  display_name   = var.hub_vcn_display_name
  dns_label      = var.hub_vcn_dns_label
}

# -----------------------------------------------------------------------------
#                                   DRG                                       #
# -----------------------------------------------------------------------------

resource "oci_core_drg" "drg" {

  compartment_id = oci_identity_compartment.hub_network_compartment.id
  display_name   = var.drg_display_name

}

resource "oci_core_drg_route_table" "drg_route_table" {
  #Required
  drg_id = oci_core_drg.drg.id
}

resource "oci_core_drg_attachment" "drg_attachment" {

  drg_id       = oci_core_drg.drg.id
  display_name = var.drg_attachment_display_name

  drg_route_table_id = oci_core_drg_route_table.drg_route_table.id

  network_details {
    #The type can be one of these values: IPSEC_TUNNEL, REMOTE_PEERING_CONNECTION, VCN, VIRTUAL_CIRCUIT
    id   = oci_core_vcn.hub_vcn.id
    type = var.drg_attachment_network_details_type

    #Optional
  }
}

resource "oci_core_drg_route_table_route_rule" "drg_route_table_route_rule" {
  #Required
  drg_route_table_id         = oci_core_drg_route_table.drg_route_table.id
  destination                = var.drg_route_table_route_rule_route_rules_destination
  destination_type           = var.drg_route_table_route_rule_route_rules_destination_type
  next_hop_drg_attachment_id = oci_core_drg_attachment.drg_attachment.id

}

# -----------------------------------------------------------------------------
#                               SECURITY LISTS for Hub VCN                    #
# -----------------------------------------------------------------------------

resource "oci_core_security_list" "mgmt_security_list" {
  #Required
  compartment_id = oci_identity_compartment.hub_network_compartment.id
  vcn_id         = oci_core_vcn.hub_vcn.id
  display_name   = var.mgmt_security_list_display_name
}

resource "oci_core_security_list" "trt_security_list" {
  #Required
  compartment_id = oci_identity_compartment.hub_network_compartment.id
  vcn_id         = oci_core_vcn.hub_vcn.id
  display_name   = var.trt_security_list_display_name

}

resource "oci_core_security_list" "untrt_security_list" {
  #Required
  compartment_id = oci_identity_compartment.hub_network_compartment.id
  vcn_id         = oci_core_vcn.hub_vcn.id
  display_name   = var.untrt_security_list_display_name
}

# -----------------------------------------------------------------------------
#                               GATEWAYS for HUB VCN                          #
# -----------------------------------------------------------------------------

resource "oci_core_service_gateway" "hub_service_gateway" {

  compartment_id = oci_identity_compartment.hub_network_compartment.id
  services {
    service_id = data.oci_core_services.services.services.0.id
  }
  vcn_id = oci_core_vcn.hub_vcn.id

  display_name = var.hub_service_gateway_display_name
}
resource "oci_core_internet_gateway" "hub_internet_gateway" {

  compartment_id = oci_identity_compartment.hub_network_compartment.id
  vcn_id         = oci_core_vcn.hub_vcn.id

  enabled      = var.hub_internet_gateway_enabled
  display_name = var.hub_internet_gateway_display_name
}
resource "oci_core_nat_gateway" "hub_nat_gateway" {
  #Required
  compartment_id = oci_identity_compartment.hub_network_compartment.id
  vcn_id         = oci_core_vcn.hub_vcn.id
  display_name   = var.hub_nat_gateway_display_name
}

# -----------------------------------------------------------------------------
#                               HUB ROUTE TABLE                               #
# -----------------------------------------------------------------------------
resource "oci_core_route_table" "mgmt_route_table" {
  #Required
  compartment_id = oci_identity_compartment.hub_network_compartment.id
  vcn_id         = oci_core_vcn.hub_vcn.id
  display_name   = var.mgmt_route_table_display_name
  route_rules {
    #Required
    network_entity_id = oci_core_nat_gateway.hub_nat_gateway.id
    destination       = "0.0.0.0/0"
  }
  route_rules {
    #Required
    network_entity_id = oci_core_drg.drg.id
    destination       = "10.0.0.0/28"
  }

}
resource "oci_core_route_table" "trt_route_table" {
  #Required
  compartment_id = oci_identity_compartment.hub_network_compartment.id
  vcn_id         = oci_core_vcn.hub_vcn.id
  display_name   = var.trt_route_table_display_name
  route_rules {
    #Required
    network_entity_id = oci_core_nat_gateway.hub_nat_gateway.id
    destination       = "0.0.0.0/0"
  }
}
resource "oci_core_route_table" "untrt_route_table" {
  #Required
  compartment_id = oci_identity_compartment.hub_network_compartment.id
  vcn_id         = oci_core_vcn.hub_vcn.id
  display_name   = var.untrt_route_table_display_name
  route_rules {
    #Required
    network_entity_id = oci_core_nat_gateway.hub_nat_gateway.id
    destination       = "0.0.0.0/0"
  }
}

# -----------------------------------------------------------------------------
#                               SUBNET IN HUB VCN                             #
# -----------------------------------------------------------------------------

resource "oci_core_subnet" "mgmt_subnet" {

  cidr_block     = var.mgmt_subnet_cidr_block
  compartment_id = oci_identity_compartment.hub_network_compartment.id
  vcn_id         = oci_core_vcn.hub_vcn.id

  display_name = var.mgmt_subnet_display_name
  dns_label    = var.mgmt_subnet_dns_label

  prohibit_public_ip_on_vnic = var.mgmt_subnet_prohibit_public_ip_on_vnic
  route_table_id             = oci_core_route_table.mgmt_route_table.id
  security_list_ids          = [oci_core_security_list.mgmt_security_list.id]
}

resource "oci_core_subnet" "trt_subnet" {

  cidr_block     = var.trt_subnet_cidr_block
  compartment_id = oci_identity_compartment.hub_network_compartment.id
  vcn_id         = oci_core_vcn.hub_vcn.id

  display_name = var.trt_subnet_display_name
  dns_label    = var.trt_subnet_dns_label

  prohibit_public_ip_on_vnic = var.trt_subnet_prohibit_public_ip_on_vnic
  route_table_id             = oci_core_route_table.trt_route_table.id
  security_list_ids          = [oci_core_security_list.trt_security_list.id]
}

resource "oci_core_subnet" "untrt_subnet" {

  cidr_block     = var.untrt_subnet_cidr_block
  compartment_id = oci_identity_compartment.hub_network_compartment.id
  vcn_id         = oci_core_vcn.hub_vcn.id

  display_name = var.untrt_subnet_display_name
  dns_label    = var.untrt_subnet_dns_label

  prohibit_public_ip_on_vnic = var.untrt_subnet_prohibit_public_ip_on_vnic
  route_table_id             = oci_core_route_table.untrt_route_table.id
  security_list_ids          = [oci_core_security_list.untrt_security_list.id]
}

# -----------------------------------------------------------------------------
#                               PROD VCN                                      #
# -----------------------------------------------------------------------------
resource "oci_core_vcn" "prod_vcn" {

  compartment_id = oci_identity_compartment.network_compartment.id
  cidr_blocks    = var.prod_vcn_cidr_blocks
  display_name   = var.prod_vcn_display_name
  dns_label      = var.prod_vcn_dns_label
}

# -----------------------------------------------------------------------------
#                               SUBNET IN PROD VCN                            #
# -----------------------------------------------------------------------------

resource "oci_core_subnet" "app_subnet" {

  cidr_block     = var.app_subnet_cidr_block
  compartment_id = oci_identity_compartment.network_compartment.id
  vcn_id         = oci_core_vcn.prod_vcn.id

  display_name = var.app_subnet_display_name
  dns_label    = var.app_subnet_dns_label

  prohibit_public_ip_on_vnic = var.app_subnet_prohibit_public_ip_on_vnic
  route_table_id             = oci_core_route_table.app_route_table.id
  security_list_ids          = [oci_core_security_list.app_security_list.id]
}

resource "oci_core_subnet" "pub_lb_subnet" {

  cidr_block     = var.pub_lb_subnet_cidr_block
  compartment_id = oci_identity_compartment.network_compartment.id
  vcn_id         = oci_core_vcn.prod_vcn.id

  display_name = var.pub_lb_subnet_display_name
  dns_label    = var.pub_lb_subnet_dns_label

  prohibit_public_ip_on_vnic = var.pub_lb_subnet_prohibit_public_ip_on_vnic
  route_table_id             = oci_core_route_table.pub_lb_route_table.id
  security_list_ids          = [oci_core_security_list.pub_lb_security_list.id]
}

resource "oci_core_subnet" "db_subnet" {

  cidr_block     = var.db_subnet_cidr_block
  compartment_id = oci_identity_compartment.network_compartment.id
  vcn_id         = oci_core_vcn.prod_vcn.id

  display_name = var.db_subnet_display_name
  dns_label    = var.db_subnet_dns_label

  prohibit_public_ip_on_vnic = var.db_subnet_prohibit_public_ip_on_vnic
  route_table_id             = oci_core_route_table.db_route_table.id
  security_list_ids          = [oci_core_security_list.db_security_list.id]
}

resource "oci_core_subnet" "pvt_lb_subnet" {

  cidr_block     = var.pvt_lb_subnet_cidr_block
  compartment_id = oci_identity_compartment.network_compartment.id
  vcn_id         = oci_core_vcn.prod_vcn.id

  display_name = var.pvt_lb_subnet_display_name
  dns_label    = var.pvt_lb_subnet_dns_label

  prohibit_public_ip_on_vnic = var.pvt_lb_subnet_prohibit_public_ip_on_vnic
  route_table_id             = oci_core_route_table.pvt_lb_route_table.id
  security_list_ids          = [oci_core_security_list.pvt_lb_security_list.id]
}

resource "oci_core_subnet" "dmz_subnet" {

  cidr_block     = var.dmz_subnet_cidr_block
  compartment_id = oci_identity_compartment.network_compartment.id
  vcn_id         = oci_core_vcn.prod_vcn.id

  display_name = var.dmz_subnet_display_name
  dns_label    = var.dmz_subnet_dns_label

  prohibit_public_ip_on_vnic = var.dmz_subnet_prohibit_public_ip_on_vnic
  route_table_id             = oci_core_route_table.dmz_route_table.id
  security_list_ids          = [oci_core_security_list.dmz_security_list.id]
}

resource "oci_core_subnet" "exa_subnet" {

  cidr_block     = var.exa_subnet_cidr_block
  compartment_id = oci_identity_compartment.network_compartment.id
  vcn_id         = oci_core_vcn.prod_vcn.id

  display_name = var.exa_subnet_display_name
  dns_label    = var.exa_subnet_dns_label

  prohibit_public_ip_on_vnic = var.exa_subnet_prohibit_public_ip_on_vnic
  route_table_id             = oci_core_route_table.exa_route_table.id
  security_list_ids          = [oci_core_security_list.exa_security_list.id]
}

# -----------------------------------------------------------------------------
#                               GATEWAYS for Prod VCN                         #
# -----------------------------------------------------------------------------

resource "oci_core_service_gateway" "prod_service_gateway" {

  compartment_id = oci_identity_compartment.network_compartment.id
  services {
    service_id = data.oci_core_services.services.services.0.id
  }
  vcn_id = oci_core_vcn.prod_vcn.id

  display_name = var.prod_service_gateway_display_name
}
resource "oci_core_internet_gateway" "prod_internet_gateway" {

  compartment_id = oci_identity_compartment.network_compartment.id
  vcn_id         = oci_core_vcn.prod_vcn.id

  enabled      = var.prod_internet_gateway_enabled
  display_name = var.prod_internet_gateway_display_name
}
resource "oci_core_nat_gateway" "prod_nat_gateway" {
  #Required
  compartment_id = oci_identity_compartment.network_compartment.id
  vcn_id         = oci_core_vcn.prod_vcn.id
  display_name   = var.prod_nat_gateway_display_name
}

# -----------------------------------------------------------------------------
#                               PROD ROUTE TABLE                               #
# -----------------------------------------------------------------------------

resource "oci_core_route_table" "app_route_table" {
  #Required
  compartment_id = oci_identity_compartment.network_compartment.id
  vcn_id         = oci_core_vcn.prod_vcn.id
  display_name   = var.app_route_table_display_name
  route_rules {
    #Required
    network_entity_id = oci_core_drg.drg.id
    destination       = "10.0.0.0/28"
  }
}

resource "oci_core_route_table" "db_route_table" {
  #Required
  compartment_id = oci_identity_compartment.network_compartment.id
  vcn_id         = oci_core_vcn.prod_vcn.id
  display_name   = var.db_route_table_display_name
  route_rules {
    #Required
    network_entity_id = oci_core_drg.drg.id
    destination       = "10.0.0.0/28"
  }
}

resource "oci_core_route_table" "pvt_lb_route_table" {
  #Required
  compartment_id = oci_identity_compartment.network_compartment.id
  vcn_id         = oci_core_vcn.prod_vcn.id
  display_name   = var.pvt_lb_route_table_display_name
  route_rules {
    #Required
    network_entity_id = oci_core_drg.drg.id
    destination       = "10.0.0.0/28"
  }
}

resource "oci_core_route_table" "pub_lb_route_table" {
  #Required
  compartment_id = oci_identity_compartment.network_compartment.id
  vcn_id         = oci_core_vcn.prod_vcn.id
  display_name   = var.pub_lb_route_table_display_name
  route_rules {
    #Required
    network_entity_id = oci_core_drg.drg.id
    destination       = "10.0.0.0/28"
  }
}

resource "oci_core_route_table" "exa_route_table" {
  #Required
  compartment_id = oci_identity_compartment.network_compartment.id
  vcn_id         = oci_core_vcn.prod_vcn.id
  display_name   = var.exa_route_table_display_name
  route_rules {
    #Required
    network_entity_id = oci_core_drg.drg.id
    destination       = "10.0.0.0/28"
  }
}

resource "oci_core_route_table" "dmz_route_table" {
  #Required
  compartment_id = oci_identity_compartment.network_compartment.id
  vcn_id         = oci_core_vcn.prod_vcn.id
  display_name   = var.dmz_route_table_display_name
  route_rules {
    #Required
    network_entity_id = oci_core_drg.drg.id
    destination       = "10.0.0.0/28"
  }
}

# -----------------------------------------------------------------------------
#                               SECURITY LISTS for Prod VCN                   #
# -----------------------------------------------------------------------------

resource "oci_core_security_list" "app_security_list" {
  #Required
  compartment_id = oci_identity_compartment.network_compartment.id
  vcn_id         = oci_core_vcn.prod_vcn.id
  display_name   = var.app_security_list_display_name
}

resource "oci_core_security_list" "db_security_list" {
  #Required
  compartment_id = oci_identity_compartment.network_compartment.id
  vcn_id         = oci_core_vcn.prod_vcn.id
  display_name   = var.db_security_list_display_name
}

resource "oci_core_security_list" "pvt_lb_security_list" {
  #Required
  compartment_id = oci_identity_compartment.network_compartment.id
  vcn_id         = oci_core_vcn.prod_vcn.id
  display_name   = var.pvt_lb_security_list_display_name
}

resource "oci_core_security_list" "pub_lb_security_list" {
  #Required
  compartment_id = oci_identity_compartment.network_compartment.id
  vcn_id         = oci_core_vcn.prod_vcn.id
  display_name   = var.pub_lb_security_list_display_name
}

resource "oci_core_security_list" "exa_security_list" {
  #Required
  compartment_id = oci_identity_compartment.network_compartment.id
  vcn_id         = oci_core_vcn.prod_vcn.id
  display_name   = var.exa_security_list_display_name
}

resource "oci_core_security_list" "dmz_security_list" {
  #Required
  compartment_id = oci_identity_compartment.network_compartment.id
  vcn_id         = oci_core_vcn.prod_vcn.id
  display_name   = var.dmz_security_list_display_name
}
