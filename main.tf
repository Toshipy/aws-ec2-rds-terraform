provider "aws" {
  profile = "arai_toshiaki"
  region = "ap-northeast-1"

    default_tags {
    tags = {
      aws-exam-resource = "true"
    }
  }

  # assume_roleブロックを追加
  assume_role {  
    role_arn = "arn:aws:iam::170775015612:role/EngineedExam00374"
  }
}

resource "aws_instance" "hello-world" {
  ami = "ami-01e94099fb3acf7fa"
  instance_type = "t2.micro"
}
