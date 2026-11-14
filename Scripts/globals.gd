extends Node

var started: bool
var spawning: bool

var score: int

signal hit()
signal score_changed(score: int)


func change_score(value: int):
	score += value
	score_changed.emit(score)
