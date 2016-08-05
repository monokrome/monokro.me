package main

import (
	"database/sql"
	"log"
)

type Database struct {
	engine *sql.DB
}

var database Database

func init() {
	log.Print("Connecting to database at ./data.sqlite3")
	engine, err := sql.Open("sqlite3", "./data.sqlite3")

	if err != nil {
		log.Fatalln(err)
	}

	database.engine = engine
}

func (db Database) Begin() (tx *sql.Tx) {
	tx, err := db.engine.Begin()

	if err != nil {
		log.Println(err)
		return nil
	}

	return tx
}

func (db Database) Prepare(q string) (stmt *sql.Stmt, err error) {
	stmt, err = db.engine.Prepare(q)

	if err != nil {
		return nil, err
	}

	return stmt, nil
}

func (db Database) Query(q string, args ...interface{}) (rows *sql.Rows, err error) {
	rows, err = db.engine.Query(q, args...)

	if err != nil {
		return nil, err
	}

	return rows, nil
}

func (database Database) ExecOrRollback(sql string, args ...interface{}) (err error) {
	log.Println("Querying: ", sql)

	SQL, err := database.Prepare(sql)

	if err != nil {
		return err
	}

	tx := database.Begin()

	_, err = tx.Stmt(SQL).Exec(args...)

	if err != nil {
		log.Println("Rolling back due to failed query: ", err)
		tx.Rollback()
		return err
	}

	tx.Commit()
	return nil
}
