package main

import (
	"encoding/json"
	"fmt"
	"log"
	"math/rand"
	"mqttmockdata_module/mqtt"
	"os"
	"time"

	"github.com/joho/godotenv"
)

type (
	OccupancyData struct {
		Id          int `gorm:"primary_key; auto_increment; not_null"`
		DeviceToken string
		Occupied    bool
		Timestamp   time.Time
	}

	AmmoniaData struct {
		Id           int `gorm:"primary_key; auto_increment; not_null"`
		DeviceToken  string
		AmmoniaLevel int
		// FragranceOn       bool
		// FragranceDuration int
		// FraggranceCount   int
		Timestamp time.Time
	}
	MqttAmmoniaData struct {
		Namespace    string    `json:"namespace"`
		NamespaceID  int       `json:"namespaceID"`
		Timestamp    time.Time `json:"timestamp"`
		AmmoniaLevel int       `json:"ammonialevel"`
	}
	FragranceData struct {
		Id          int `gorm:"primary_key; auto_increment; not_null"`
		DeviceToken string
		// AmmoniaLevel      int
		FragranceOn       bool
		FragranceDuration int
		FraggranceCount   int
		Timestamp         time.Time
	}

	SmokeData struct {
		Id          int `gorm:"primary_key; auto_increment; not_null"`
		DeviceToken string
		SmokeSensor bool
		// PanicButton bool
		Timestamp time.Time
	}
	PanicBtnData struct {
		Id          int `gorm:"primary_key; auto_increment; not_null"`
		DeviceToken string
		// SmokeSensor bool
		PanicButton bool
		Timestamp   time.Time
	}
)

func main() {
	fmt.Println("mock mqqt data generators")
	//read env from files instead windows env (applicable for dev only)
	if err := godotenv.Load(); err != nil {
		log.Print("No .env file found")
	}

	mqtt.NewMQTTClient(os.Getenv("MQ_HOST2"))

	for {
		// mqtt.GetMqttClient().Publish("az/public/t2/70/uplink", 0, false, generatedata())
		// time.Sleep(1 * time.Second)
		mqtt.GetMqttClient().Publish("az/public/t2/75/uplink", 0, false, generatedata())
		time.Sleep(1 * time.Second)
		mqtt.GetMqttClient().Publish("az/public/t2/76/uplink", 0, false, generatedata())
		time.Sleep(1 * time.Second)
	}

}

func generatedata() (s string) {
	data := &MqttAmmoniaData{
		AmmoniaLevel: rand.Intn(255 - 0),
		// FragranceOn       bool
		// FragranceDuration int
		// FraggranceCount   int
		Namespace:   "AMMONIA",
		NamespaceID: 0,
		Timestamp:   time.Now(),
	}
	text_data, _ := json.Marshal(data)
	return string(text_data)
}
