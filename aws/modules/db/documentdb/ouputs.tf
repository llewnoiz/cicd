output "docdb_parameter_group" {
  description = "docdb_parameter_group"
  value = {
        "name" : "${aws_docdb_cluster_parameter_group.docdb_parameter_group.name}",
        "param": "${aws_docdb_cluster_parameter_group.docdb_parameter_group.parameter}"
    }
}

output "docdb_cluster" {
  description = "docdb_cluster"
  value = {
        "name" : "${aws_docdb_cluster.docdb.cluster_identifier}",
        "engine" : "${aws_docdb_cluster.docdb.engine}",
        "version" : "${aws_docdb_cluster.docdb.engine_version}",
        "user" : "${aws_docdb_cluster.docdb.master_username}",
        "password" : "${aws_docdb_cluster.docdb.master_password}",
        "endpoint": "${aws_docdb_cluster.docdb.endpoint}"
        "arn": "${aws_docdb_cluster.docdb.arn}",
        "instance" : [
          for instance in aws_docdb_cluster_instance.docdb_cluster_instances: {
            "name": instance.identifier,
            "port": instance.port,
            "arn": instance.arn,
            "endpoint": instance.endpoint,
            "subnetgroup": instance.db_subnet_group_name
          }
        ]        
    }
  sensitive   = true
}



