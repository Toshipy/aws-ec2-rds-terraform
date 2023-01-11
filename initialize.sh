#!/bin/sh
git secrets --register-aws --global
git secrets --install ~/.git-templates/git-secrets -f
git config --global init.templatedir ~/.git-templates/git-secrets
