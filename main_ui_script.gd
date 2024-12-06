extends CanvasLayer
class_name MainUI

@onready var flash = $ScreenFlash

signal screen_flash_finished

func _ready():
	GlobalVars.main_ui = self

#region Screen Flash
func dual_screen_flash(start_color : Color, mid_color : Color, end_color : Color, in_time : float, out_time : float):
	await screen_flash(start_color, mid_color, in_time)
	screen_flash(mid_color, end_color, out_time)

func screen_flash(start_color : Color, end_color : Color, time : float):
	flash.modulate = start_color
	var tween = get_tree().create_tween()
	if tween != null:
		tween.tween_property(flash, "modulate", end_color, time)
		await tween.finished
		screen_flash_finished.emit()
#endregion
