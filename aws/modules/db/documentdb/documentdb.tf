
#DOCUMENT DB

# 클러스터 옵션
# 클러스터 파라미터 그룹
resource "aws_docdb_cluster_parameter_group" "docdb_parameter_group" {
  family      = "docdb4.0"
  name        = var.db.params.name
  description = "documentdb cluster parameter group"

  parameter {
    name  = "tls"
    value = "disabled"
  }
}
data "aws_vpc" "selected" {
  id = var.db.vpcId
}

resource "aws_docdb_subnet_group" "default" {
  name       = "default_subnet_group"
  subnet_ids = var.db.subnetIds
  description = "documentdb subnet group"
  tags = var.db.tags

}

resource "aws_docdb_cluster" "docdb" {
  #클러스터 식별자
  cluster_identifier      = var.db.cluster
  # 엔진
  engine                  = "docdb"
  # 엔진 버전
  engine_version          = "4.0.0"
  #마스터 사용자 이름
  master_username         = var.db.admin.name
  # 마스터 암호
  master_password         = var.db.admin.password
  # 클러스터 옵션
  # 클러스터 파라미터 그룹
  db_cluster_parameter_group_name = aws_docdb_cluster_parameter_group.docdb_parameter_group.name
  backup_retention_period = 1
#   preferred_backup_window = "07:00-09:00"
  skip_final_snapshot     = true
  # final_snapshot_identifier

  # 기본 서브넷 그룹 설정
  db_subnet_group_name = aws_docdb_subnet_group.default.name
  # 보안 그룹 설정
  vpc_security_group_ids = var.db.securityGroupId

  tags = var.db.tags
}

resource "aws_docdb_cluster_instance" "docdb_cluster_instances" {
  # 인스턴스 개수 1
  count              = var.db.instance.count
  identifier         = "${var.db.instance.name}-${count.index}"
  cluster_identifier = aws_docdb_cluster.docdb.id
  # 인스턴스 클래스
  # db.t3.medium
  instance_class     = var.db.instance.class

  tags = var.db.tags
}



