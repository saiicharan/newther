resource "aws_ecs_service" "tf-ecs-service" {
  name            = "tf-ecs-service"                            
  cluster         = "${aws_ecs_cluster.tf_ecs_cluster.id}"            
  task_definition = "${aws_ecs_task_definition.tf_ecs_task.arn}"
  launch_type     = "FARGATE"
  desired_count   = 1

  load_balancer {
    target_group_arn = "${aws_lb_target_group.target_group.arn}"
    container_name   = "${aws_ecs_task_definition.tf_ecs_task.family}"
    container_port   = 8080
  }
  network_configuration {
    subnets          = ["${aws_default_subnet.default_subnet_a.id}", "${aws_default_subnet.default_subnet_b.id}", "${aws_default_subnet.default_subnet_c.id}"]
    assign_public_ip = true
  }
}

resource "aws_security_group" "service_security_group" {
  ingress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    security_groups = ["${aws_security_group.load_balancer_security_group.id}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}