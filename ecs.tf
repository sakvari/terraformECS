resource "aws_ecs_service" "viva" {

      name = "vivaecs"
      cluster = "${aws_ecs_cluster.vivacluster.id}"
      task_definition = "${aws_ecs_task_definition.viva.arn}"
      desired_count = 4
      iam_role = "${aws_iam_role.vivacluster.arn}"
      depends_on = ["aws_iam_role_policy.vivacluster"]

      ordered_placement_strategy {
      type  = "binpack"
      field = "cpu"
      }

      load_balancer {
        target_group_arn = "${aws_lb_target_group.vivacluster.arn}"
        container_name   = "viva"
        container_port   = 3002
      }

      placement_constraints {
        type       = "memberOf"
        expression = "attribute:ecs.availability-zone in [us-west-2a]"
      }

}
