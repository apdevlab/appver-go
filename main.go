package main

import (
	"fmt"
	"strings"
)

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
	fmt.Printf("Version:\t%s-%s\n", appVersion, appCommitHash)
	fmt.Printf("Go Version:\t%s\n", goVersion)
	fmt.Printf("Build:\t\t%s\n", strings.Replace(buildDate, "_", " ", -1))
	fmt.Printf("Arch:\t\t%s\n", buildArch)
}
