package main

import (
	"bytes"
	"encoding/json"
	"fmt"
	"net/http"
	"time"
)

type (
	MessageRequest struct {
		Group   string `json:"group"`
		Message string `json:"message"`
	}
	Message struct {
		Alerttype  string
		DeviceName string
		Load       string
		Timestamp  string
	}
)

func main() {

	// url := "https://api.wassenger.com/v1/messages"

	// payload := strings.NewReader("{\"phone\":\"+60176409817\",\"message\":\"Hello world, this is a test message 😀\"}")

	// req, _ := http.NewRequest("POST", url, payload)

	// req.Header.Add("Content-Type", "application/json")
	// req.Header.Add("Token", "167701581c3c83c3b11eaeb064dd00ba00c890ec0211f0b0bb33435b1840d1e3dccad97da33b47c6")

	// res, _ := http.DefaultClient.Do(req)

	// defer res.Body.Close()
	// body, _ := io.ReadAll(res.Body)

	// fmt.Println(res)
	// fmt.Println(string(body))
	wsmodel := Message{}
	wsmodel.Alerttype = "Load Exceed Operation Hour Range"
	wsmodel.DeviceName = "L1"
	wsmodel.Load = "200V"
	wsmodel.Timestamp = time.Now().Local().Format(time.RFC3339)

	wsjson, _ := json.Marshal(wsmodel)
	sendMessageToGroup("167701581c3c83c3b11eaeb064dd00ba00c890ec0211f0b0bb33435b1840d1e3dccad97da33b47c6", "120363356335455491@g.us", string(wsjson))

}

func sendMessageToGroup(apiKey, groupID, messageText string) error {
	url := "https://api.wassenger.com/v1/messages"

	// Create the message request payload
	requestBody := MessageRequest{
		Group:   groupID,
		Message: messageText,
	}
	jsonBody, err := json.Marshal(requestBody)
	if err != nil {
		return fmt.Errorf("error marshalling JSON: %v", err)
	}

	// Create HTTP request
	req, err := http.NewRequest("POST", url, bytes.NewBuffer(jsonBody))
	if err != nil {
		return fmt.Errorf("error creating HTTP request: %v", err)
	}

	// // Set headers
	// req.Header.Set("Authorization", "Bearer "+apiKey)
	// req.Header.Set("Content-Type", "application/json")
	req.Header.Add("Content-Type", "application/json")
	req.Header.Add("Token", apiKey)

	// Send request
	client := &http.Client{}
	resp, err := client.Do(req)
	if err != nil {
		return fmt.Errorf("error sending request: %v", err)
	}
	defer resp.Body.Close()

	// Check response status
	if resp.StatusCode != http.StatusOK && resp.StatusCode != http.StatusCreated {
		return fmt.Errorf("unexpected response status: %v", resp.Status)
	}

	fmt.Println("Message sent successfully to the group!")
	return nil
}
