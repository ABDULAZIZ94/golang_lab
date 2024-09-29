package main

import (
	"fmt"
	"net"
)

func getIPByInterfaceName(ifaceName string) (string, error) {
	// Get the interface by its name (e.g., "wlan0")
	iface, err := net.InterfaceByName(ifaceName)
	if err != nil {
		return "", fmt.Errorf("could not get interface: %v", err)
	}

	// Get the list of addresses assigned to the interface
	addrs, err := iface.Addrs()
	if err != nil {
		return "", fmt.Errorf("could not get addresses: %v", err)
	}

	// Iterate over the addresses and return the first valid IPv4 address
	for _, addr := range addrs {
		// Check if the address is an IP address (ignores things like CIDR)
		ipNet, ok := addr.(*net.IPNet)
		if ok && !ipNet.IP.IsLoopback() && ipNet.IP.To4() != nil {
			return ipNet.IP.String(), nil
		}
	}

	return "", fmt.Errorf("no valid IP address found for interface %s", ifaceName)
}

func main() {
	ifaceName := "en0"
	ip, err := getIPByInterfaceName(ifaceName)
	if err != nil {
		fmt.Println(err)
	} else {
		fmt.Printf("IP address of %s: %s\n", ifaceName, ip)
	}
}
