# !!!MAKE SURE YOUR GOPATH ENVIRONMENT VARIABLE IS SET FIRST!!!

# Variables
DIR=builds/
AGENT=agent
WINAGENTLDFLAGS=-ldflags "-H=windowsgui"
W=Windows-x64
L=Linux-x64
A=Linux-arm
M=Linux-mips
D=Darwin-x64

# Make Directory to store executables
$(shell mkdir -p ${DIR})

# Change default to just make for the host OS and add MAKE ALL to do this
default: agent-windows agent-linux agent-darwin

all: default

# Compile Windows binaries
windows: agent-windows

# Compile Linux binaries
linux: agent-linux

# Compile Arm binaries
arm: agent-arm

# Compile mips binaries
mips: agent-mips

# Compile Darwin binaries
darwin: agent-darwin

# Compile Agent - Windows x64
agent-windows:
	export GOOS=windows GOARCH=amd64;go build ${WINAGENTLDFLAGS} -o ${DIR}/${AGENT}-${W}.exe main.go

# Compile Agent - Linux mips
agent-mips:
	export GOOS=linux;export GOARCH=mips;go build -o ${DIR}/${AGENT}-${M} main.go

# Compile Agent - Linux arm
agent-arm:
	export GOOS=linux;export GOARCH=arm;export GOARM=7;go build -o ${DIR}/${AGENT}-${A} main.go

# Compile Agent - Linux x64
agent-linux:
	export GOOS=linux;export GOARCH=amd64;go build -o ${DIR}/${AGENT}-${L} main.go

# Compile Agent - Darwin x64
agent-darwin:
	export GOOS=darwin;export GOARCH=amd64;go build -o ${DIR}/${AGENT}-${D} main.go

clean:
	rm -rf ${DIR}*

