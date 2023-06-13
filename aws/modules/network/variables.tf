
variable "aws" {
  default = {
    csp_prefix = "csl"
    region ="ap-northeast-2"
  }
}

#S3 Backend
variable "bucketName" {
  default = "tf-state"
  type = string
  description = "terraform state bucket name"
}

variable "terraform_backend" {
  default = "networks/basic/terraform.tfstate"
  type = string
  description = "terraform_backend path"
}

variable "dynamodbTableName" {
  default = "tfstate-lock"
  type = string
  description = "dynamodb table name"
}

# VPC
variable "vpc_cidr" {
  default = "192.168.0.0/16"
  type = string
  description = "vpc cidr block"
}

#SUBNET
variable "subnets" {
  default = [
    {
      "cidr" : "192.168.0.0/27",
      "name" : "front_2a",
      "zone" : "a"
    },
    {
      "cidr" : "192.168.0.32/27",
      "name" : "front_2c",
      "zone" : "c"
    },
    {
      "cidr" : "192.168.0.64/27",
      "name" : "back_2a",
      "zone" : "a"
    },
    {
      "cidr" : "192.168.0.96/27",
      "name" : "back_2c",
      "zone" : "c"
    }
  ]
  description = "subnet cidr block"
}

#Internet Gateway

#Nat Gateway
variable "natgateways" {
  default = [
    {
      "name": "back_2a",
      "eip" : true,
      "connected": "front_2a"
    },
    {
      "name": "back_2c",
      "eip" : true,
      "connected": "front_2c"
    }
  ]
  description = "nat gateway"
}

#Routing
variable "routetables" {
  default = [
    {
      "type": "public",
      "main": true,
      "name": "front",
      "cidr_block": "0.0.0.0/0"
    },
    {
      "type": "private",
      "main": false,
      "name": "back_2a",
    },
    {
      "type": "private",
      "main": false,
      "name": "back_2c",
    }
  ]
  description = "route tables"
}

variable "routeWithSubnet" {
  default = [
    {
      "subnet": "front_2a",
      "main": true,
      "router": "front",
    },
    {
      "subnet": "front_2c",
      "main": true,
      "router": "front",
    },
    {
      "subnet": "back_2a",
      "main": false,
      "router": "back_2a",
    },
    {
      "subnet": "back_2c",
      "main": false,
      "router": "back_2c",
    }
  ]
}


#Security Group
variable "securityGroup" {
  default = [
    {
      "name" : "public_loadbalance",
      "egress": {
        "from_port" : 0,
        "to_port" : 0,
        "protocol" : "-1",
        "cidr_blocks" : ["0.0.0.0/0"],
      }
    },
    {
      "name" : "private_loadbalance",
      "egress": {
        "from_port" : 0,
        "to_port" : 0,
        "protocol" : "-1",
        "cidr_blocks" : ["0.0.0.0/0"],
      }
    },
    {
      "name" : "documentdb",
      "egress": {
        "from_port" : 0,
        "to_port" : 0,
        "protocol" : "-1",
        "cidr_blocks" : ["0.0.0.0/0"],
      }
    },
    {
      "name" : "service_worker",
      "egress": {
        "from_port" : 0,
        "to_port" : 0,
        "protocol" : "-1",
        "cidr_blocks" : ["0.0.0.0/0"],
      }
    },
    {
      "name" : "service_sl",
      "egress": {
        "from_port" : 0,
        "to_port" : 0,
        "protocol" : "-1",
        "cidr_blocks" : ["0.0.0.0/0"],
      }
    },
    {
      "name" : "service_admin",
      "egress": {
        "from_port" : 0,
        "to_port" : 0,
        "protocol" : "-1",
        "cidr_blocks" : ["0.0.0.0/0"],
      }
    },
    {
      "name" : "app_sl",
      "egress": {
        "from_port" : 0,
        "to_port" : 0,
        "protocol" : "-1",
        "cidr_blocks" : ["0.0.0.0/0"],
      }
    },
    {
      "name" : "app_admin",
      "egress": {
        "from_port" : 0,
        "to_port" : 0,
        "protocol" : "-1",
        "cidr_blocks" : ["0.0.0.0/0"],
      }
    },
    {
      "name" : "efs",
      "egress": {
        "from_port" : 0,
        "to_port" : 0,
        "protocol" : "-1",
        "cidr_blocks" : ["0.0.0.0/0"],
      }
    },
    {
      "name" : "bastion",
      "egress": {
        "from_port" : 0,
        "to_port" : 0,
        "protocol" : "-1",
        "cidr_blocks" : ["0.0.0.0/0"],
      }
    }
  ]
  description = "security group"
}

#Secutiry Group Rule
variable "securityGroupRuleByCidr" {
  default = [
    {
      "name": "service_worker_efs",
      "type": "ingress",
      "from_port": 80,
      "to_port": 80,
      "protocol": "TCP",
      "security_group_id": "public_loadbalance",
      "cidr_blocks": [ "0.0.0.0/0"]
    },
    {
      "name": "public_loadbalance_443",
      "type": "ingress",
      "from_port": 443,
      "to_port": 443,
      "protocol": "TCP",
      "security_group_id": "public_loadbalance",
      "cidr_blocks": ["0.0.0.0/0"]
    },
    {
      "name": "private_loadbalance_vpc",
      "type": "ingress",
      "from_port": 8101,
      "to_port": 8113,
      "protocol": "TCP",
      "security_group_id": "private_loadbalance",
      "cidr_blocks": ["192.168.0.0/16"]
    }
    ]
  description = "security group rules by cidr"
}

variable "securityGroupRuleById" {
  default = [
    {
      "name": "service_worker_to_private_loadbalance",
      "type": "ingress",
      "from_port": 2049,
      "to_port": 2049,
      "protocol": "TCP",
      "security_group_id": "service_worker",
#      "cidr_blocks": [ "0.0.0.0/0"]
      "source_security_group_id": "private_loadbalance"
    },
    {
      "name": "public_loadbalance_to_service_worker",
      "type": "ingress",
      "from_port": 8101,
      "to_port": 8113,
      "protocol": "TCP",
      "security_group_id": "private_loadbalance",
      "source_security_group_id": "service_worker"
    },
    {
      "name": "private_loadbalance_to_service_admin",
      "type": "ingress",
      "from_port": 8101,
      "to_port": 8113,
      "protocol": "TCP",
      "security_group_id": "private_loadbalance",
      "source_security_group_id": "service_admin"
    },
    {
      "name": "private_loadbalance_to_service_sl",
      "type": "ingress",
      "from_port": 8101,
      "to_port": 8113,
      "protocol": "TCP",
      "security_group_id": "private_loadbalance",
      "source_security_group_id": "service_sl"
    },
    {
      "name": "bastion_to_bastion",
      "type": "ingress",
      "from_port": 20002,
      "to_port": 20002,
      "protocol": "TCP",
      "security_group_id": "bastion",
      "source_security_group_id": "bastion"
    },
    {
      "name": "documentdb_to_service_worker",
      "type": "ingress",
      "from_port": 27017,
      "to_port": 27017,
      "protocol": "TCP",
      "security_group_id": "documentdb",
      "source_security_group_id": "service_worker"
    },
    {
      "name": "documentdb_to_service_admin",
      "type": "ingress",
      "from_port": 27017,
      "to_port": 27017,
      "protocol": "TCP",
      "security_group_id": "documentdb",
      "source_security_group_id": "service_admin"
    },
    {
      "name": "documentdb_to_service_sl",
      "type": "ingress",
      "from_port": 27017,
      "to_port": 27017,
      "protocol": "TCP",
      "security_group_id": "documentdb",
      "source_security_group_id": "service_sl"
    },
    {
      "name": "documentdb_to_bastion",
      "type": "ingress",
      "from_port": 27017,
      "to_port": 27017,
      "protocol": "TCP",
      "security_group_id": "documentdb",
      "source_security_group_id": "bastion"
    },
    {
      "name": "service_worker_to_private_loadbalance_8080",
      "type": "ingress",
      "from_port": 8080,
      "to_port": 8080,
      "protocol": "TCP",
      "security_group_id": "service_worker",
      "source_security_group_id": "private_loadbalance"
    },
    {
      "name": "service_worker_to_private_loadbalance_8110",
      "type": "ingress",
      "from_port": 8110,
      "to_port": 8110,
      "protocol": "TCP",
      "security_group_id": "service_worker",
      "source_security_group_id": "private_loadbalance"
    },
    {
      "name": "service_sl_to_private_loadbalance_8080",
      "type": "ingress",
      "from_port": 8080,
      "to_port": 8080,
      "protocol": "TCP",
      "security_group_id": "service_sl",
      "source_security_group_id": "private_loadbalance"
    },
    {
      "name": "service_sl_to_private_loadbalance_8109",
      "type": "ingress",
      "from_port": 8109,
      "to_port": 8109,
      "protocol": "TCP",
      "security_group_id": "service_sl",
      "source_security_group_id": "private_loadbalance"
    },
    {
      "name": "service_admin_to_private_loadbalance_8080",
      "type": "ingress",
      "from_port": 8080,
      "to_port": 8080,
      "protocol": "TCP",
      "security_group_id": "service_admin",
      "source_security_group_id": "private_loadbalance"
    },
    {
      "name": "service_admin_to_private_loadbalance_8111",
      "type": "ingress",
      "from_port": 8111,
      "to_port": 8111,
      "protocol": "TCP",
      "security_group_id": "service_admin",
      "source_security_group_id": "private_loadbalance"
    },
    {
      "name": "app_sl_to_public_loadbalance_8080",
      "type": "ingress",
      "from_port": 8080,
      "to_port": 8080,
      "protocol": "TCP",
      "security_group_id": "app_sl",
      "source_security_group_id": "public_loadbalance"
    },
    {
      "name": "app_sl_to_public_loadbalance_8084",
      "type": "ingress",
      "from_port": 8084,
      "to_port": 8084,
      "protocol": "TCP",
      "security_group_id": "app_sl",
      "source_security_group_id": "public_loadbalance"
    },
    {
      "name": "app_admin_to_public_loadbalance_8080",
      "type": "ingress",
      "from_port": 8080,
      "to_port": 8080,
      "protocol": "TCP",
      "security_group_id": "app_admin",
      "source_security_group_id": "public_loadbalance"
    },
    {
      "name": "app_admin_to_public_loadbalance_8085",
      "type": "ingress",
      "from_port": 8085,
      "to_port": 8085,
      "protocol": "TCP",
      "security_group_id": "app_admin",
      "source_security_group_id": "public_loadbalance"
    }
  ]
  description = "security group rules by Id"
}

#LoadBalance
variable "loadBalance" {
  default = [
    {
      "name": "public-alb",
      "type": "application",
      "internal": false,
      "securityGroup": ["public_loadbalance"],
      "subnets": ["front_2a","front_2c"]
    },
    {
      "name": "private-alb",
      "type": "application",
      "internal": false,
      "securityGroup": ["private_loadbalance"],
      "subnets": ["back_2a","back_2c"]
    }
  ]
}

#Target Group
variable "targetGroups" {
  default = [
    {
      "name": "tg-app-sl-01",
      "type": "ip",
      "port": 80,
      "protocol": "HTTP",
      "vpc": "vpc",
      "health" : {
        "enabled" : true,
        "protocol" : "HTTP",
        "path" : "/actuator/health",
        "matcher" : "200",
        "interval" : 30,
        "healthy_threshold" : 5,
        "unhealthy_threshold" : 2,
      }
    },
    {
      "name": "tg-app-sl-02",
      "type": "ip",
      "port": 80,
      "protocol": "HTTP",
      "vpc": "vpc",
      "health" : {
        "enabled" : true,
        "protocol" : "HTTP",
        "path" : "/actuator/health",
        "matcher" : "200",
        "interval" : 30,
        "healthy_threshold" : 5,
        "unhealthy_threshold" : 2,
      }
    },
    {
      "name": "tg-app-admin-01",
      "type": "ip",
      "port": 80,
      "protocol": "HTTP",
      "vpc": "vpc",
      "health" : {
        "enabled" : true,
        "protocol" : "HTTP",
        "path" : "/actuator/health",
        "matcher" : "200",
        "interval" : 30,
        "healthy_threshold" : 5,
        "unhealthy_threshold" : 2,
      }
    },
    {
      "name": "tg-app-admin-02",
      "type": "ip",
      "port": 80,
      "protocol": "HTTP",
      "vpc": "vpc",
      "health" : {
        "enabled" : true,
        "protocol" : "HTTP",
        "path" : "/actuator/health",
        "matcher" : "200",
        "interval" : 30,
        "healthy_threshold" : 5,
        "unhealthy_threshold" : 2
      }
    },
    {
      "name": "tg-service-sl-01",
      "type": "ip",
      "port": 80,
      "protocol": "HTTP",
      "vpc": "vpc",
      "health" : {
        "enabled" : true,
        "protocol" : "HTTP",
        "path" : "/actuator/health",
        "matcher" : "200",
        "interval" : 30,
        "healthy_threshold" : 5,
        "unhealthy_threshold" : 2
      }
    },
    {
      "name": "tg-service-sl-02",
      "type": "ip",
      "port": 80,
      "protocol": "HTTP",
      "vpc": "vpc",
      "health" : {
        "enabled" : true,
        "protocol" : "HTTP",
        "path" : "/actuator/health",
        "matcher" : "200",
        "interval" : 30,
        "healthy_threshold" : 5,
        "unhealthy_threshold" : 2
      }
    },
    {
      "name": "tg-service-admin-01",
      "type": "ip",
      "port": 80,
      "protocol": "HTTP",
      "vpc": "vpc",
      "health" : {
        "enabled" : true,
        "protocol" : "HTTP",
        "path" : "/actuator/health",
        "matcher" : "200",
        "interval" : 30,
        "healthy_threshold" : 5,
        "unhealthy_threshold" : 2
      }
    },
    {
      "name": "tg-service-admin-02",
      "type": "ip",
      "port": 80,
      "protocol": "HTTP",
      "vpc": "vpc",
      "health" : {
        "enabled" : true,
        "protocol" : "HTTP",
        "path" : "/actuator/health",
        "matcher" : "200",
        "interval" : 30,
        "healthy_threshold" : 5,
        "unhealthy_threshold" : 2
      }
    },
    {
      "name": "tg-service-worker-01",
      "type": "ip",
      "port": 80,
      "protocol": "HTTP",
      "vpc": "vpc",
      "health" : {
        "enabled" : true,
        "protocol" : "HTTP",
        "path" : "/actuator/health",
        "matcher" : "200",
        "interval" : 30,
        "healthy_threshold" : 5,
        "unhealthy_threshold" : 2
      }
    },
    {
      "name": "tg-service-worker-02",
      "type": "ip",
      "port": 80,
      "protocol": "HTTP",
      "vpc": "vpc",
      "health" : {
        "enabled" : true,
        "protocol" : "HTTP",
        "path" : "/actuator/health",
        "matcher" : "200",
        "interval" : 30,
        "healthy_threshold" : 5,
        "unhealthy_threshold" : 2
      }
    }
  ]
  description = "target group "
}


