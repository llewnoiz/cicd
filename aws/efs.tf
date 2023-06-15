resource "aws_efs_file_system" "worker_efs" {
  creation_token = "worker-efs"
  encrypted = true
  tags = {
    Name = "worker-efs"
  }
}

resource "aws_efs_backup_policy" "policy" {
  file_system_id = aws_efs_file_system.worker_efs.id

  backup_policy {
    status = "ENABLED"
  }
}

resource "aws_efs_access_point" "worker_efs" {
  file_system_id = aws_efs_file_system.worker_efs.id
  root_directory  {
    path = "/usr/src/app/provision"
  }

  tags = {
    Name = "worker-efs"
  }
}

resource "aws_efs_mount_target" "back_2a" {
  file_system_id = aws_efs_file_system.worker_efs.id
  subnet_id      = aws_subnet.back_2a.id
  security_groups = ["${aws_security_group.service_worker.id}"]
}

resource "aws_efs_mount_target" "back_2c" {
  file_system_id = aws_efs_file_system.worker_efs.id
  subnet_id      = aws_subnet.back_2c.id
  security_groups = ["${aws_security_group.service_worker.id}"]
}