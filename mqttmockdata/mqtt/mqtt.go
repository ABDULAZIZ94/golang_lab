package mqtt

import (
	"fmt"
	"log"
	"math/rand"
	"os"
	"strconv"
	"time"

	mqtt "github.com/eclipse/paho.mqtt.golang"
)

type (
	ClientStruct struct {
		mq1     mqtt.Client
		mq2     mqtt.Client
		servers []string
	}
)

var mqttBroker mqtt.Client

func NewMQTTClient(server string) *ClientStruct {

	uname := os.Getenv("MQ_UNAME")
	passwd := os.Getenv("MQ_PASSWD")

	// tls := NewTLSConfig()
	rand.Seed(time.Now().UnixNano())
	log.Println(server)
	log.Println(uname)
	log.Println(passwd)

	client1 := mqtt.NewClientOptions().AddBroker(server).
		SetClientID(fmt.Sprintf("vecto-%d", rand.Int())).
		SetUsername(uname).
		SetPassword(passwd).
		// SetTLSConfig(tls).
		// SetDefaultPublishHandler(MsgHandlerBrokerNBIOT).
		// SetDefaultPublishHandler(MsgHandlerBrokerHealth).
		SetCleanSession(false)

	a := mqtt.NewClient(client1)

	if token := a.Connect(); token.Wait() && token.Error() != nil {
		panic(token.Error())
	}

	mqttBroker = a

	return &ClientStruct{
		mq1: a,
	}
}

func GetMqttClient() mqtt.Client {
	return mqttBroker

}

// func MsgHandlerBrokerNBIOT(client mqtt.Client, msg mqtt.Message) {
// 	fmt.Printf("TOPIC NBIOT: %s\n", msg.Topic())
// 	payload := msg.Payload()
// 	ParseToiletData(payload, msg.Topic())

// }

// func MsgHandlerBrokerHealth(client mqtt.Client, msg mqtt.Message) {
// 	fmt.Printf("TOPIC HEALTH: %s\n", msg.Topic())
// 	payload := msg.Payload()
// 	ParseHealth(payload, msg.Topic())
// }

var mqttStatus bool

func CheckMqttConnection() {

	for {
		log.Println("Checking MQTT Connection")
		text := strconv.Itoa(int(time.Now().Unix()))
		token := GetMqttClient().Publish("vl/smarttoilet/health", 0, false, text)
		token.Wait()
		time.Sleep(5 * time.Second)
		if mqttStatus {
			log.Println("[CONNECTION WITH MQTT ONLINE, PROCEED WORKING]")
			// mqttStatus = false
		} else {
			log.Println("[LOSING CONNECTION WITH MQTT, RESTARTING SERVICES]")
			// log.Fatal()
		}
		// time.Sleep(time.Minute)
	}
}
