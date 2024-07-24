package main

import (
	"gorm.io/driver/postgres"
	"gorm.io/gorm"
)

type MoneyData struct {
	Id          int
	IsDebit     bool
	IsCredit    bool
	Ammount     float32
	Description string
}

func main() {
	dsn := "host=localhost user=postgres password=postgres dbname=smarttoilet port=5432 sslmode=disable TimeZone=Asia/Kuala_Lumpur"
	db, _ := gorm.Open(postgres.Open(dsn), &gorm.Config{})

	model := MoneyData{}

	db.Model(&model).Create(
		&MoneyData{
			IsDebit:     true,
			IsCredit:    false,
			Ammount:     23.00,
			Description: "funny tax",
		},
	)

}
