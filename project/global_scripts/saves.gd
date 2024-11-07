extends Node

#For this script you should implement a few functions, save_file, to save an individual file, save_game to save the current game state (possibly whatever was already ported to a dictionary) and load_file/load_game
#These scripts should save data into a json file and be able to extract them from said json file, look at the JSON class for this
#Also look at file access and diraccess classes
#https://docs.godotengine.org/en/stable/tutorials/io/saving_games.html
#If you want to save objects, you should turn them into serializabled dictionaries first, then have a function to turn them back. You can ask the other groups for this.

func save_file(file: Dictionary) -> void:
	pass

#This function has no arguments as either you grab data from other classes OR have them import things into a dictionary that you can save
func save_game() -> void:
	pass

#Insert the location of what you're trying to get, then grab said file before turning it from JSON to either a dictionary or it's origional form
func load_file(file_location: String) -> Dictionary:
	return {
	}

#load the game from the preset location which save_game is located, then store it somewhere other scripts can access
func load_game() -> void:
	pass

#You can totally just make a dictionary and save said dictionary each time save and load game is called. Have other scripts add persistant data to the dictionary and read from that dictionary on startup or whenever they need
