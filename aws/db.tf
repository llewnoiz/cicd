# module "documentdb" {
#     source = "./modules/db/documentdb"

#     vpcId = "vpc-01d891f2344292fe8"  
#     subnetIds = ["subnet-057c937064cc56f8c","subnet-009d9deca8b30b684"]
#     securityGroupId = ["sg-0d33e40c45484108d"]
#     cluster = "skt-csl-documentdb-cluster"
#     instance = {
#         "class" : "db.t3.medium",
#         "name": "skt-csl-documentdb-instance"
#         "count": 1
#     }
#     admin = {
#         "name": "skt_db_admin",
#         "password": "1q2w3e4r5t6y"
#     }

#     params = {
#         "name": "skt-csl-documentdb-params"
#     }

#     tags = {
#         "Name": "stk-csl-database-instance"
#         "Group":  "stk-csl-database"
#     }
# }