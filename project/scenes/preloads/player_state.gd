extends Node

var can_grow: bool = false
var can_shrink: bool = false

func collect_scale_device():
	can_grow = true
	can_shrink = true

func reset():
	can_grow = false
	can_shrink = false
