package cmd

import (
	"github.com/spf13/cobra"
	"fmt"
	"os"
)

var token string
var repoName string
var tagName string
var description string
var filename string

var RootCmd = &cobra.Command{
	Use:   "drafter",
	Short: "Upload file to github's release",
	Long:  `Upload file to github's release`,
	Run: func(cmd *cobra.Command, args []string) {
		// Do Stuff Here
	},
}

func Execute() {
	if err := RootCmd.Execute(); err != nil {
		fmt.Println(err)
		os.Exit(-1)
	}
}

func init() {
	RootCmd.PersistentFlags().StringVar(&token, "token", "", "github token")
	RootCmd.PersistentFlags().StringVar(&repoName, "repo_name", "", "repository名称，如Lynzabo/harbor")
	RootCmd.PersistentFlags().StringVar(&tagName, "tag_name", "", "tag")
	RootCmd.PersistentFlags().StringVar(&description, "description", "", "description")
	RootCmd.PersistentFlags().StringVar(&filename, "filename", "", "filename")
}
