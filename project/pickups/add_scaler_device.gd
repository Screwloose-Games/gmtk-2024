class_name AddScaleDeviceEffect
extends CollectableEffect

func get_collected_by(collector: CollectorComponent):
	collector.character_scaler.activate()
