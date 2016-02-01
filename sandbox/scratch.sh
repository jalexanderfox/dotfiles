
old_proxy_host="$(docker-machine ssh office "grep http_proxy /var/lib/boot2docker/profile" | awk -F \" '{print $2}' | awk -F \/ '{print $3}' | awk -F : '{print $1}')"
new_ip_address=$(ifconfig en0 | grep inet\ | awk '{print $2}')
# docker-machine ssh dev "sudo sed -i \"s/${old_proxy_host}/${new_ip_address}/\" /var/lib/boot2docker/profile"
# echo "sudo sed -i \"s/${old_proxy_host}/${new_ip_address}/\" /var/lib/boot2docker/profile"

echo $old_proxy_host
#
# old_no_proxy="$(docker-machine ssh office "grep no_proxy /var/lib/boot2docker/profile" | awk -F \" '{print $2}' | awk -F \/ '{print $3}')"
# echo $old_no_proxy


old_proxy_host="$(docker-machine ssh dev "grep http_proxy /var/lib/boot2docker/profile"  | awk -F \" '{print $2}' | awk -F \/ '{print $3}' | awk -F : '{print $1}')"
new_ip_address=$(ifconfig en0 | grep inet\  | awk '{print $2}')
docker-machine ssh dev "sudo sed -i \"s/${old_proxy_host}/${new_ip_address}/\" /var/lib/boot2docker/profile"
