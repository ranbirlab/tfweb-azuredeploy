variable "input_data_format" {
  type    = string
  default = "json"

  # using contains()
  validation {
    condition     = contains(["json", "yaml"], lower(var.input_data_format))
    error_message = "Invalid input for input_data_format, options: \"json\", \"yaml\"."
  }
}

/*variable "input_dir_path" {
  type        = string
  default ="${path.root}/data"
}*/