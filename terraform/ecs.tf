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
  requires_compatibilities = ["FARGATE"] 
  network_mode             = "awsvpc"    
  memory                   = 512         
  cpu                      = 256         
  execution_role_arn       = "arn:aws:iam::417834101719:role/ecsTaskExecutionRole"
}