extends Node

@onready var collectable_scale_device: CollectableArea = $".."
@onready var audio_stream_player: AudioStreamPlayer = %CollectDeviceAudio
@onready var device_collect_dialog: CanvasLayer = %DeviceCollectDialog

func _ready():
	collectable_scale_device.collected.connect(_on_collected)

func _on_collected():
	audio_stream_player.play()
	device_collect_dialog.show()
	var player = get_tree().get_first_node_in_group("Player")
	player.process_mode = Node.PROCESS_MODE_DISABLED
	await device_collect_dialog.dismissed
	collectable_scale_device.queue_free.call_deferred()
