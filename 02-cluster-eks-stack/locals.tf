locals {
  eks_private_subnet_ids = [
    aws_subnet.private_a.id,
    aws_subnet.private_b.id,
  ]
}
