#cloud-config

runcmd:
 - [ screen, -m, -d, watch, curl, ${curl_destination} ]