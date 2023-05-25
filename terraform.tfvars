tenancy_ocid                 = "ocid1.tenancy.oc1..aaaaaaaavq7mli6vqbhibwzbkywghhu7v233cjudlejd5jgyqwsdsuen77ba"
user_ocid                    = "ocid1.user.oc1..aaaaaaaakt5v4gpp36q734qbqtcv4qhkn2nlecjtj6vw6hzdzipplwxn3aqq"
fingerprint                  = "6e:b0:c0:15:ad:d3:59:49:82:8f:76:db:6b:90:9c:bf"
private_key_path             = "/home/opc/private_key"
region                       = "us-ashburn-1"
enable_compartment_delete    = "true"
home_compartment_name        = "INFY_DEMO"
environment_compartment_name = "cmp-p-iad"


hub_vcn_cidr_blocks                 = ["10.0.0.0/16"]
hub_vcn_display_name                = "vcn-hub-iad"
hub_vcn_dns_label                   = "hubvcniad"
drg_display_name                    = "drg-hub-iad"
drg_attachment_display_name         = "drg-hub-attach"
drg_attachment_network_details_type = "VCN"
internet_gateway_enabled            = true
internet_gateway_display_name       = "igw-hub-iad"

drg_route_table_route_rule_route_rules_destination      = "10.0.0.0/8"
drg_route_table_route_rule_route_rules_destination_type = "CIDR_BLOCK"

prod_vcn_cidr_blocks  = ["11.0.0.0/16"]
prod_vcn_display_name = "vcn-prod-iad"
prod_vcn_dns_label    = "vcnprodiad"

nat_gateway_display_name     = "nat-hub-iad"
service_gateway_display_name = "sgw-hub-iad"

mgmt_subnet_cidr_block                 = "10.0.64.0/22"
mgmt_subnet_display_name               = "sub-mgmt-hub-iad"
mgmt_subnet_dns_label                  = "submgmthubiad"
mgmt_subnet_prohibit_public_ip_on_vnic = true
mgmt_security_list_display_name        = "sl-mgmt-sub-iad"
mgmt_route_table_display_name          = "rt-mgmt-sub-iad"

trt_subnet_cidr_block                 = "10.0.68.0/22"
trt_subnet_display_name               = "sub-trt-hub-iad"
trt_subnet_dns_label                  = "subtrthubiad"
trt_subnet_prohibit_public_ip_on_vnic = true
trt_security_list_display_name        = "sl-trt-sub-iad"
trt_route_table_display_name          = "rt-trt-sub-iad"

untrt_subnet_cidr_block                 = "10.0.72.0/21"
untrt_subnet_display_name               = "sub-untrt-hub-iad"
untrt_subnet_dns_label                  = "subuntrthubiad"
untrt_subnet_prohibit_public_ip_on_vnic = true
untrt_security_list_display_name        = "sl-untrt-sub-iad"
untrt_route_table_display_name          = "rt-untrt-sub-iad"


app_subnet_cidr_block                 = "11.0.0.0/20"
app_subnet_display_name               = "sub-app-prod-iad"
app_subnet_dns_label                  = "subappprodiad"
app_subnet_prohibit_public_ip_on_vnic = true
app_security_list_display_name        = "sl-app-sub-iad"
app_route_table_display_name          = "rt-app-sub-iad"

db_subnet_cidr_block                 = "11.0.16.0/20"
db_subnet_display_name               = "sub-db-prod-iad"
db_subnet_dns_label                  = "subdbprodiad"
db_subnet_prohibit_public_ip_on_vnic = true
db_security_list_display_name        = "sl-db-sub-iad"
db_route_table_display_name          = "rt-db-sub-iad"


pvt_lb_subnet_cidr_block                 = "11.0.32.0/20"
pvt_lb_subnet_display_name               = "sub-pvt-lb-prod-iad"
pvt_lb_subnet_dns_label                  = "subpvtlbprodiad"
pvt_lb_subnet_prohibit_public_ip_on_vnic = true
pvt_lb_security_list_display_name        = "sl-pvt-lb-sub-iad"
pvt_lb_route_table_display_name          = "rt-pvt-lb-sub-iad"


pub_lb_subnet_cidr_block                 = "11.0.48.0/20"
pub_lb_subnet_display_name               = "sub-pub-lb-prod-iad"
pub_lb_subnet_dns_label                  = "subpublbprodiad"
pub_lb_subnet_prohibit_public_ip_on_vnic = true
pub_lb_security_list_display_name        = "sl-pub-lb-sub-iad"
pub_lb_route_table_display_name          = "rt-pub-lb-sub-iad"


exa_subnet_cidr_block                 = "11.0.64.0/20"
exa_subnet_display_name               = "sub-exa-prod-iad"
exa_subnet_dns_label                  = "subexaprodiad"
exa_subnet_prohibit_public_ip_on_vnic = true
exa_security_list_display_name        = "sl-exa-sub-iad"
exa_route_table_display_name          = "rt-exa-sub-iad"


dmz_subnet_cidr_block                 = "11.0.80.0/20"
dmz_subnet_display_name               = "sub-dmz-prod-iad"
dmz_subnet_dns_label                  = "subdmzprodiad"
dmz_subnet_prohibit_public_ip_on_vnic = true
dmz_security_list_display_name        = "sl-dmz-prod-sub-iad"
dmz_route_table_display_name          = "rt-dmz-prod-sub-iad"
