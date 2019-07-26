#!/usr/bin/env bash
echo ECS_CLUSTER=${cluster_name} >> /etc/ecs/ecs.config
sudo service docker start
sudo start ecs
echo "######### DONE WITH USERDATA ############"
