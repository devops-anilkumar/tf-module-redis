resource "aws_elasticache_cluster" "redis" {
  cluster_id           = "robot-${var.ENV}-redis"
  engine               = "redis"
  node_type            = "cache.t3.small"
  num_cache_nodes      = 1
  parameter_group_name = aws_elasticache_parameter_group.default.name
  engine_version       = "6.x"
  port                 = 6379
  security_group_ids   =  [aws_security_group.allow_redis.id]
  subnet_group_name    =  aws_elasticache_subnet_group.redis_subnet_group.name
}

#CREATES PARAMETER GROUP
resource "aws_elasticache_parameter_group" "default" {
  name            = "robot-${var.ENV}-redis"
  family          = "redis6.x"
}

# CREATES SUBNET GROUP
resource "aws_elasticache_subnet_group" "redis_subnet_group" {
  name       = "robot-${var.ENV}-redis-subnet-group"
  subnet_ids = data.terraform_remote_state.vpc.outputs.PRIVATE_SUBNET_IDS
}


















# # CREATING A CLUSTER OF DOCUMENT DB
# resource "aws_docdb_cluster" "docdb" {
#   cluster_identifier = "robot-${var.ENV}-docdb"
#   engine                  = "docdb"
#   master_username         = "admin1"
#   master_password         = "roboshop1"
#   //backup_retention_period = 5
#   //preferred_backup_window = "07:00-09:00"
#   skip_final_snapshot     = true
#   db_subnet_group_name    = aws_docdb_subnet_group.docdb_subnet-group.name
#   vpc_security_group_ids  =[aws_security_group.allow_mongodb.id]
# }

# # CREATES SUBNET GROUP NEEDED TO HOST THE DOCDB CLUSTER
# resource "aws_docdb_subnet_group" "docdb_subnet-group" {
#   name       = "robot-${var.ENV}-docdb-subnet-group"
#   subnet_ids = data.terraform_remote_state.vpc.outputs.PRIVATE_SUBNET_IDS

#   tags = {
#     Name = "robot-${var.ENV}-docdb-subnet-group"
#   }
# }

# output "output_ref" {
#     value = data.terraform_remote_state.vpc
# }

# # CREATES INSTANCES NEEDED FOR THE DOCDB CLUSTER
# resource "aws_docdb_cluster_instance" "cluster_instances" {
#   count              = 1
#   identifier         = "robot-${var.ENV}-docdb-instance"
#   cluster_identifier = aws_docdb_cluster.docdb.id
#   instance_class     = "db.t3.medium"
# }
