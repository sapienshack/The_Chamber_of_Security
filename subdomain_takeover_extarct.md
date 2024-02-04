## steps to extract potaintial URL ##

1. Go to the gowitness screenshot directory
2. Keep all the URLs which have 404 html messgae.
3. Follow below command

   ```ls >  possible_subdomain_takeover.txt```
   
   ```sed 's/http-|https-/https:\/\//' ./possible_subdomain_takeover.txt | awk -F'.png' '{print $1}' > filtred_subdomain_takeover.txt```
