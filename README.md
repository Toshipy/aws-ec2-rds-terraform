# 構築したアーキテクチャ

![Architecture](https://user-images.githubusercontent.com/44152472/212810588-61861b86-91c7-41c1-8bfe-8b5fb0e13e34.png)


# IaC
- Terraform

#　使用したAWSサービス

- Route53
- CloudFront (ALB/S3にパスパターンでルーティング)
- ALB (パスパターンによるターゲットグループへのトラフィック分散)
- S3 (静的コンテンツ)
- EC2 (AutoScaling)
- RDS（Aurora MySQL）
- WAF (CloudFrontにアタッチ)
- ACM（SSL証明書）
