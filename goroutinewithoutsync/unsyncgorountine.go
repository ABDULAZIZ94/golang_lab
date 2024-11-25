package main

import (
	"fmt"
	"time"
)

func main() {
	counter := 0

	// Goroutine to increment the counter
	for i := 0; i < 10; i++ {
		go func() {
			counter++
		}()
	}

	// Wait to ensure goroutines finish (not a safe synchronization method)
	time.Sleep(1 * time.Second)

	fmt.Println("Final Counter Value (without sync):", counter)
}
