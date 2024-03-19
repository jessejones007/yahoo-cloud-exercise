variable "bucket_name" {
  description = "The name of the bucket."
  type        = string
}

variable "kms_key_id" {
  description = "The AWS KMS key ID to use for object encryption."
  type        = string
}
