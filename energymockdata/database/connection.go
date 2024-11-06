package database

import (
	"fmt"
	"log"
	"os"

	"github.com/jinzhu/gorm"
	// _ "github.com/jinzhu/gorm/dialects/postgres"
	_ "github.com/lib/pq"
)

type ()

type DBStruct struct {
	db *gorm.DB
}

type InTransaction func(tx *gorm.DB) error

var DBInstance *gorm.DB

func NewDB() (error, bool) {
	host := os.Getenv("PG_HOST")
	port := os.Getenv("PG_PORT")
	user := os.Getenv("PG_USER")
	password := os.Getenv("PG_PASSWD")
	dbname := os.Getenv("PG_DB")
	ssl := "disable"

	psqlInfo := fmt.Sprintf("host=%s port=%s user=%s "+
		"dbname=%s sslmode=%s password=%s",
		host, port, user, dbname, ssl, password)

	log.Println(psqlInfo)
	db, err := gorm.Open("postgres", psqlInfo)
	if err != nil {
		log.Println("ERR_GRM_DB_INSTANCE: ", err)
		return err, false
	}

	DBInstance = db

	db.LogMode(true)

	//
	db.BlockGlobalUpdate(true)

	// do migration
	db.AutoMigrate(
	// &CleanerAndTenant{},
	// &Device{},
	// &DeviceType{},
	// &ToiletType{},
	// &DevicePair{},
	// &SettingValue{},
	// &DeviceCubicalPairs{},
	// &FeedbackPanelSetting{},
	// &FeedbackPanel{},
	// &CleanerReport{},
	// &ToiletInfo{},
	// &Location{},
	// //
	// &Contractor{},
	// &SubTenantAndTenant{},
	// &MqttUser{},
	// &MqttAcl{},
	//
	// &CleanerRfid{},
	// &UserReaction{},
	// &Reaction{},
	// &Complaint{},
	// 	&FpSensorData{},
	)

	// //RELATION

	// db.Model(&SettingValue{}).
	// 	AddForeignKey("fp_set_id",
	// 		"FEEDBACK_PANEL_SETTINGS(fp_set_id)",
	// 		"CASCADE",
	// 		"RESTRICT")

	// db.Model(&FeedbackPanelSetting{}).
	// 	AddForeignKey("button_id",
	// 		"feedback_panels(button_id)",
	// 		"CASCADE",
	// 		"RESTRICT")

	// db.Model(&Device{}).
	// 	AddForeignKey("tenant_id",
	// 		"tenants(tenant_id)",
	// 		"CASCADE",
	// 		"RESTRICT")

	// db.Model(&Device{}).
	// 	AddForeignKey("device_type_id",
	// 		"device_types(device_type_id)",
	// 		"CASCADE",
	// 		"RESTRICT")

	// db.Model(&CleanerReport{}).
	// 	AddForeignKey("gateway_id",
	// 		"devices(device_id)",
	// 		"CASCADE",
	// 		"RESTRICT")

	// db.Model(&CleanerReport{}).
	// 	AddForeignKey("toilet_info_id",
	// 		"toilet_infos(toilet_info_id)",
	// 		"CASCADE",
	// 		"RESTRICT")

	// db.Model(&DevicePair{}).
	// 	AddForeignKey("toilet_info_id",
	// 		"toilet_infos(toilet_info_id)",
	// 		"CASCADE",
	// 		"RESTRICT")

	// db.Model(&ToiletInfo{}).
	// 	AddForeignKey("location_id",
	// 		"locations(location_id)",
	// 		"CASCADE",
	// 		"RESTRICT")

	// db.Model(&UserCleaner{}).
	// 	AddForeignKey("contractor_id",
	// 		"contractors(contractor_id)",
	// 		"CASCADE",
	// 		"RESTRICT")

	return nil, true
}

func GetInstance() *gorm.DB {
	return DBInstance
}

func DoTransaction(fn InTransaction) error {

	tx := DBInstance.Begin()

	if tx.Error != nil {
		log.Println(tx.Error)
	}

	err := fn(tx)

	if err != nil {
		xerr := tx.Rollback().Error
		if xerr != nil {
			return xerr
		}
		return err
	}

	if err = tx.Commit().Error; err != nil {
		return err
	}

	return nil

}
