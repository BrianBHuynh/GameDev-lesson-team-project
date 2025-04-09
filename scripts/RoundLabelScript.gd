extends RichTextLabel

func update_wave_label():
	if RoundManager.level_cleared == false:
		text = "Wave: " + str(RoundManager.current_wave)
	else:
		text = "Clear!"

func _ready():
	RoundManager.connect("wave_changed", update_wave_label)
	update_wave_label()
