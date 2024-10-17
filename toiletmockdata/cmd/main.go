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
	OccupancyData struct {
		Id          int `gorm:"primary_key; auto_increment; not_null"`
		DeviceToken string
		Occupied    int
		Timestamp   time.Time
	}
	MqttOccupancyData struct {
		Namespace   string `json:"namespace"`
		NamespaceID int    `json:"namespaceID"`
		Occupied    int    `json:"activated"`
		Timestamp   int64  `json:"timestamp"`
	}
	MqttCounterData struct {
		Namespace   string `json:"namespace"`
		NamespaceID int    `json:"namespaceID"`
		In          int    `json:"in"`
		Out         int    `json:"out"`
		Timestamp   int64  `json:"timestamp"`
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
		Namespace    string `json:"namespace"`
		NamespaceID  int    `json:"namespaceID"`
		Timestamp    int64  `json:"timestamp"`
		AmmoniaLevel int    `json:"ammonialevel"`
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
	MqttFragranceData struct {
		Namespace         string `json:"namespace"`
		NamespaceID       int    `json:"namespaceID"`
		FragranceOn       int    `json:"activated"`
		FragranceDuration int    `json:"fragranceDuration"`
		FraggranceCount   int    `json:"fragranceCount"`
		Timestamp         int64  `json:"timestamp"`
	}

	SmokeData struct {
		Id          int `gorm:"primary_key; auto_increment; not_null"`
		DeviceToken string
		SmokeSensor bool
		// PanicButton bool
		Timestamp time.Time
	}
	MqttSmokeData struct {
		Namespace   string `json:"namespace"`
		NamespaceID int    `json:"namespaceID"`
		Activated   int    `json:"activated"`
		Timestamp   int64  `json:"timestamp"`
	}
	PanicBtnData struct {
		Id          int `gorm:"primary_key; auto_increment; not_null"`
		DeviceToken string
		// SmokeSensor bool
		PanicButton bool
		Timestamp   time.Time
	}
	MqttPanicBtnData struct {
		Namespace   string `json:"namespace"`
		NamespaceID int    `json:"namespaceID"`
		Activated   int    `json:"activated"`
		Timestamp   int64  `json:"timestamp"`
	}
)

func main() {
	fmt.Println("mock mqqt data generators")
	//read env from files instead windows env (applicable for dev only)
	if err := godotenv.Load(".env.staging"); err != nil {
		log.Print("No .env file found")
	}

	mqtt.NewMQTTClient(os.Getenv("MQ_HOST2"))

	// total_fragrance_cummulative1 := 0
	// total_fragrance_cummulative2 := 0
	// fragrance_data := ""
	// for {
	//publish ammonia data
	// mqtt.GetMqttClient().Publish("vl/smarttoilet/59944171-3a4a-460d-5897-8bb38c524d54/75/uplink", 0, false, generateAmmoniaData())
	// time.Sleep(1 * time.Second)
	// mqtt.GetMqttClient().Publish("vl/smarttoilet/59944171-3a4a-460d-5897-8bb38c524d54/76/uplink", 0, false, generateAmmoniaData())
	// time.Sleep(1 * time.Second)
	// mqtt.GetMqttClient().Publish("vl/smarttoilet/59944171-3a4a-460d-5897-8bb38c524d54/80/uplink", 0, false, generateAmmoniaData())
	// time.Sleep(1 * time.Second)
	// mqtt.GetMqttClient().Publish("vl/smarttoilet/59944171-3a4a-460d-5897-8bb38c524d54/79/uplink", 0, false, generateAmmoniaData())
	// time.Sleep(1 * time.Second)
	// mqtt.GetMqttClient().Publish("vl/smarttoilet/59944171-3a4a-460d-5897-8bb38c524d54/78/uplink", 0, false, generateAmmoniaData())
	// time.Sleep(1 * time.Second)
	// mqtt.GetMqttClient().Publish("vl/smarttoilet/59944171-3a4a-460d-5897-8bb38c524d54/77/uplink", 0, false, generateAmmoniaData())
	// time.Sleep(1 * time.Second)
	//publish smoke data
	// mqtt.GetMqttClient().Publish("vl/smarttoilet/59944171-3a4a-460d-5897-8bb38c524d54/110/uplink", 0, false, generateSmokeData())
	// time.Sleep(1 * time.Second)
	// mqtt.GetMqttClient().Publish("vl/smarttoilet/59944171-3a4a-460d-5897-8bb38c524d54/69/uplink", 0, false, generateSmokeData())
	// time.Sleep(1 * time.Second)
	// mqtt.GetMqttClient().Publish("vl/smarttoilet/59944171-3a4a-460d-5897-8bb38c524d54/85/uplink", 0, false, generateSmokeData())
	// time.Sleep(1 * time.Second)
	// mqtt.GetMqttClient().Publish("vl/smarttoilet/59944171-3a4a-460d-5897-8bb38c524d54/86/uplink", 0, false, generateSmokeData())
	// time.Sleep(1 * time.Second)
	//publish occupancy data
	// mqtt.GetMqttClient().Publish("vl/smarttoilet/59944171-3a4a-460d-5897-8bb38c524d54/73/uplink", 0, false, generateOccupancyData())
	// time.Sleep(1 * time.Second)
	// mqtt.GetMqttClient().Publish("vl/smarttoilet/59944171-3a4a-460d-5897-8bb38c524d54/74/uplink", 0, false, generateOccupancyData())
	// time.Sleep(1 * time.Second)
	// mqtt.GetMqttClient().Publish("vl/smarttoilet/59944171-3a4a-460d-5897-8bb38c524d54/81/uplink", 0, false, generateOccupancyData())
	// time.Sleep(1 * time.Second)
	// mqtt.GetMqttClient().Publish("vl/smarttoilet/59944171-3a4a-460d-5897-8bb38c524d54/82/uplink", 0, false, generateOccupancyData())
	// time.Sleep(1 * time.Second)
	//occupancy mbk female
	// mqtt.GetMqttClient().Publish("vl/smarttoilet/59944171-3a4a-460d-5897-8bb38c524d54/91/uplink", 0, false, generateOccupancyData())
	// time.Sleep(1 * time.Second)
	// mqtt.GetMqttClient().Publish("vl/smarttoilet/59944171-3a4a-460d-5897-8bb38c524d54/92/uplink", 0, false, generateOccupancyData())
	// time.Sleep(1 * time.Second)
	// mqtt.GetMqttClient().Publish("vl/smarttoilet/59944171-3a4a-460d-5897-8bb38c524d54/93/uplink", 0, false, generateOccupancyData())
	// time.Sleep(1 * time.Second)
	// mqtt.GetMqttClient().Publish("vl/smarttoilet/59944171-3a4a-460d-5897-8bb38c524d54/94/uplink", 0, false, generateOccupancyData())
	// time.Sleep(1 * time.Second)

	//counter mbk
	mqtt.GetMqttClient().Publish("vl/smarttoilet/59944171-3a4a-460d-5897-8bb38c524d54/103/uplink", 0, false, generateCounterData())
	time.Sleep(1 * time.Second)
	mqtt.GetMqttClient().Publish("vl/smarttoilet/59944171-3a4a-460d-5897-8bb38c524d54/104/uplink", 0, false, generateCounterData())
	time.Sleep(1 * time.Second)

	//occupancy mbk male
	mqtt.GetMqttClient().Publish("vl/smarttoilet/59944171-3a4a-460d-5897-8bb38c524d54/300/uplink", 0, false, generateOccupancyData())
	time.Sleep(1 * time.Second)
	mqtt.GetMqttClient().Publish("vl/smarttoilet/59944171-3a4a-460d-5897-8bb38c524d54/301/uplink", 0, false, generateOccupancyData())
	time.Sleep(1 * time.Second)
	mqtt.GetMqttClient().Publish("vl/smarttoilet/59944171-3a4a-460d-5897-8bb38c524d54/302/uplink", 0, false, generateOccupancyData())
	time.Sleep(1 * time.Second)
	mqtt.GetMqttClient().Publish("vl/smarttoilet/59944171-3a4a-460d-5897-8bb38c524d54/303/uplink", 0, false, generateOccupancyData())

	//occupancy female
	mqtt.GetMqttClient().Publish("vl/smarttoilet/59944171-3a4a-460d-5897-8bb38c524d54/304/uplink", 0, false, generateOccupancyData())
	time.Sleep(1 * time.Second)
	mqtt.GetMqttClient().Publish("vl/smarttoilet/59944171-3a4a-460d-5897-8bb38c524d54/305/uplink", 0, false, generateOccupancyData())
	time.Sleep(1 * time.Second)
	mqtt.GetMqttClient().Publish("vl/smarttoilet/59944171-3a4a-460d-5897-8bb38c524d54/306/uplink", 0, false, generateOccupancyData())
	time.Sleep(1 * time.Second)
	mqtt.GetMqttClient().Publish("vl/smarttoilet/59944171-3a4a-460d-5897-8bb38c524d54/307/uplink", 0, false, generateOccupancyData())
	// time.Sleep(1 * time.Second)

	//publish panic data
	// mqtt.GetMqttClient().Publish("vl/smarttoilet/589ee2f0-75e1-4cd0-5c74-78a4df1288fd/1000/uplink", 0, false, generatePanicBtnData())
	// time.Sleep(1 * time.Second)
	// mqtt.GetMqttClient().Publish("vl/smarttoilet/59944171-3a4a-460d-5897-8bb38c524d54/72/uplink", 0, false, generatePanicBtnData())
	// time.Sleep(1 * time.Second)
	// mqtt.GetMqttClient().Publish("vl/smarttoilet/59944171-3a4a-460d-5897-8bb38c524d54/83/uplink", 0, false, generatePanicBtnData())
	// time.Sleep(1 * time.Second)
	// mqtt.GetMqttClient().Publish("vl/smarttoilet/59944171-3a4a-460d-5897-8bb38c524d54/84/uplink", 0, false, generatePanicBtnData())
	// time.Sleep(1 * time.Second)
	//publish frangrance data
	// fragrance_data, total_fragrance_cummulative1 = generateFragranceData(total_fragrance_cummulative1)
	// mqtt.GetMqttClient().Publish("vl/smarttoilet/59944171-3a4a-460d-5897-8bb38c524d54/68/uplink", 0, false, fragrance_data)
	// time.Sleep(1 * time.Second)
	// fragrance_data, total_fragrance_cummulative2 = generateFragranceData(total_fragrance_cummulative2)
	// mqtt.GetMqttClient().Publish("vl/smarttoilet/59944171-3a4a-460d-5897-8bb38c524d54/67/uplink", 0, false, fragrance_data)

	// mqtt.GetMqttClient().Publish("vl/smarttoilet/command", 0, false, "test")
	time.Sleep(10 * time.Second)
	// }

}

func generateAmmoniaData() (s string) {
	data := &MqttAmmoniaData{
		AmmoniaLevel: rand.Intn(256 - 0),
		Namespace:    "AMMONIA",
		NamespaceID:  0,
		Timestamp:    time.Now().Unix(),
	}
	text_data, _ := json.Marshal(data)
	return string(text_data)
}

func generateSmokeData() (s string) {
	data := &MqttSmokeData{
		Namespace:   "SMOKE",
		NamespaceID: 0,
		Activated:   rand.Intn(2 - 0),
		Timestamp:   time.Now().Unix(),
	}
	text_data, _ := json.Marshal(data)
	return string(text_data)
}
func generateCounterData() (s string) {
	data := &MqttCounterData{
		Namespace:   "COUNTER",
		NamespaceID: 0,
		In:          1, //rand.Intn(2 - 0),
		Out:         1, //rand.Intn(2 - 0),
		Timestamp:   time.Now().Unix(),
	}
	text_data, _ := json.Marshal(data)
	return string(text_data)
}

func generateOccupancyData() (s string) {
	data := &MqttOccupancyData{
		Namespace:   "OCCUPANCY",
		NamespaceID: 0,
		Occupied:    rand.Intn(2 - 0),
		Timestamp:   time.Now().Unix(),
	}
	text_data, _ := json.Marshal(data)
	return string(text_data)
}
func generatePanicBtnData() (s string) {
	data := &MqttPanicBtnData{
		Namespace:   "PANIC",
		NamespaceID: 0,
		Activated:   rand.Intn(2 - 0),
		Timestamp:   time.Now().Unix(),
	}
	text_data, _ := json.Marshal(data)
	return string(text_data)
}

func generateFragranceData(fragrance_count int) (s string, fragrance_cummulative int) {
	fragrance_on := rand.Intn(2 - 0)
	fragrance_duration := 0
	if fragrance_on == 1 {
		fragrance_duration = rand.Intn(3 - 0)
		fragrance_cummulative = fragrance_count + fragrance_duration
	} else {
		fragrance_duration = 0
		fragrance_cummulative = fragrance_count
	}

	data := &MqttFragranceData{
		Namespace:         "FRAGRANCE",
		NamespaceID:       0,
		FragranceOn:       fragrance_on,
		FragranceDuration: fragrance_duration,
		FraggranceCount:   fragrance_cummulative,
		Timestamp:         time.Now().Unix(),
	}
	text_data, _ := json.Marshal(data)
	return string(text_data), fragrance_cummulative
}
