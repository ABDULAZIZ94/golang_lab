package main

import (
	"fmt"
	"log"
	"net"
)

const googleDNSServer = "8.8.8.8:80"

func main() {
	ip, err := GetPreferredOutboundIP()
	if err != nil {
		log.Fatalf("Error: %v", err)
		return
	}
	fmt.Println("Outbound IP:", ip)
}

// GetPreferredOutboundIP gets the preferred outbound IP address of this machine.
func GetPreferredOutboundIP() (net.IP, error) {
	conn, err := net.Dial("udp", googleDNSServer)
	if err != nil {
		return nil, fmt.Errorf("failed to dial UDP connection: %w", err)
	}
	defer conn.Close()

	localAddr := conn.LocalAddr().(*net.UDPAddr)
	return localAddr.IP, nil
}
