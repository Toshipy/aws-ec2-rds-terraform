provider "aws" {
  profile = "arai_toshiaki"
  region  = "ap-northeast-1"

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

provider "aws" {
  alias   = "virginia"
  profile = "arai_toshiaki"
  region  = "us-east-1"

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
