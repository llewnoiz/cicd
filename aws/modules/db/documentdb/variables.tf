

variable "vpcId" {
  default = "vpc-01d891f2344292fe8"  
}

variable "subnetIds" {
  default = ["subnet-057c937064cc56f8c","subnet-009d9deca8b30b684"]
}

variable "securityGroupId" {
  default = ["sg-0d33e40c45484108d"]
}

variable "cluster" {
  default = "skt-csl-documentdb-cluster"
}

variable "instance" {
  default = {
      "class" : "db.t3.medium",
      "name": "skt-csl-documentdb-instance"
      "count": 1
    }
}

variable "admin" {
  default = {
      "name": "skt_db_admin",
      "password": "1q2w3e4r5t6y"
    }
}

variable "params" {
  default = {
      "name": "skt-csl-documentdb-params"
    }
}

variable "tags" {
  default = {
      "Name": "stk-csl-database-instance"
      "Group":  "stk-csl-database"
    }
}
