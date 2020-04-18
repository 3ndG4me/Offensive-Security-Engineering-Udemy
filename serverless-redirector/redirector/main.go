package main

import (
	//"fmt"
	"log"
    "net/http"
	"io/ioutil"
	"os"
	"github.com/aws/aws-lambda-go/events"
	"github.com/aws/aws-lambda-go/lambda"
)

// Handler function Using AWS Lambda Proxy Request
func Handler(request events.APIGatewayProxyRequest) (events.APIGatewayProxyResponse, error) {


	server := os.Getenv("SERVER")

	//Get the path parameter that was sent
	path := request.Path

	url := "http://" + server + path
	resp, err := http.Get(url)
    if err != nil {
		log.Fatalln(err)
    }

	body, err := ioutil.ReadAll(resp.Body)

    if err != nil {
		log.Fatalln(err)
    }


	//Generate message that want to be sent as body
	//message := fmt.Sprintf(" { \"Message\" : \"Hello %s \" } ", url)

	//Returning response with AWS Lambda Proxy Response
	return events.APIGatewayProxyResponse{Body: string(body), StatusCode: 200}, nil
}

func main() {
	lambda.Start(Handler)
}