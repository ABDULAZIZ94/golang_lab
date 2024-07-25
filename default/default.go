package main

import (
	"fmt"

	"github.com/mcuadros/go-defaults"
)

type ExampleBasic struct {
	Foo bool   `default:"true"` //<-- StructTag with a default key
	Bar string `default:"33"`
	Qux int8
}

func main() {
	test := NewExampleBasic()
	fmt.Println(test.Foo) //Prints: true
	fmt.Println(test.Bar) //Prints: 33
	fmt.Println(test.Qux) //Prints:
}

func NewExampleBasic() *ExampleBasic {
	example := new(ExampleBasic)
	defaults.SetDefaults(example) //<-- This set the defaults values

	return example
}
