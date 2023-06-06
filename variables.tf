# -----------------------------------------------------------------------------
# Common Variables
# -----------------------------------------------------------------------------
variable "tenancy_ocid" {
  type        = string
  description = "The OCID of tenancy"
}

variable "user_ocid" {
  type        = string
  description = "The OCID of User"
}

variable "fingerprint" {
  type        = string
  description = "The fingerprint of User"
}

variable "private_key_path" {
  type        = string
  description = "The private_key_path of Key"
}

variable "region" {
  type        = string
  description = "The OCI region"
}

variable "home_compartment_name" {
  type        = string
  description = "OCI Parent Compartment"
}


# -----------------------------------------------------------------------------
# Compartment Variables
# -----------------------------------------------------------------------------

variable "enable_compartment_delete" {
  type        = bool
  description = "Set to true to allow the compartments to delete on terraform destroy."
  default     = true
}

variable "environment_compartment_name" {
  type        = string
  description = "The name of the compartment that acts as the main compartment for the environment. Resources related to this environment will be created under this compartment. "
}

# -----------------------------------------------------------------------------
# PROD VCN Variables
# -----------------------------------------------------------------------------

variable "prod_vcn_cidr_blocks" {
  type        = list(string)
  description = "The CIDR value of your Prod VCN"

}


variable "prod_vcn_display_name" {
  type        = string
  description = "The Name of your Prod VCN"

}

variable "prod_vcn_dns_label" {
  type        = string
  description = "The DNS Name of your Prod VCN"

}

# -----------------------------------------------------------------------------
# Application Subnet Variables for PROD VCN
# -----------------------------------------------------------------------------

variable "app_subnet_cidr_block" {
  type        = string
  description = "CIDR values for Application Subnet in Prod VCN"
}

variable "app_subnet_display_name" {
  type        = string
  description = "The Name of your App Subnet in Prod VCN"
}

variable "app_subnet_dns_label" {
  type        = string
  description = "The DNS Name of your App Subnet in Prod VCN"
}

variable "app_subnet_prohibit_public_ip_on_vnic" {
  type        = bool
  description = "True/False based on private/public subnet respectively for App subnet"
}

variable "app_security_list_display_name" {
  type        = string
  description = "The Name of security list of App Subnet in Prod VCN"
}

# -----------------------------------------------------------------------------
# Database Subnet Variables for PROD VCN
# -----------------------------------------------------------------------------

variable "db_subnet_cidr_block" {
  type        = string
  description = "CIDR values for Database Subnet in Prod VCN"
}

variable "db_subnet_display_name" {
  type        = string
  description = "The Name of your Database Subnet in Prod VCN"
}

variable "db_subnet_dns_label" {
  type        = string
  description = "The DNS Name of your Database Subnet in Prod VCN"
}

variable "db_subnet_prohibit_public_ip_on_vnic" {
  type        = bool
  description = "True/False based on private/public subnet respectively for Database subnet"
}

variable "db_security_list_display_name" {
  type        = string
  description = "The Name of security list of Database Subnet in Prod VCN"
}

# -----------------------------------------------------------------------------
# Public Load Balancer Subnet Variables for PROD VCN
# -----------------------------------------------------------------------------

variable "pub_lb_subnet_cidr_block" {
  type        = string
  description = "CIDR values for Public LB Subnet in Prod VCN"
}

variable "pub_lb_subnet_display_name" {
  type        = string
  description = "The Name of your Public LB Subnet in Prod VCN"
}

variable "pub_lb_subnet_dns_label" {
  type        = string
  description = "The DNS Name of your Public LB Subnet in Prod VCN"
}

variable "pub_lb_subnet_prohibit_public_ip_on_vnic" {
  type        = bool
  description = "True/False based on private/public subnet respectively for Public LB subnet"
}

variable "pub_lb_security_list_display_name" {
  type        = string
  description = "The Name of security list of Public LB Subnet in Prod VCN"
}

# -----------------------------------------------------------------------------
# Private Load Balancer Subnet Variables for PROD VCN
# -----------------------------------------------------------------------------

variable "pvt_lb_subnet_cidr_block" {
  type        = string
  description = "CIDR values for Private LB Subnet in Prod VCN"
}

variable "pvt_lb_subnet_display_name" {
  type        = string
  description = "The Name of your Private LB Subnet in Prod VCN"
}

variable "pvt_lb_subnet_dns_label" {
  type        = string
  description = "The DNS Name of your Private LB Subnet in Prod VCN"
}

variable "pvt_lb_subnet_prohibit_public_ip_on_vnic" {
  type        = bool
  description = "True/False based on private/public subnet respectively for Private LB subnet"
}

variable "pvt_lb_security_list_display_name" {
  type        = string
  description = "The Name of security list of Private LB Subnet in Prod VCN"
}

# -----------------------------------------------------------------------------
# DMZ Subnet Variables for PROD VCN
# -----------------------------------------------------------------------------

variable "dmz_subnet_cidr_block" {
  type        = string
  description = "CIDR values for DMZ Subnet in Prod VCN"
}

variable "dmz_subnet_display_name" {
  type        = string
  description = "The Name of your DMZ Subnet in Prod VCN"
}

variable "dmz_subnet_dns_label" {
  type        = string
  description = "The DNS Name of your DMZ Subnet in Prod VCN"
}

variable "dmz_subnet_prohibit_public_ip_on_vnic" {
  type        = bool
  description = "True/False based on private/public subnet respectively for DMZ subnet"
}

variable "dmz_security_list_display_name" {
  type        = string
  description = "The Name of security list of DMZ Subnet in Prod VCN"
}

# -----------------------------------------------------------------------------
# Application Subnet Variables for PROD VCN
# -----------------------------------------------------------------------------

variable "exa_subnet_cidr_block" {
  type        = string
  description = "CIDR values for Exadata Subnet in Prod VCN"
}

variable "exa_subnet_display_name" {
  type        = string
  description = "The Name of your Exadata Subnet in Prod VCN"
}

variable "exa_subnet_dns_label" {
  type        = string
  description = "The DNS Name of your Exadata Subnet in Prod VCN"
}

variable "exa_subnet_prohibit_public_ip_on_vnic" {
  type        = bool
  description = "True/False based on private/public subnet respectively for Exadata subnet"
}

variable "exa_security_list_display_name" {
  type        = string
  description = "The Name of security list of App Subnet in Exadata VCN"
}
# -----------------------------------------------------------------------------
# HUB VCN Variables
# -----------------------------------------------------------------------------

variable "hub_vcn_cidr_blocks" {
  type        = list(string)
  description = "The CIDR value of your HUB VCN"
}

variable "hub_vcn_display_name" {
  type        = string
  description = "The Name of your HUB VCN"
}

variable "hub_vcn_dns_label" {
  type        = string
  description = "The DNS Name of your HUB VCN"
}

# -----------------------------------------------------------------------------
# DRG Variables
# -----------------------------------------------------------------------------

variable "drg_display_name" {
  type        = string
  description = "The Name of your DRG"
}

variable "drg_attachment_display_name" {
  type        = string
  description = "The name of DRG Attachment"
}

variable "drg_attachment_network_details_type" {
  type        = string
  description = "The type can be one of these values: IPSEC_TUNNEL, REMOTE_PEERING_CONNECTION, VCN, VIRTUAL_CIRCUIT"
}

variable "drg_route_table_route_rule_route_rules_destination" {
  type        = string
  description = "CIDR values for DRG Route"
}

variable "drg_route_table_route_rule_route_rules_destination_type" {
  type        = string
  description = "Type of value for destination route rule"
  default     = "CIDR_BLOCK"
}

# -----------------------------------------------------------------------------
# Gateway Variables for HUB VCN
# -----------------------------------------------------------------------------

variable "hub_internet_gateway_enabled" {
  type        = bool
  description = "Should IG be enabled in HUB VCN? True/False"
}

variable "hub_internet_gateway_display_name" {
  type        = string
  description = "Name of Internet Gateway connected to HUB VCN"
}

variable "hub_nat_gateway_display_name" {
  type        = string
  description = "Should NAT be enabled in HUB VCN? True/False"
}

variable "hub_service_gateway_display_name" {
  type        = string
  description = "Should SG be enabled in HUB VCN? True/False"
}

# -----------------------------------------------------------------------------
# Route Tables Variables for HUB VCN
# -----------------------------------------------------------------------------

variable "mgmt_route_table_display_name" {
  type        = string
  description = "Route table name for Management subnet"
}

variable "trt_route_table_display_name" {
  type        = string
  description = "Route table name for Trusted subnet"
}
variable "untrt_route_table_display_name" {
  type        = string
  description = "Route table name for Un-Trusted subnet"
}

# -----------------------------------------------------------------------------
# Management Subnet Variables for HUB VCN
# -----------------------------------------------------------------------------

variable "mgmt_subnet_cidr_block" {
  type        = string
  description = "CIDR values for Management Subnet in HUB VCN"
}

variable "mgmt_subnet_display_name" {
  type        = string
  description = "The Name of your Management Subnet in HUB VCN"
}

variable "mgmt_subnet_dns_label" {
  type        = string
  description = "The DNS Name of your Management Subnet in HUB VCN"
}

variable "mgmt_subnet_prohibit_public_ip_on_vnic" {
  type        = bool
  description = "True/False based on private/public subnet respectively for management subnet"
}
variable "mgmt_security_list_display_name" {
  type        = string
  description = "The Name of security list of Management Subnet in HUB VCN"
}

# -----------------------------------------------------------------------------
# Trusted Subnet Variables for HUB VCN
# -----------------------------------------------------------------------------


variable "trt_subnet_cidr_block" {
  type        = string
  description = "CIDR values for Trusted Subnet in HUB VCN"
}

variable "trt_subnet_display_name" {
  type        = string
  description = "The Name of your Trusted Subnet in HUB VCN"
}

variable "trt_subnet_dns_label" {
  type        = string
  description = "The DNS Name of your Un-Trusted Subnet in HUB VCN"
}

variable "trt_subnet_prohibit_public_ip_on_vnic" {
  type        = bool
  description = "True/False based on private/public subnet respectively for Trusted subnet"
}

variable "trt_security_list_display_name" {
  type        = string
  description = "The Name of security list of Trusted Subnet in HUB VCN"
}

# -----------------------------------------------------------------------------
# Un-Trusted Subnet Variables for HUB VCN
# -----------------------------------------------------------------------------

variable "untrt_subnet_cidr_block" {
  type        = string
  description = "CIDR values for Un-Trusted Subnet in HUB VCN"
}

variable "untrt_subnet_display_name" {
  type        = string
  description = "The Name of your Un-Trusted Subnet in HUB VCN"
}

variable "untrt_subnet_dns_label" {
  type        = string
  description = "The DNS Name of your Un-Trusted Subnet in HUB VCN"
}

variable "untrt_subnet_prohibit_public_ip_on_vnic" {
  type        = bool
  description = "True/False based on private/public subnet respectively for Un-Trusted subnet"
}

variable "untrt_security_list_display_name" {
  type        = string
  description = "The Name of security list of Un-Trusted Subnet in HUB VCN"
}

# -----------------------------------------------------------------------------
# Route Tables Variables for PROD VCN
# -----------------------------------------------------------------------------

variable "db_route_table_display_name" {
  type        = string
  description = "Route table name for DB subnet"
}

variable "app_route_table_display_name" {
  type        = string
  description = "Route table name for App subnet"
}

variable "pvt_lb_route_table_display_name" {
  type        = string
  description = "Route table name for Private LB subnet"
}

variable "pub_lb_route_table_display_name" {
  type        = string
  description = "Route table name for Public LB subnet"
}

variable "exa_route_table_display_name" {
  type        = string
  description = "Route table name for Exadata subnet"
}

variable "dmz_route_table_display_name" {
  type        = string
  description = "Route table name for DMZ subnet"
}


# -----------------------------------------------------------------------------
# Gateway Variables for Prod VCN
# -----------------------------------------------------------------------------

variable "prod_internet_gateway_enabled" {
  type        = bool
  description = "Should IG be enabled in Prod VCN? True/False"
}

variable "prod_internet_gateway_display_name" {
  type        = string
  description = "Name of Internet Gateway connected to Prod VCN"
}

variable "prod_nat_gateway_display_name" {
  type        = string
  description = "Should NAT be enabled in Prod VCN? True/False"
}

variable "prod_service_gateway_display_name" {
  type        = string
  description = "Should SG be enabled in Prod VCN? True/False"
}
