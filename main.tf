terraform {
  backend "atlas" {
    name    = "Grab/map_factory__stg"
    address = "https://terraform.myteksi.net/api/v2"
  }
}

module "compute" {
  source = "../modules/compute"

  # tags related parameters
  environment    = "${local.environment}"
  cluster        = "${local.cluster}"
  team           = "${local.team}"
  service        = "${local.service}"
  costing_family = "${local.costing_family}"

  # Remote state configuration
  organization = "${local.organization}"
  tfe_address  = "${local.tfe_address}"
  cloud        = "${local.cloud}"
  account      = "${local.account}"

  # ELB related configuration
  elb_ssl_certificate_id = "${local.cert_arn_internal}"

  # LC related configuration
  lc_key_name                    = "tower"
  lc_instance_type               = "c5.2xlarge"
  lc_associate_public_ip_address = false
  lc_volume_size                 = "200"
  lc_volume_type                 = "gp2"
  lc_image_name_override         = "baseami-18.04-20190626T105856"

  # ASG related configuration
  asg_min_size = 1
  asg_max_size = 3
}

module "data" {
  source       = "../modules/data"
  organization = "${local.organization}"
  tfe_address  = "${local.tfe_address}"

  # tags related parameters

  environment    = "${local.environment}"
  cluster        = "${local.cluster}"
  team           = "${local.team}"
  costing_family = "${local.costing_family}"
  service        = "${local.service}"
  role           = "${local.service}"
  # SG related parameters
  ec2_sg_id = "${module.compute.sg_id}"

  # rds related parameters

  engine_version                      = "5.7.26"
  master_parameters                   = "${var.master_parameters}"
  master_instance_class               = "db.t2.medium"
  master_allocated_storage            = 100
  master_storage_type                 = "gp2"
  master_provisioned_iops             = 0
  master_performance_insights_enabled = true

  # replica-app rds related parameters

  replica_app_parameters           = "${var.replica_app_parameters}"
  replica_app                      = false
  app_instance_class               = "db.t3.medium"
  app_allocated_storage            = 100
  app_storage_type                 = "gp2"
  app_provisioned_iops             = 0
  app_performance_insights_enabled = false

  # replica-eng rds related parameters

  replica_eng_parameters           = "${var.replica_eng_parameters}"
  replica_eng                      = false
  eng_instance_class               = "db.t3.xlarge"
  eng_allocated_storage            = 100
  eng_storage_type                 = "gp2"
  eng_provisioned_iops             = 0
  eng_performance_insights_enabled = false
  # multi-az
  rds_multi_az = false
  # postgres related configuration ID
  id_postgres_instance_class    = "db.t3.large"
  id_postgres_allocated_storage = 1000
  id_postgres_storage_type      = "gp2"
  id_postgres_replica_app       = false
  id_postgres_replica_eng       = false
  id_postgres_master_parameters = "${var.id_postgres_master_parameters}"
  th_postgres_instance_class    = "db.t3.medium"
  th_postgres_allocated_storage = 500
  th_postgres_storage_type      = "gp2"
  th_postgres_replica_app       = false
  th_postgres_replica_eng       = false
  ph_postgres_instance_class    = "db.t3.medium"
  ph_postgres_allocated_storage = 500
  ph_postgres_storage_type      = "gp2"
  ph_postgres_replica_app       = false
  ph_postgres_replica_eng       = false
  sg_postgres_instance_class    = "db.t3.medium"
  sg_postgres_allocated_storage = 500
  sg_postgres_storage_type      = "gp2"
  sg_postgres_replica_app       = false
  sg_postgres_replica_eng       = false
}

module "s3" {
  source  = "../modules/s3"
  cluster = "${local.cluster}"
  service = "${local.service}"

  geo_tools_buckets         = ["arn:aws:s3:::stg-geo-tools/*", "arn:aws:s3:::stg-geo-tools"]
  grabtaxi_grabroad_buckets = ["arn:aws:s3:::grabtaxi-grabroad/skt-sharing/*"]
}
