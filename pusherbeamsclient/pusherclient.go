package main

import (
	"encoding/json"
	"net/http"

	pushnotifications "github.com/pusher/push-notifications-go"
)

const (
	instanceId = "adb2017d-2ae7-4778-9839-cbf0303212c7"
	secretKey  = "D7B8E8A6AE86C1F3A0A382CD4E243D80858493316C4B4E0CB22B23B2331E5E42"
)

func main() {
	beamsClient, _ := pushnotifications.New(instanceId, secretKey)

	http.HandleFunc("/pusher/beams-auth", func(w http.ResponseWriter, r *http.Request) {
		// Do your normal auth checks here 🔒
		userID := "" // get it from your auth system
		userIDinQueryParam := r.URL.Query().Get("user_id")
		if userID != userIDinQueryParam {
			w.WriteHeader(http.StatusUnauthorized)
			return
		}

		beamsToken, err := beamsClient.GenerateToken(userID)
		if err != nil {
			w.WriteHeader(http.StatusInternalServerError)
			return
		}

		beamsTokenJson, err := json.Marshal(beamsToken)
		if err != nil {
			w.WriteHeader(http.StatusInternalServerError)
			return
		}

		w.WriteHeader(http.StatusOK)
		w.Write(beamsTokenJson)
	})

	http.ListenAndServe("127.0.0.1:80", nil)
}
