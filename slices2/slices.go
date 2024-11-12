package main

import "fmt"

type AnalyticDataRes struct {
	TrafficCounter       []string `default:"0"`
	Enviroment           []string `default:"0"`
	ComplaintType        []string `default:"0"`
	NewComplaintType     string   `default:"0"`
	CleaningFrequency    string   `default:"0"`
	CleaningPerformance  string   `default:"0"`
	UserReactionTypeData string   `default:"0"`
	Ammonia              string   `default:"0"`
}

func main() {
	// var s = make([]string, 1)   // Example slice with one empty string element
	// var y = []string{}          // Empty slice of strings
	// var a = []AnalyticDataRes{} // Empty slice of AnalyticDataRes structs
	// uniqueMap := make(map[string]bool)

	// uniqueMap = append(uniqueMap, map["101"]true)

	// Print the contents of each variable
	// fmt.Printf("slices content: %v, %v, %v, uniqueMap[\"111\"]: %v\n", s, y, a, uniqueMap["111"])

	m := make(map[string]int)
	// Set key/value pairs using typical name[key] = val syntax.
	m["k1"] = 7
	m["k2"] = 13
	// Printing a map with e.g. fmt.Println will show all of its key/value pairs.
	fmt.Println("map:", m)

	m2 := make(map[string]int)

	m2["k1"] = 7
	m2["k2"] = 13

	fmt.Println("map:", m2)
	fmt.Printf("map:%v\n", m2)
}
