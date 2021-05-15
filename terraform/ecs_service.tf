resource "aws_ecs_service" "tf-ecs-service" {
  name            = "tf-ecs-service"                            
  cluster         = "${aws_ecs_cluster.tf_ecs_cluster.id}"            
  task_definition = "${aws_ecs_task_definition.tf_ecs_task.arn}"
  launch_type     = "FARGATE"
  desired_count   = 1

  network_configuration {
    subnets          = ["${aws_default_subnet.default_subnet_a.id}", "${aws_default_subnet.default_subnet_b.id}", "${aws_default_subnet.default_subnet_c.id}"]
    assign_public_ip = true
  }
}