# ---------------------------------------------------------------------------------------------------------------------
# TERRAGRUNT CONFIGURATION
# This is the configuration for Terragrunt, a thin wrapper for Terraform that supports locking and enforces best
# practices: https://github.com/gruntwork-io/terragrunt
# ---------------------------------------------------------------------------------------------------------------------

project_id = ""

region = ""

zone = ""


# Add your list of global public ssh keys.  Theys keys will be made available to 
# all instances, project-wide that allow them.
# Required format:
# <protocol> <key-blob> <username@example.com> 
# or:
# <protocol> <key-blob> google-ssh {"userName":"<username@example.com>","expireOn":"<date>"
ssh_pub_keys = <<EOF
glerma:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDicE1GDZRPTV/PsWnRwenN+rftRJrh+iqGi1XK2T/ZJ3xj4Un4ZJN9rsUcqL7bNVyQlx8X5z9OgDT7+UNXndNOEnyGtKO6Vrw8Qocg5qN1Yd2GkOc8dw347ogc4bzKrAm28fNBHwmlofmzypXORM02hVJ/HMrMEnt8KQoELocZzLqagl3H6kHJXZ1xgfsMmAas5LcJsSn1pukcQG6lTBfkSHLvEjXbW5RdV10XQ7vwHv6yyNby6dm72cgtd6XQLkfx6GOozStYPOVd1evdITWq5g4413cZiZW3dvMj2SBsYCmQzgMm4GyAO0TQWf47QfWu9qE+YSF8vrkUeYJndEKx george.lerma@sadasystems.com
EOF
