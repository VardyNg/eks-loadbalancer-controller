resource "target_group_binding" "example" {
  metadata {
    name = "example"
  }

  # https://kubernetes-sigs.github.io/aws-load-balancer-controller/v2.12/guide/targetgroupbinding/spec/#elbv2.k8s.aws/v1beta1.TargetGroupBindingSpec
  spec {
    # https://kubernetes-sigs.github.io/aws-load-balancer-controller/v2.12/guide/targetgroupbinding/targetgroupbinding/#targettype
    # Optional, "ip" or "instance", determined by the target group
    target_type       = "ip"

    # https://kubernetes-sigs.github.io/aws-load-balancer-controller/v2.12/guide/targetgroupbinding/targetgroupbinding/#choosing-the-target-group
    # if both target_group_arn and target_group_name are set, target_group_arn will be used
    target_group_arn  = "arn:aws:elasticloadbalancing:us-west-2:123456789012:targetgroup/example/1234567890abcdef"
    target_group_nane = "example"

    # https://kubernetes-sigs.github.io/aws-load-balancer-controller/v2.12/guide/targetgroupbinding/targetgroupbinding/#vpcid
    # Optional, determined by the target group
    vpc_id            = "vpc-12345678"

    # https://kubernetes-sigs.github.io/aws-load-balancer-controller/v2.12/guide/targetgroupbinding/targetgroupbinding/#nodeselector
    # if target_type is "instance", there will be default nodeSelector statements
    # Optional, will merge with default nodeSelector statements (if any)
    nodeSelector {}

    # https://kubernetes-sigs.github.io/aws-load-balancer-controller/v2.12/guide/targetgroupbinding/targetgroupbinding/#assumerole
    iam_role_arn_to_assume = "arn:aws:iam::123456789012:role/role-name"
    assume_role_external_id = "external-id" # optional

    # https://kubernetes-sigs.github.io/aws-load-balancer-controller/v2.12/guide/targetgroupbinding/targetgroupbinding/#multicluster-target-group
    # Optional
    multi_cluster_target_group = false 
    service_ref {
      name = "example-service"
      port = 80
    }

    # https://kubernetes-sigs.github.io/aws-load-balancer-controller/v2.12/guide/targetgroupbinding/spec/#elbv2.k8s.aws/v1beta1.TargetGroupBindingNetworking
    networking {
      # https://kubernetes-sigs.github.io/aws-load-balancer-controller/v2.12/guide/targetgroupbinding/spec/#elbv2.k8s.aws/v1beta1.NetworkingIngressRule
      ingress = [
        {
          # https://kubernetes-sigs.github.io/aws-load-balancer-controller/v2.12/guide/targetgroupbinding/spec/#elbv2.k8s.aws/v1beta1.NetworkingIngressRule:~:text=from-,%5B%5DNetworkingPeer,-List%20of%20peers
          from = [
            {
              # https://kubernetes-sigs.github.io/aws-load-balancer-controller/v2.12/guide/targetgroupbinding/spec/#elbv2.k8s.aws/v1beta1.NetworkingPeer:~:text=securityGroup-,SecurityGroup,-(Optional)
              security_group = {
                group_id = "sg-12345678"
              }
              # https://kubernetes-sigs.github.io/aws-load-balancer-controller/v2.12/guide/targetgroupbinding/spec/#elbv2.k8s.aws/v1beta1.NetworkingPeer:~:text=ipBlock-,IPBlock,-(Optional)
              ip_block = {
                cidr = "192.168.0.0/16"
              }
            }
          ]
          # https://kubernetes-sigs.github.io/aws-load-balancer-controller/v2.12/guide/targetgroupbinding/spec/#elbv2.k8s.aws/v1beta1.NetworkingIngressRule:~:text=ports-,%5B%5DNetworkingPort,-List%20of%20ports
          ports = [
            {
              port      = 80
              protocol  = "TCP"
            }
          ]
        }
      ]
    }
  }
}
