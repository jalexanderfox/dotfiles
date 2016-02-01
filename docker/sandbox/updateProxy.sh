active=$(docker-machine active)
echo $active ' <= docker-machine active'
proxy_host="$(docker-machine ssh ${active} "grep http_proxy /var/lib/boot2docker/profile"  | awk -F \" '{print $2}' | awk -F \/ '{print $3}' | awk -F : '{print $1}')"
echo $proxy_host ' <= proxy host'

new_ip_address=$(ifconfig en0 | grep inet\ | awk '{print $2}')
# docker-machine ssh office "sudo sed -i \"s/${proxy_host}/${new_ip_address}/\" /var/lib/boot2docker/profile"

docker-machine ssh $active "sudo sed -i \"s/${proxy_host}/${new_ip_address}/\" /var/lib/boot2docker/profile"
# docker-machine ssh ${active_docker_machine} "sudo sed -i \"s/${old_proxy_host}/${new_ip_address}/\" /var/lib/boot2docker/profile"
