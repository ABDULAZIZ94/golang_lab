package main

import (
	"fmt"
	"time"

	pushnotifications "github.com/pusher/push-notifications-go"
)

const (
	// instanceID = "adb2017d-2ae7-4778-9839-cbf0303212c7"
	// secretKey  = "D7B8E8A6AE86C1F3A0A382CD4E243D80858493316C4B4E0CB22B23B2331E5E42"
	instanceID = "6b3e7227-f5ae-443b-8cda-2dd472df292d"
	secretKey  = "8F825B1865B1E2D66E881245E2EFAC977A8FCE544D7963331EE9D1ADEB196103"
)

var beamsClient pushnotifications.PushNotifications

func main() {
	fmt.Printf("Start\n")
	beamsClient, _ = pushnotifications.New(instanceID, secretKey)
	// j := map[string]interface{}{
	// 	"apns": map[string]interface{}{
	// 		"aps": map[string]interface{}{
	// 			"alert": map[string]interface{}{
	// 				"title": "Hello",
	// 				"body":  "Hello, world",
	// 			},
	// 		},
	// 	},
	// 	"fcm": map[string]interface{}{
	// 		"notification": map[string]interface{}{
	// 			"title": "Hello",
	// 			"body":  "Hello, world",
	// 		},
	// 	},
	// 	"web": map[string]interface{}{
	// 		"notification": map[string]interface{}{
	// 			"title": "Hello",
	// 			"body":  "Hello, world",
	// 		},
	// 	},
	// }
	// id, _ := beamsClient.PublishToInterests([]string{"debug-panic_alert"}, j)

	// fmt.Printf("publisher id: %v", id)

	PublishNotificationToInterest2(
		"debug-panic_alert",
		"panicbtn_status",
		time.Now().String()+": panic btn is activated",
		"dd",
		"panic",
		"",
		"",
		"pushed",
	)
}

func PublishNotificationToInterest2(interest string, title string, payload string, id string, notificationtype string, date_s string, time_s string, stat string) {
	publishRequest := map[string]interface{}{
		"apns": map[string]interface{}{
			"aps": map[string]interface{}{
				"alert": map[string]interface{}{
					"title": title,
					"body":  payload,
				},
			}, "data": map[string]interface{}{
				"id":     id,
				"type":   notificationtype,
				"date":   date_s,
				"time":   time_s,
				"status": stat,
			},
		},
		"fcm": map[string]interface{}{
			"notification": map[string]interface{}{
				"title": title,
				"body":  payload,
			}, "data": map[string]interface{}{
				"id":     id,
				"type":   notificationtype,
				"date":   date_s,
				"time":   time_s,
				"status": stat,
			},
		},
		"web": map[string]interface{}{
			"notification": map[string]interface{}{
				"title": title,
				"body":  payload,
			}, "data": map[string]interface{}{
				"id":     id,
				"type":   notificationtype,
				"date":   date_s,
				"time":   time_s,
				"status": stat,
			},
		},
	}

	pubId, err := beamsClient.PublishToInterests([]string{interest}, publishRequest)
	if err != nil {
		fmt.Println(err)
	} else {
		fmt.Println("Publish Id:", pubId)
	}
}
