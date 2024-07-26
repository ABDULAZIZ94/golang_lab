package main

import (
	"fmt"
	"reflect"
	"strconv"
	// "time"
)

type Person struct {
	Name    string   `default:"John Doe"`
	Age     int      `default:"30"`
	Address string   `default:"123 Main St"`
	StrAry  []string `default:"[]"`
}

// func setDefaults(p *type) {
// 	// Iterate over the fields of the Person struct using reflection
// 	// and set the default value for each field if the field is not provided
// 	// by the caller of the constructor function.
// 	r := reflect.TypeOf(p).NumField()
// 	fmt.Printf("r is %v", r)
// 	// for i := 0; i < reflect.TypeOf(*p).NumField(); i++ {
// 	// 	field := reflect.TypeOf(*p).Field(i)
// 	// 	if value, ok := field.Tag.Lookup("default"); ok {
// 	// 		reflect.TypeOf(*p).
// 	// 	}
// 	// }
// }

func setDefaults(p *Person) {
	// Iterate over the fields of the Person struct using reflection
	// and set the default value for each field if the field is not provided
	// by the caller of the constructor function.
	for i := 0; i < reflect.TypeOf(*p).NumField(); i++ {
		field := reflect.TypeOf(*p).Field(i)
		if value, ok := field.Tag.Lookup("default"); ok {
			switch field.Type.Kind() {
			case reflect.String:
				if p.Name == "" {
					p.Name = value
				}
			case reflect.Int:
				if p.Age == 0 {
					if intValue, err := strconv.Atoi(value); err == nil {
						p.Age = intValue
					}
				}
			}
		}
	}
}

func main() {
	ts := Person{}
	setDefaults(&ts)

	fmt.Printf("%v", ts)
}
