resource "aws_ecs_cluster" "tf_ecs_cluster" {
  name = "tf_ecs_cluster"
}

resource "aws_ecs_task_definition" "tf_ecs_task" {
  family                   = "tf-ecs-task"
  container_definitions    = <<DEFINITION
  [
    {
      "name": "tf-ecs-task",
      "image": "417834101719.dkr.ecr.eu-central-1.amazonaws.com/weather_repo:latest",
      "essential": true,
      "portMappings": [
        {
          "containerPort": 8080,
          "hostPort": 8080
        }
      ],
      "memory": 512,
      "cpu": 256
    }
  ]
  DEFINITION
  requires_compatibilities = ["FARGATE"] # Stating that we are using ECS Fargate
  network_mode             = "awsvpc"    # Using awsvpc as our network mode as this is required for Fargate
  memory                   = 512         # Specifying the memory our container requires
  cpu                      = 256         # Specifying the CPU our container requires
  execution_role_arn       = "${aws_iam_role.ecsTaskExecutionRole.arn}"
}