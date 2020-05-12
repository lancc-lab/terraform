provider "aws" {
 region = "eu-north-1"
}

resource "aws_instance" "terraform_example" {
 ami = "ami-050981837962d44ac"
 instance_type = "t3.micro"
 key_name = "my-key1"
 security_groups = ["my"]

# Copies the file as the root user using SSH

 provisioner "file"{
   source      = "index.html"
   destination = "~/index.html"
 }
connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = "${file("~/.ssh/my-key1.pem")}"
  }


 provisioner "remote-exec" {
    inline = [
         "sudo apt update && sudo apt install -y nginx",
         "sudo cp ~/index.html /var/www/html/index.html", 
    ]
 }
}

