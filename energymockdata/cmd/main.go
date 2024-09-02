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
)

func main() {
	fmt.Println("mock mqqt data generators")
	//read env from files instead windows env (applicable for dev only)
	if err := godotenv.Load(".env.staging"); err != nil {
		log.Print("No .env file found")
	}

	mqtt.NewMQTTClient(os.Getenv("MQ_HOST2"))

	for {
		mqtt.GetMqttClient().Publish("vl/staging/t2/110/uplink", 0, false, generatePayloadData())
		time.Sleep(1 * time.Second)
	}

}

func generatePayloadData() (s string) {

	data := &Datapayload{
		Namespace:     "NOTIFY",
		Current:       rrfloat(1000, 2000),
		ActivePower:   rrfloat(1000, 2000),
		ReactivePower: rrfloat(1000, 2000),
		ApparentPower: rrfloat(1000, 2000),
		Frequency:     rrfloat(50, 60),

		Timestamp: time.Now().Unix(),
	}

	text_data, _ := json.Marshal(data)
	return string(text_data)
}

func rrfloat(fl int, ce int) (r_float32 float32) {

	return float32(rand.Intn(ce-fl)+fl) + rand.Float32()
}
