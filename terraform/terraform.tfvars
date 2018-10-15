project_name = "queueing-system"
environment_name = "dev"

ecs_instance_type = "t2.micro"

ecs_asg_max_size = "1"
ecs_asg_min_size = "1"
# how many EC2 intances run at the same time
ecs_asg_desired_capacity = "1"

# how many containes run at the same time
ecs_task_desired_count = "1"

# https://docs.aws.amazon.com/AmazonECS/latest/developerguide/memory-management.html
ecs_task_memory = "512"

docker_build_image = 1
