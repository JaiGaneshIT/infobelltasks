#!/bin/bash

# Log file path
log_file="/home/infobell/jai/dockerstats.log"

echo "----------------------- $(date) -----------------------" >> "$log_file"
echo "HOSTNAME:$(hostname)" >> "$log_file"
# Get CPU usage
cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print $2}' | awk -F. '{print $1}')

# Get Disk usage
disk_usage=$(df -h / | awk 'NR==2 {print $5}')

# Get Memory usage
memory_usage=$(free -m | awk 'NR==2 {printf "%.2f%%", $3/$2*100}')

# Print the collected information
echo "CPU Usage: ${cpu_usage}%" >> "$log_file"
echo "Disk Usage: ${disk_usage}" >> "$log_file"
echo "Memory Usage: ${memory_usage}" >> "$log_file"



# You can modify this script to save the information to a file or use it in other ways.

# Get Docker container information
container_ids=$(docker ps -q)

echo "Container Information:" >> "$log_file"
for container_id in $container_ids; do
    container_name=$(docker inspect -f '{{.Name}}' $container_id)

    # Get Disk usage for the container
    disk_usage=$(docker exec $container_id df -h | awk 'NR==2 {print $5}')

    # Get Memory usage for the container
    memory_usage=$(docker stats --no-stream --format "{{.MemUsage}}" $container_id)

    # Get Size of the image for the container
    image_size=$(docker images --format "{{.Size}}" $(docker inspect --format='{{.Config.Image}}' $container_id))

    # Print container information
    echo "Container Name: $container_name" >> "$log_file"
    echo "Disk Usage: $disk_usage" >> "$log_file"
    echo "Memory Usage: $memory_usage" >> "$log_file"
    echo "Image Size: $image_size" >> "$log_file"
    echo "-----------------------------------------" >> "$log_file"
done
