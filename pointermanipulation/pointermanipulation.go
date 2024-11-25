package main

import "fmt"

func main() {
	// Declare an integer variable
	var num int = 42

	// Create a pointer to the variable
	var ptr *int = &num

	// Print the value and the address
	fmt.Println("Value of num:", num)
	fmt.Println("Address of num:", ptr)

	// Dereference the pointer to modify the value
	*ptr = 58
	fmt.Println("New value of num:", num)

	// Passing a pointer to a function
	increment(ptr)
	fmt.Println("Value of num after increment:", num)
}

func increment(val *int) {
	*val += 1 // Dereferencing and modifying the value
}
