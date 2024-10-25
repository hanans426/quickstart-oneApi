output "server_address" {
  description = <<EOT
      {
        "Label": "访问地址",
        "Description": "页面访问地址."
      }
      EOT
  value  = format("http://%s:3000", alicloud_instance.instance.public_ip)
}
