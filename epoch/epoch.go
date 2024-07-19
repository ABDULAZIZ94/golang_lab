package main

import (
	"fmt"
	"time"
)

func main() {

	now := time.Now()
	fmt.Println(time.Now().Unix())
	fmt.Println(now)

	fmt.Println(now.Unix())
	fmt.Println(now.UnixMilli())
	fmt.Println(now.UnixNano())

	fmt.Println(time.Unix(now.Unix(), 0))
	fmt.Println(time.Unix(0, now.UnixNano()))

	time.Unix(time.Now().Unix(), 0)
}
