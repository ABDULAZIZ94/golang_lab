package main

import (
	"encoding/json"
	"fmt"
	"log"
	"net/http"
	"time"

	"github.com/go-chi/chi/v5"
	"github.com/go-chi/chi/v5/middleware"
)

type DeviceInfo struct {
	DeviceName string `json:"device_name"`
}

type Response struct {
	Message string `json:"message"`
}

func main() {
	r := chi.NewRouter()
	r.Use(middleware.Logger)

	// Define a sample device model and start time for demonstration
	wsmodel := DeviceInfo{DeviceName: "SampleDevice"}
	operationStartTime := time.Now()

	// Define a handler for the /device-info endpoint
	r.Get("/device-info", func(w http.ResponseWriter, r *http.Request) {
		message := fmt.Sprintf("Peranti %s Peranti %s waktu operasi (%s - %s)",
			wsmodel.DeviceName,
			wsmodel.DeviceName,
			operationStartTime.UTC().Format("3 PM"),
			operationStartTime.Add(12*time.Hour).UTC().Format("3 PM"))

		response := Response{Message: message}

		w.Header().Set("Content-Type", "application/json")
		json.NewEncoder(w).Encode(response)
	})

	log.Println("Server is running on http://localhost:8080")
	http.ListenAndServe(":8080", r)
}
