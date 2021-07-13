resource "aws_efs_file_system" "efs" {
  creation_token = "efs-token"

  tags = {
    Name = "EKS"
  }
}

resource "aws_efs_mount_target" "subnet1" {
  count = length(var.subnet_ids)
  file_system_id  = aws_efs_file_system.efs.id
  subnet_id       = element(var.subnet_ids, count.index)
  security_groups = var.security_group
}


resource "aws_efs_access_point" "efs_ap" {
  file_system_id = aws_efs_file_system.efs.id

}