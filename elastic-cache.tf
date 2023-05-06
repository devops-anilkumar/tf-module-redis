# CREATES CLUSTER
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


















