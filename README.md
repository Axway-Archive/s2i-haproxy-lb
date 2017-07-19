# s2i-haproxy-lb
S2I Build for injecting haproxy.cfg files

Instructions for building the image stream within OSE
1. Make the build (make build)
2. Run the s2i build command for the test instance (s2i build test/test-app/ haproxy-lb haproxy-lb-sample-app)
3. Login to the Docker registry of OSE (docker login -u `oc whoami` -p `oc whoami -t` https://docker-registry-default.apps.demoaxway.com/)
4. Push the image to internal registry (docker push docker-registry-default.apps.demoaxway.com/stec/haproxy-lb)
5. Create the image stream available under oc-files (oc create -f haproxy-lb-is.json)
6. Add the image stream to the project using the console or cmd-line (use the sample configuration provided in the git url)
