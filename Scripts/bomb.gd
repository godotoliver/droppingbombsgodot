extends RigidBody3D 


func _ready() -> void:
	contact_monitor = true
	max_contacts_reported = 1
	body_entered.connect(_on_body_entered)
	# TODO #1: turn of particles when bomb is created
	get_node("Explosion").emitting = false


func _on_body_entered(_body: Node) -> void:
	# TODO #2: emit particles and hide the bomb texture
	get_node("Explosion").emitting = true
	get_node("MeshInstance3D").visible = false
	
	Globals.hit.emit()
