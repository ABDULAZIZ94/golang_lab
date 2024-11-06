package main

import (
	"database/sql"
	"fmt"
	"log"
	"time"

	"gorm.io/driver/postgres"
	"gorm.io/gorm"
)

// Database configuration
const (
	host     = "alpha.vectolabs.com"
	port     = 9998
	user     = "postgres"
	password = "VectoLabs)1"
	dbname   = "energy-staging"
)

type GormDefault struct {
	CreatedAt time.Time
	UpdatedAt time.Time
	DeletedAt gorm.DeletedAt
}

type (
	Loads struct {
		Id                   string
		IsThreePhase         sql.NullBool
		LoadName             string
		LoadToken            string
		PhaseColor           sql.NullString
		PhaseColorValid      sql.NullBool
		LoadThresholdMin     float64
		LoadThresholdMax     float64
		OperationStartHour   time.Time
		OperationEndHour     time.Time
		AlertSecondGap       int
		LastOperationAlerted time.Time
		LastLoadAlerted      time.Time
		WeekdayOnly          sql.NullBool
		GormDefault
	}
)

func main() {
	dsn := "host=%s port=%d user=%s password=%s dbname=%s sslmode=disable"
	dsn = fmt.Sprintf(dsn, host, port, user, password, dbname)

	db, err := gorm.Open(postgres.Open(dsn), &gorm.Config{})
	if err != nil {
		log.Fatal("Failed to connect to the database:", err)
	}

	log.Println("Successfully connected to the database!")
	// Use `db` to interact with the database here

	loadsarymodel := []Loads{}
	db.Exec("select * from loads").Scan(&loadsarymodel)

	fmt.Printf("loads: %#v\n", loadsarymodel)
}
