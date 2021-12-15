package util

import (
	"encoding/xml"
	"io/ioutil"
)

// ServerVocationList holds all the vocations of the server
var ServerVocationList = ServerVocations{
	List: &VocationList{},
}

// Vocation holds all information about a game vocation
type Vocation struct {
	ID          int    `xml:"id,attr"`
	Name        string `xml:"name,attr"`
	Description string `xml:"description,attr"`
	FromVoc     int    `xml:"fromvoc,attr"`
}

// VocationList golds the XML list of the vocation list
type VocationList struct {
	XMLName   xml.Name    `xml:"vocations"`
	Vocations []*Vocation `xml:"vocation"`
}

// ServerVocations contains the list of the server vocations
type ServerVocations struct {
	List *VocationList
}

// LoadVocations parses the vocations xml file
func LoadVocations(file string, list ServerVocations) error {
	// Load vocations file
	f, err := ioutil.ReadFile(file)

	if err != nil {
		return err
	}

	// Unmarshal vocations file
	return xml.Unmarshal(f, &list.List)
}
