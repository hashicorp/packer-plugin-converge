package main

import (
	"fmt"
	"os"

	"github.com/hashicorp/packer-plugin-converge/provisioner/converge"
	"github.com/hashicorp/packer-plugin-converge/version"

	"github.com/hashicorp/packer-plugin-sdk/plugin"
)

func main() {
	pps := plugin.NewSet()
	pps.RegisterProvisioner(plugin.DEFAULT_NAME, new(converge.Provisioner))
	pps.SetVersion(version.PluginVersion)
	err := pps.Run()
	if err != nil {
		fmt.Fprintln(os.Stderr, err.Error())
		os.Exit(1)
	}
}
