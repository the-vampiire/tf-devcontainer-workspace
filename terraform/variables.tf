// reads from TF_VAR set in .devcontainer/workspace.env
variable "aws_profile" {
  type = string
  description = "AWS profile to use"
  default = "tf"
}

variable "aws_region" {
  type = string
  description = "AWS region to use"
  default = "us-east-1"
}
// --- 
