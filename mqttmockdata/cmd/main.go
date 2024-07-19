package main

import (
	"fmt"
	"log"
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
	data := &AmmoniaData{
		AmmoniaLevel: 233,
		// FragranceOn       bool
		// FragranceDuration int
		// FraggranceCount   int
		Timestamp: time.Now(),
	}
	mqtt.NewMQTTClient(os.Getenv("MQ_HOST2"))
	mqtt.GetMqttClient().Publish("az/public/t2/71/uplink", 2, true, data)
}
