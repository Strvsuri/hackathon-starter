variable "instance-ami" {
  description = "The AMI (Amazon Machine Image) that identifies the instance"
  type        = string
  default     = "ami-0aa2b7722dc1b5612"
}

variable "instance-type" {
  description = "The instance type to be used"
  type        = string
  default     = "t2.medium"
}

variable "instance-key-name" {
  description = "The name of the SSH key to associate to the instance. Note that the key must exist already."
  type        = string
  default     = "ansible-master"
}

variable "instance-tag-name" {
  description = "instance-tag-name"
  type        = string
  default     = "EC2-instance-created-with-terraform"
}
 
variable "subnet-cidr-block" {
  description = "The CIDR block to associate to the subnet"
  type        = string
  default     = "172.31.100.0/24"
}

variable "vpc-tag-name" {
  description = "The Name to apply to the VPC"
  type        = string
  default     = "VPC-created-with-terraform"
}

variable "ig-tag-name" {
  description = "The name to apply to the Internet gateway tag"
  type        = string
  default     = "aws-ig-created-with-terraform"
}

variable "subnet-tag-name" {
  description = "The Name to apply to the subnet"
  type        = string
  default     = "subnet-created-with-terraform"
}

variable "sg-tag-name" {
  description = "The Name to apply to the security group"
  type        = string
  default     = "SG-created-with-terraform"
}
