package main

import (
	"context"
	"encoding/json"
	"fmt"
	"jwtmain/pkg/util/gate"
	"net/http"
	"strings"

	"github.com/go-chi/chi"
)

type AccessInfo struct {
	StateID       int
	UserTypeID    int
	AccessLevelID int
	TenantID      string
	UserID        string
	DistrictID    int
	AccessFlag    bool
	UserType      string
	AccessLevel   string
}

func main() {
	fmt.Println("jwt main application")
	router := chi.NewRouter()
	router.Get("/", processReq)

	http.ListenAndServe(":3000", router)
}

func processReq(w http.ResponseWriter, r *http.Request) {
	fmt.Printf("incoming http request %v\n", r)
	info, err := CheckAccessLevel(r.Context())
	fmt.Printf("info: %v, err: %v ", info, err)
}

func CheckAccessLevel(r context.Context) (*AccessInfo, error) {
	fmt.Printf("r in check access level %v\n", r)
	data, err := gate.Get(r)
	fmt.Printf("data: %v, err: %v ", data, err)
	if err != nil {
		return nil, err
	} else {
		ai := &AccessInfo{
			StateID:       data.Get("BranchStateID").MustInt(),
			UserTypeID:    data.Get("UserTypeID").MustInt(),
			AccessLevelID: data.Get("AccessLevelID").MustInt(),
			TenantID:      data.Get("TenantID").MustString(),
			UserID:        data.Get("UserID").MustString(),
			DistrictID:    data.Get("BranchDistrictID").MustInt(),
			AccessFlag:    data.Get("AllAccess").MustBool(),
			UserType:      strings.ToUpper(data.Get("UserType").MustString()),
			AccessLevel:   strings.ToUpper(data.Get("AccessLevel").MustString()),
		}
		ais, _ := json.Marshal(ai)
		fmt.Println("misc.CheckAccessLevel access_info: " + string(ais) + "\n")
		return ai, nil
	}
}
