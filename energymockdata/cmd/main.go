package main

import (
	"encoding/json"
	"fmt"
	"log"
	"math/rand"
	"mqttmockdata/mqtt"
	"os"
	"time"

	"github.com/joho/godotenv"
)

type (
	Datapayload struct {
		Namespace     string
		Color         string
		Current       float32
		ActivePower   float32
		ReactivePower float32
		ApparentPower float32
		Frequency     float32
		PowerFactor   float32
		PhaseAngle    float32
		VTHD          float32
		ATHD          float32
		Timestamp     int64 `json:"timestamp"`
	}
	KeepAlive struct {
		Namespace string
		Timestamp int64 `json:"timestamp"`
	}
)

func main() {
	fmt.Println("mock mqqt data generators")
	//read env from files instead windows env (applicable for dev only)
	if err := godotenv.Load(".env.staging"); err != nil {
		log.Print("No .env file found")
	}

	mqtt.NewMQTTClient(os.Getenv("MQ_HOST2"))

	for {
		mqtt.GetMqttClient().Publish("vl/em-staging/e6daf318-6516-4350-6b56-ae0a44b7e5d7/m01/notify",
			0, false, generatePayloadData("RED"))
		mqtt.GetMqttClient().Publish("vl/em-staging/e6daf318-6516-4350-6b56-ae0a44b7e5d7/m01/notify",
			0, false, generatePayloadData("YELLOW"))
		mqtt.GetMqttClient().Publish("vl/em-staging/e6daf318-6516-4350-6b56-ae0a44b7e5d7/m01/notify",
			0, false, generatePayloadData("BLUE"))
		mqtt.GetMqttClient().Publish("vl/em-staging/health/m01",
			0, false, generateHealthData("m01"))
		time.Sleep(15 * time.Second)
		mqtt.GetMqttClient().Publish("vl/em-staging/e6daf318-6516-4350-6b56-ae0a44b7e5d7/m02/notify",
			0, false, generatePayloadData("RED"))
		mqtt.GetMqttClient().Publish("vl/em-staging/e6daf318-6516-4350-6b56-ae0a44b7e5d7/m02/notify",
			0, false, generatePayloadData("YELLOW"))
		mqtt.GetMqttClient().Publish("vl/em-staging/e6daf318-6516-4350-6b56-ae0a44b7e5d7/m02/notify",
			0, false, generatePayloadData("BLUE"))
		mqtt.GetMqttClient().Publish("vl/em-staging/health/m02",
			0, false, generateHealthData("m02"))
		time.Sleep(15 * time.Second)
	}

}

func generateHealthData(cs string) (s string) {

	data := &KeepAlive{
		Namespace: cs,
		Timestamp: time.Now().Unix(),
	}

	text_data, _ := json.Marshal(data)
	return string(text_data)
}

func generatePayloadData(cs string) (s string) {

	data := &Datapayload{
		Namespace:     cs,
		Color:         cs,
		Current:       rrfloat(1000, 2000),
		ActivePower:   rrfloat(1000, 2000),
		ReactivePower: rrfloat(1000, 2000),
		ApparentPower: rrfloat(1000, 2000),
		Frequency:     rrfloat(50, 60),
		PowerFactor:   rrfloat(1000, 100000),
		PhaseAngle:    rrfloat(1, 359),
		VTHD:          rrfloat(1, 1000),
		ATHD:          rrfloat(1, 1000),
		Timestamp:     time.Now().Unix(),
	}

	text_data, _ := json.Marshal(data)
	return string(text_data)
}

func rrfloat(fl int, ce int) (r_float32 float32) {

	return float32(rand.Intn(ce-fl)+fl) + rand.Float32()
}
