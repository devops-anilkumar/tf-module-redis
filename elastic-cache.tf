# CREATES CLUSTER
resource "aws_elasticache_cluster" "redis" {
  cluster_id           = "robot-${var.ENV}-redis"
  engine               = "redis"
  node_type            = var.ELASTIC_CACHE_NODE_TYPE
  num_cache_nodes      = var.ELASTIC_CACHE_NODE_COUNT 
  parameter_group_name = aws_elasticache_parameter_group.default.name
  engine_version       = var.ELASTIC_CACHE_ENGINE_VERSION
  port                 = var.ELASTIC_CACHE_PORT
  security_group_ids   =  [aws_security_group.allow_redis.id]
  subnet_group_name    =  aws_elasticache_subnet_group.redis_subnet_group.name
}

#CREATES PARAMETER GROUP
resource "aws_elasticache_parameter_group" "default" {
  name            = "robot-${var.ENV}-redis"
  family          = "redis${var.ELASTIC_CACHE_ENGINE_VERSION}"
}

# CREATES SUBNET GROUP
resource "aws_elasticache_subnet_group" "redis_subnet_group" {
  name       = "robot-${var.ENV}-redis-subnet-group"
  subnet_ids = data.terraform_remote_state.vpc.outputs.PRIVATE_SUBNET_IDS
}


















