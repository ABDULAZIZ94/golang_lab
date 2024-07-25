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

	var s = make([]string, 1)
	var y = []string{}

	var a = []AnalyticDataRes{}

	// var z = []interface{}
	// fmt.Printf("%v %v %v", s, y, z)
	fmt.Printf("%v %v  %v\n", s, y, a)

}
