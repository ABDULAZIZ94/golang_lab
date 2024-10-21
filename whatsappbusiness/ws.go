package main

import (
	"fmt"
	"io"
	"net/http"
	"strings"
)

func main() {

	url := "https://api.wassenger.com/v1/messages"

	payload := strings.NewReader("{\"phone\":\"+60176409817\",\"message\":\"Hello world, this is a test message 😀\"}")

	req, _ := http.NewRequest("POST", url, payload)

	req.Header.Add("Content-Type", "application/json")
	req.Header.Add("Token", "167701581c3c83c3b11eaeb064dd00ba00c890ec0211f0b0bb33435b1840d1e3dccad97da33b47c6")

	res, _ := http.DefaultClient.Do(req)

	defer res.Body.Close()
	body, _ := io.ReadAll(res.Body)

	fmt.Println(res)
	fmt.Println(string(body))

}
