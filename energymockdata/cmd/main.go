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
		Namespace        string
		Color            string
		Voltage          float32
		Current          float32
		ActivePower      float32
		ReactivePower    float32
		ApparentPower    float32
		Frequency        float32
		PowerFactor      float32
		PhaseAngle       float32
		VTHD             float32
		ATHD             float32
		PowerConsumption float32
		Timestamp        int64 `json:"timestamp"`
	}

	PilotDatapayload struct {
		Namespace         string
		LoadId            string
		Voltage           float32
		Current           float32
		EnergyConsumption float32
		Timestamp         int64 `json:"timestamp"`
	}

	KeepAlive struct {
		Namespace string
		Timestamp int64 `json:"timestamp"`
	}
)

func main() {
	PowerConsumption := float32(0.0)

	fmt.Println("mock mqqt data generators")
	//read env from files instead windows env (applicable for dev only)
	if err := godotenv.Load(".env.staging"); err != nil {
		log.Print("No .env file found")
	}

	mqtt.NewMQTTClient(os.Getenv("MQ_HOST2"))

	for {
		// // meter 1
		// mqtt.GetMqttClient().Publish("vl/em-staging/e6daf318-6516-4350-6b56-ae0a44b7e5d7/m01/notify",
		// 	0, false, generatePayloadData("RED1", &PowerConsumption))
		// mqtt.GetMqttClient().Publish("vl/em-staging/e6daf318-6516-4350-6b56-ae0a44b7e5d7/m01/notify",
		// 	0, false, generatePayloadData("YELLOW1", &PowerConsumption))
		// mqtt.GetMqttClient().Publish("vl/em-staging/e6daf318-6516-4350-6b56-ae0a44b7e5d7/m01/notify",
		// 	0, false, generatePayloadData("BLUE1", &PowerConsumption))
		// mqtt.GetMqttClient().Publish("vl/em-staging/health/m01",
		// 	0, false, generateHealthData("m01"))
		// time.Sleep(15 * time.Second)
		// // meter 2
		// mqtt.GetMqttClient().Publish("vl/em-staging/e6daf318-6516-4350-6b56-ae0a44b7e5d7/m02/notify",
		// 	0, false, generatePayloadData("RED1", &PowerConsumption))
		// mqtt.GetMqttClient().Publish("vl/em-staging/e6daf318-6516-4350-6b56-ae0a44b7e5d7/m02/notify",
		// 	0, false, generatePayloadData("YELLOW1", &PowerConsumption))
		// mqtt.GetMqttClient().Publish("vl/em-staging/e6daf318-6516-4350-6b56-ae0a44b7e5d7/m02/notify",
		// 	0, false, generatePayloadData("BLUE1", &PowerConsumption))
		// mqtt.GetMqttClient().Publish("vl/em-staging/health/m02",
		// 	0, false, generateHealthData("m02"))
		// time.Sleep(15 * time.Second)

		// meter 2
		mqtt.GetMqttClient().Publish("vl/em-staging/e6daf318-6516-4350-6b56-ae0a44b7e5d7/826fc9fd-4c99-4985-5221-4cb90f70c176/uplink",
			0, false, generatePilotPayloadData("HOME_PAYLOADS", &PowerConsumption, "826fc9fd-4c99-4985-5221-4cb90f70c176"))
		time.Sleep(3 * time.Second)
		// mqtt.GetMqttClient().Publish("vl/em-staging/e6daf318-6516-4350-6b56-ae0a44b7e5d7/LOAD_2/uplink",
		// 	0, false, generatePilotPayloadData("HOME_PAYLOADS", &PowerConsumption, "2"))

		time.Sleep(3 * time.Second)
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

func generatePayloadData(cs string, currentpowerconsumption *float32) (s string) {

	currentconsumption := *currentpowerconsumption + rrfloat(1, 5)
	*currentpowerconsumption = currentconsumption

	data := &Datapayload{

		Namespace:        cs,
		Color:            cs,
		Voltage:          rrfloat(1000, 2000),
		Current:          rrfloat(1000, 2000),
		ActivePower:      rrfloat(1000, 2000),
		ReactivePower:    rrfloat(1000, 2000),
		ApparentPower:    rrfloat(1000, 2000),
		Frequency:        rrfloat(50, 60),
		PowerFactor:      rrfloat(1000, 100000),
		PhaseAngle:       rrfloat(1, 359),
		VTHD:             rrfloat(1, 1000),
		ATHD:             rrfloat(1, 1000),
		PowerConsumption: currentconsumption,
		Timestamp:        time.Now().Unix(),
	}

	text_data, _ := json.Marshal(data)
	return string(text_data)
}

func generatePilotPayloadData(cs string, currentpowerconsumption *float32, loadid string) (s string) {

	currentconsumption := *currentpowerconsumption + rrfloat(1, 5)
	*currentpowerconsumption = currentconsumption

	data := &PilotDatapayload{
		Namespace:         cs,
		LoadId:            loadid,
		Voltage:           rrfloat(1000, 2000),
		Current:           rrfloat(1000, 2000),
		EnergyConsumption: currentconsumption,
		Timestamp:         time.Now().Unix(),
	}

	text_data, _ := json.Marshal(data)
	return string(text_data)
}

func rrfloat(fl int, ce int) (r_float32 float32) {

	return float32(rand.Intn(ce-fl)+fl) + rand.Float32()
}
