package main

import "fmt"

var (
	appName       string
	appVersion    string
	appCommitHash string
	goVersion     string
	buildDate     string
	buildArch     string
)

func main() {
	fmt.Printf("%s version information:\n", appName)
	fmt.Printf("Version:\t%s - %s\n", appVersion, appCommitHash)
	fmt.Printf("Go Version:\t%s\n", goVersion)
	fmt.Printf("Build:\t%s\n", buildDate)
	fmt.Printf("Arch:\t%s\n", buildArch)
}
