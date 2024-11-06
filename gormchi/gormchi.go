package main

import (
	"database/sql"
	"encoding/json"
	"fmt"
	"log"
	"net/http"
	"os"
	"time"

	"github.com/go-chi/chi/v5"
	"github.com/go-chi/chi/v5/middleware"
	"github.com/joho/godotenv"
	"gorm.io/driver/postgres"
	"gorm.io/gorm"
	"gorm.io/gorm/logger"
)

// GormDefault provides default fields for GORM models
type GormDefault struct {
	CreatedAt time.Time      `json:"created_at"`
	UpdatedAt time.Time      `json:"updated_at"`
	DeletedAt gorm.DeletedAt `json:"-"`
}

// Loads represents the loads table in the database
type Loads struct {
	Id                   string         `json:"id"`
	IsThreePhase         sql.NullBool   `json:"is_three_phase"`
	LoadName             string         `json:"load_name"`
	LoadToken            string         `json:"load_token"`
	PhaseColor           sql.NullString `json:"phase_color"`
	PhaseColorValid      sql.NullBool   `json:"phase_color_valid"`
	LoadThresholdMin     float64        `json:"load_threshold_min"`
	LoadThresholdMax     float64        `json:"load_threshold_max"`
	OperationStartHour   time.Time      `json:"operation_start_hour"`
	OperationEndHour     time.Time      `json:"operation_end_hour"`
	AlertSecondGap       int            `json:"alert_second_gap"`
	LastOperationAlerted time.Time      `json:"last_operation_alerted"`
	LastLoadAlerted      time.Time      `json:"last_load_alerted"`
	WeekdayOnly          sql.NullBool   `json:"weekday_only"`
	GormDefault
}

// DeviceInfo represents device information
type DeviceInfo struct {
	DeviceName string `json:"device_name"`
}

// Response represents a standard API response
type Response struct {
	Message string `json:"message"`
}

// getDatabaseConnection initializes the database connection
func getDatabaseConnection() (*gorm.DB, error) {
	host := os.Getenv("DB_HOST")
	port := os.Getenv("DB_PORT")
	user := os.Getenv("DB_USER")
	password := os.Getenv("DB_PASSWORD")
	dbname := os.Getenv("DB_NAME")

	dsn := fmt.Sprintf("host=%s port=%s user=%s password=%s dbname=%s sslmode=disable",
		host, port, user, password, dbname)

	db, err := gorm.Open(postgres.Open(dsn), &gorm.Config{
		Logger: logger.Default.LogMode(logger.Info),
	})
	if err != nil {
		return nil, fmt.Errorf("failed to connect to the database: %w", err)
	}
	return db, nil
}

func main() {

	//read env from files instead windows env (applicable for dev only)
	if err := godotenv.Load(".env"); err != nil {
		log.Print("No .env file found")
	}

	db, err := getDatabaseConnection()
	if err != nil {
		log.Fatal(err)
	}

	r := chi.NewRouter()
	r.Use(middleware.Logger)

	// Define a sample device model and start time for demonstration
	wsmodel := DeviceInfo{DeviceName: "SampleDevice"}
	operationStartTime := time.Now()

	// Define /device-info endpoint
	r.Get("/device-info", func(w http.ResponseWriter, r *http.Request) {
		message := fmt.Sprintf("Peranti %s Peranti %s waktu operasi (%s - %s)",
			wsmodel.DeviceName,
			wsmodel.DeviceName,
			operationStartTime.UTC().Format("3 PM"),
			operationStartTime.Add(12*time.Hour).UTC().Format("3 PM"))

		response := Response{Message: message}

		w.Header().Set("Content-Type", "application/json")
		if err := json.NewEncoder(w).Encode(response); err != nil {
			http.Error(w, "Failed to encode response", http.StatusInternalServerError)
		}
	})

	// Define /loads endpoint
	r.Get("/loads", func(w http.ResponseWriter, r *http.Request) {
		var loads []Loads
		if err := db.Find(&loads).Error; err != nil {
			http.Error(w, "Failed to retrieve loads", http.StatusInternalServerError)
			return
		}

		w.Header().Set("Content-Type", "application/json")
		if err := json.NewEncoder(w).Encode(loads); err != nil {
			http.Error(w, "Failed to encode loads", http.StatusInternalServerError)
		}
	})

	log.Println("Server is running on http://localhost:8080")
	if err := http.ListenAndServe(":8080", r); err != nil {
		log.Fatal("Server failed:", err)
	}
}
