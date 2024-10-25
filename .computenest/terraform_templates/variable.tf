variable "instance_charge_type" {
  type    = string
  default = "PostPaid"
  description = <<EOT
  {
    "AssociationProperty": "ChargeType",
    "AssociationPropertyMetadata": {
      "LocaleKey": "InstanceChargeType"
    },
    "Label": {
      "zh-cn": "付费类型",
      "en": "ECS Instance Billing Method"
    },
    "AllowedValues": [
      "PostPaid",
      "PrePaid"
    ]
  }
  EOT
}

variable "period" {
  type  = number
  default = 1
  description = <<EOT
  {
    "AssociationProperty": "PayPeriod",
    "AssociationPropertyMetadata": {
      "Visible": {
        "Condition": {
          "Fn::Not": {
            "Fn::Equals": [
              "$${instance_charge_type}",
              "PostPaid"
            ]
          }
        }
      }
    },
    "Label": {
      "zh-cn": "购买资源时长",
      "en": "Purchase Duration"
    },
    "AllowedValues": [
      1,
      2,
      3,
      4,
      5,
      6,
      7,
      8,
      9
    ]
  }
  EOT
}

variable "period_unit" {
  type    = string
  default = "Month"
  description = <<EOT
  {
    "AssociationProperty": "PayPeriodUnit",
    "AssociationPropertyMetadata": {
      "Visible": {
        "Condition": {
          "Fn::Not": {
            "Fn::Equals": [
              "$${instance_charge_type}",
              "PostPaid"
            ]
          }
        }
      }
    },
    "AllowedValues": [
      "Month"
    ],
    "Label": {
      "zh-cn": "购买资源时长周期",
      "en": "Pay Period Unit"
    }
  }
  EOT
}

variable "zone_id" {
  type        = string
  description = <<EOT
  {
    "AssociationProperty": "ALIYUN::ECS::Instance::ZoneId",
    "Label": {
      "en": "The ZoneId used to launch service",
      "zh-cn": "可用区"
    }
  }
  EOT
}

variable "vpc_id" {
  type    = string
  default = null
  description = <<EOT
  {
    "AssociationProperty": "ALIYUN::ECS::VPC::VPCId",
    "Label": {
      "en": "Existing VPC Instance ID",
      "zh-cn": "专有网络VPC实例ID"
    }
  }
  EOT
}

variable "vswitch_id" {
  type    = string
  default = null
  description = <<EOT
  {
    "AssociationProperty": "ALIYUN::ECS::VSwitch::VSwitchId",
    "AssociationPropertyMetadata": {
        "VpcId": "$${vpc_id}",
        "ZoneId": "$${zone_id}"
    },
    "Label": {
      "en": "VSwitch ID",
      "zh-cn": "交换机实例ID"
    }
  }
  EOT
}

variable "instance_type"{
  type        = string
  description = <<EOT
  {
    "AssociationProperty": "ALIYUN::ECS::Instance::InstanceType",
    "AssociationPropertyMetadata": {
      "InstanceChargeType": "$${instance_charge_type}",
      "Constraints": {
        "InstanceTypeFamily": [
          "ecs.u1",
          "ecs.e"
        ]
      }
    },
    "Label": {
      "en": "The instance tye of ECS instance",
      "zh-cn": "实例规格"
    }
  }
  EOT
}

variable "password"{
  type        = string
  sensitive   = true
  description = <<EOT
  {
    "Label":{
       "en": "Instance Password",
       "zh-cn": "实例密码"
     },
    "Description": {
        "en": "Server login password, Length 8-30, must contain three(Capital letters, lowercase letters, numbers, ()`~!@#$%^&*_-+=|{}[]:;'<>,.?/ Special symbol in).",
        "zh-cn": "服务器登录密码,长度8-30，必须包含三项（大写字母、小写字母、数字、 ()`~!@#$%^&*_-+=|{}[]:;'<>,.?/ 中的特殊符号）。"
     },
    "NoEcho": true,
    "AssociationProperty": "ALIYUN::ECS::Instance::Password",
    "ConstraintDescription": {
      "en": "8-32 characters, can contain size letters, Numbers and special symbols, including:! @ # $ % ^ & * ( ) _ + - =",
      "zh-cn": "8-32个字符,可包含大小字母、数字及特殊符号（包含：!@#$%^&*()_+-=）"
    },
    "MinLength": 8,
    "MaxLength": 32
  }
  EOT
}

