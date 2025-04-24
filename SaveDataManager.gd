extends Node
class_name SaveDataManager

var save_path_string : String = "user://GameDevLessonTeamProject.save"
var save_dictionary : Dictionary = {}
var has_loaded : bool = false
var save_task_id : int = -1 #It is guarenteed to be positive while performing task.

#Have scripts that want to save/load data call get_save_dictionary() in their "ready" function and then use "save_dictionary[data_name] = data_value" to store values.
func get_save_dictionary():
	if has_loaded == true:
		return save_dictionary
	else:
		await ready
		return save_dictionary

func _ready():
	load_game()
	has_loaded = true
	
func save_game():
	#Wait if already running
	if save_task_id != -1:
		print_debug("Waiting for save...")
		WorkerThreadPool.wait_for_group_task_completion(save_task_id)
		print_debug("Done waiting for save.")
	
	#Perform save and wait for completion
	print_debug("Begin multithread-save")
	save_task_id = WorkerThreadPool.add_task(save_game_process)
	WorkerThreadPool.wait_for_task_completion(save_task_id)
	
	#Completed save; next save can run now
	save_task_id = -1
	print_debug("Multithread-save completed!")

func save_game_process():
	print_debug("Saving...")
	#Prepare to write!
	var save_file = FileAccess.open(save_path_string, FileAccess.WRITE)
	
	#Turn the big ol' save_dictionary into something JSON likes.
	var json_string = JSON.stringify(save_dictionary)
	
	#Store it!
	save_file.store_line(json_string)
	print_debug("Save complete!")

func load_game():
	if not FileAccess.file_exists(save_path_string):
		print_debug("No file, time to make one!")
		save_game()
		
	var save_file = FileAccess.open(save_path_string, FileAccess.READ)
	
	#Get the stored, JSONified dictionary, parse it, and make sure it parsed good
	var json_string = save_file.get_line()
	var json = JSON.new()
	var parse_result = json.parse(json_string)
	if not parse_result == OK:
		print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
		return
	
	save_dictionary = json.data
	print_debug("Load complete!")
