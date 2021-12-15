package models

import (
	"time"
)

// Article struct used to represent castro latest news
type Article struct {
	ID        int64
	Title     string
	Text      string `gorm:"type:text"`
	CreatedAt time.Time
	UpdatedAt time.Time
}
