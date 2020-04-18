# Simple C2 Implant

You may need to set up the "shellwords" dependency first for this to compile correctly `go get github.com/mattn/go-shellwords`

To compile the binaries simply make sure your gopath is configured and simply run `make` (this will make all the binaries for all supported platforms) or `make target-os`

BEFORE you compile set you C2 endpoint URL in the 3 URL locations in the implant code.

Challenge: Abstract that so you only have to modify the URL once or even parameterize it as part of the Makefile :)