package main

import "fmt"

type FeedbackRequest struct {
	URL string
}

var retryQueue []FeedbackRequest

func main() {
	//primes := [6]int{2, 3, 5, 7, 11, 13}

	//var primeary []int
	retryQueue = append(retryQueue, FeedbackRequest{URL: "www"})
	retryQueue = append(retryQueue, FeedbackRequest{URL: "fff"})
	retryQueue = append(retryQueue, FeedbackRequest{URL: "ggg"})

	for i := 0; i < len(retryQueue); i++ {
		fmt.Printf("retryqueue:%v\n", retryQueue)
		start := 0
		end := len(retryQueue)

		//remove successfully queried
		if start >= 0 && end <= len(retryQueue) && start <= end && i+1 <= end {
			retryQueue = append(retryQueue[start:i], retryQueue[i+1:end]...)
		} else {
			retryQueue = retryQueue[start:i]
		}

		i-- // Adjust index after removal

	}
}
