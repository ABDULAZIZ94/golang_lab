package main

import (
	"fmt"

	pushnotifications "github.com/pusher/push-notifications-go"
)

const (
	instanceId = "adb2017d-2ae7-4778-9839-cbf0303212c7"
	secretKey  = "D7B8E8A6AE86C1F3A0A382CD4E243D80858493316C4B4E0CB22B23B2331E5E42"
)

func main() {
	beamsClient, _ := pushnotifications.New(instanceId, secretKey)

	publishRequest := map[string]interface{}{
		"apns": map[string]interface{}{
			"aps": map[string]interface{}{
				"alert": map[string]interface{}{
					"title": "Hello",
					"body":  "Hello, world",
				},
			},
		},
		"fcm": map[string]interface{}{
			"notification": map[string]interface{}{
				"title": "Hello",
				"body":  "Hello, world",
			},
		},
	}

	pubId, err := beamsClient.PublishToInterests([]string{"hello"}, publishRequest)
	if err != nil {
		fmt.Println(err)
	} else {
		fmt.Println("Publish Id:", pubId)
	}
}
