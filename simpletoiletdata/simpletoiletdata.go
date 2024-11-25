package main

import "fmt"

// Toilet represents basic information about a toilet.
type Toilet struct {
	ID          int    // Unique identifier
	Location    string // Description of the location
	IsOccupied  bool   // Whether the toilet is occupied
	HasHandicap bool   // Accessibility for people with disabilities
	HasBidet    bool   // Whether the toilet has a bidet
}

func main() {
	// Example usage
	toilets := []Toilet{
		{ID: 1, Location: "1st Floor, Near Lobby", IsOccupied: false, HasHandicap: true, HasBidet: false},
		{ID: 2, Location: "2nd Floor, Near Stairs", IsOccupied: true, HasHandicap: false, HasBidet: true},
	}

	for _, toilet := range toilets {
		fmt.Printf("Toilet %d (%s): Occupied=%t, Handicap Accessible=%t, Has Bidet=%t\n",
			toilet.ID, toilet.Location, toilet.IsOccupied, toilet.HasHandicap, toilet.HasBidet)
	}
}
