# Instructions

1. Configure HTTP/HTTPS parameter correctly in the URL string based on what connection type you have.
2. Run `make` to build the binaries
3. Run `sls deploy --server (your public ip/domain here)`


If your build is giving you a hard time make sure you have the AWS lambda packages installed `go get -u github.com/aws/aws-lambda-go/lambda`