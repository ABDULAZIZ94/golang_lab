package main

import (
	"fmt"
)

func main() {
	toilet := struct {
		id          int
		uuid        string
		condition   int
		description string
	}{
		1,
		"faffadfsconst",
		0,
		"test toilet",
	}
	fmt.Printf("struct is %+v", toilet)

}
