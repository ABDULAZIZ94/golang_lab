package pusher

import (
	"fmt"

	pushnotifications "github.com/pusher/push-notifications-go"
)

const (
	instanceID = "12112-21312312-12sdsafda-2132ewd"
	secretKey  = "123edsw2erfdwerf7ufjfcfdc"
)

func main() {
	fmt.Printf("Start\n")
	beamsClient, _ := pushnotifications.New(instanceID, secretKey)
}
