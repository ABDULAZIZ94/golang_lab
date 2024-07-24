package main

import (
	"math/rand"

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

	for i := range [100]int{} {
		db.Model(&model).Create(
			&MoneyData{
				Id:          i,
				IsDebit:     true,
				IsCredit:    false,
				Ammount:     float32(rand.Intn(300-0) + 0),
				Description: "cukai lucu",
			},
		)
	}

	for i := range [1000]int{} {
		db.Model(&model).Create(
			&MoneyData{
				Id:          i * i,
				IsDebit:     true,
				IsCredit:    false,
				Ammount:     float32(rand.Intn(300-0) + 0),
				Description: "cukai lucu",
			},
		)
	}
}
