#cloud-config

runcmd:
 - [ screen, -m, -d, watch, curl, --connect-timeout, 5, ${curl_destination} ]
