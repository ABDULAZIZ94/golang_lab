package main

import (
	"encoding/binary"
	"encoding/hex"
	"fmt"
	"math"
)

func main() {
	fmt.Println(HexStrToFloat64("436EFEE3"))
}

// HexStrToFloat64 takes an 8-character hex string and converts it to a float64.
func HexStrToFloat64(hexStr string) float64 {
	// Decode the hex string to bytes
	var result float64
	data, err := hex.DecodeString(hexStr)
	if err != nil {
		fmt.Println("Error decoding hex string:", err)
		return 0
	}

	// Ensure the data is exactly 8 bytes (64 bits)
	if len(data) != 4 {
		fmt.Println("Hex string must represent exactly 8 bytes for float64")
		return float64(len(data))
	}

	// Convert bytes to uint64 using BigEndian or LittleEndian as needed
	uintVal := binary.BigEndian.Uint32(data)

	// Convert uint64 to float64
	floatVal := math.Float32frombits(uintVal)

	result = float64(floatVal)

	// Round to two decimal places
	result = math.Round(result*100) / 100

	return result
}
