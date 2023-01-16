#!/bin/sh
# git secrets --register-aws --global
# git secrets --install ~/.git-templates/git-secrets -f
# git config --global init.templatedir ~/.git-templates/git-secrets

Content-Type: multipart/mixed; boundary="//"
MIME-Version: 1.0
 
--//
Content-Type: text/cloud-config; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="cloud-config.txt"
 
#cloud-config
cloud_final_modules:
- [scripts-user, always]
 
--//
Content-Type: text/x-shellscript; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="userdata.txt"
 
#!/bin/bash


# ex.
# /home/ec2-user/initialize.sh xxx.ap-northeast-1.rds.amazonaws.com admin password 00001
/home/ec2-user/initialize.sh tf-20230115043219651900000001.cv1tid5b4chc.ap-northeast-1.rds.amazonaws.com admin engineed00001 00374
--//
