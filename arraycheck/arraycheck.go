package main

import (
	"errors"
	"fmt"
)

// RangeCheck checks if an index is within the bounds of the given array.
func RangeCheck(arr []int, index int) (int, error) {
	if index < 0 || index >= len(arr) {
		return 0, errors.New("index out of range")
	}
	return arr[index], nil
}

func main() {
	// Example array
	arr := []int{10, 20, 30, 40, 50}

	// Indices to check
	indices := []int{-1, 0, 2, 5}

	for _, index := range indices {
		value, err := RangeCheck(arr, index)
		if err != nil {
			fmt.Printf("Error: Index %d is out of range.\n", index)
		} else {
			fmt.Printf("Value at index %d: %d\n", index, value)
		}
	}
}
