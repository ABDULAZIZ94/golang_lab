package main

import (
	"encoding/binary"
	"encoding/hex"
	"fmt"
	"math"
)

func main() {
	fmt.Println(hexStrToFloat64("43f8034b"))
}

func hexStrToFloat64(hexStr string) float64 {

	bytes, err := hex.DecodeString(hexStr)

	fmt.Printf("bytes: %#v\n", bytes)

	if err != nil {
		fmt.Println("Error decoding hex string:", err)
		return 0.0
	}

	// Convert byte array to float64
	var floatVal float64
	// Using BigEndian for conversion (or LittleEndian based on your requirements)
	floatVal = float64(binary.LittleEndian.Uint64(append(bytes, 0, 0, 0, 0, 0, 0, 0, 0)[:8]))

	//round to two decimal place
	floatVal = math.Round(floatVal*100) / 100

	return floatVal
}
