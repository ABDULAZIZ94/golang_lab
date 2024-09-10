package main

import (
	"fmt"
	"sort"
)

// Meters represents a meter with its energy consumption data
type Meters struct {
	MeterToken          string
	TotalEnergyConsumed float64
}

// SortAndTakeFiveMetersPerBuilding sorts each slice of Meters in the map and returns the top 5 or fewer meters for each key
func SortAndTakeFiveMetersPerBuilding(metersMap map[string][]Meters) map[string][]Meters {
	// Create a result map to hold the sorted and limited meters per building
	result := make(map[string][]Meters)

	// Iterate over each building (key) in the map
	for buildingId, metersSlice := range metersMap {
		// Sort each slice of Meters by TotalEnergyConsumed in descending order
		sort.Slice(metersSlice, func(i, j int) bool {
			return metersSlice[i].TotalEnergyConsumed > metersSlice[j].TotalEnergyConsumed
		})

		// Add the top 5 or fewer meters for this building to the result map
		if len(metersSlice) > 5 {
			result[buildingId] = metersSlice[:5]
		} else {
			result[buildingId] = metersSlice
		}
	}

	return result
}

func main() {
	// Example data: map of building IDs to their meters
	metersMap := map[string][]Meters{
		"B1": {
			{"M1", 1000.5},
			{"M2", 2500.0},
			{"M3", 1800.3},
			{"M4", 1500.7},
			{"M5", 1300.1},
			{"M6", 900.8},
		},
		"B2": {
			{"M1", 500.3},
			{"M2", 750.0},
		},
	}

	// Sort and take 5 meters for each building
	sortedMeters := SortAndTakeFiveMetersPerBuilding(metersMap)

	// Output the result
	for buildingId, meters := range sortedMeters {
		fmt.Printf("BuildingId: %s\n", buildingId)
		for _, m := range meters {
			fmt.Printf("\tMeterToken: %s, TotalEnergyConsumed: %.2f\n", m.MeterToken, m.TotalEnergyConsumed)
		}
	}
}
