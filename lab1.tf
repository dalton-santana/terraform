provider "aws" {
    access_key = ""
    secret_key = ""
    region = "us-east-2"
}


resource "aws_instance" "instance1" {
    ami = "ami-09558250a3419e7d0"
    instance_type = "t2.micro"
}

resource "aws_instance" "instance2" {
    ami = "ami-09558250a3419e7d0"
    instance_type = "t2.micro"
}   

resource "aws_security_group" "allow_http" {
    name = "allow-http"
    description = "Allow http inbound traffic"

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_instance" "instance3" {
    ami = "ami-09558250a3419e7d0"
    instance_type = "t2.micro"
    user_data = file("user_data.sh")
    vpc_security_group_ids = [aws_security_group.allow_http.id]
}   
