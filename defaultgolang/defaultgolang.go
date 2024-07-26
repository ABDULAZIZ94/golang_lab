package main

import (
	"fmt"
	// "time"

	"github.com/mcuadros/go-defaults"
)

type teststruct struct {
	Id int `default:"1"`
	// timestamp   time.Time `default:"time.Time{}"`
	// Description string `default:"this is efault test"`
}

func main() {
	ts := teststruct{}
	defaults.SetDefaults(ts)

	fmt.Printf("%v", ts)
}
