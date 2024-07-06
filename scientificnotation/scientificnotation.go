package main

import (
	"fmt"
	"strconv"
)

func main() {
	scnot := "0e0139016966"
	snot_int, err := strconv.Atoi(scnot)
	fmt.Printf("scentific notation: %v, error: %v", snot_int, err)
}
