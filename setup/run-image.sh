: '
Variable definitions:

    org:
        Name of the Apigee org you want your proxy to be deployed in. Used by
        maven during proxy deployment.
    username
        Username of the user to be used for proxy deployment. Used by maven
        during proxy deployment.
    password
        Password of the user to be used for proxy deployment. Used by maven
        during proxy deployment.
'

docker run -d -p 9001:8080 \
	-e org=. \
	-e username=. \
	-e password=. \
--name my-ci apigee/ci
