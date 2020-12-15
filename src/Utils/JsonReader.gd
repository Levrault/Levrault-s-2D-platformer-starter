extends Node

# Read and parse Json file
static func get_json(file_path: String) -> Dictionary:
	var file := File.new()

	if file.open(file_path, file.READ) != OK:
		print("get_json: file cannot been read")
		return {}

	var text_content := file.get_as_text()
	file.close()
	var data_parse = JSON.parse(text_content)
	if data_parse.error != OK:
		print("get_json: error while parsing")
		return {}
		
	data_parse.result.erase("__editor")
	return data_parse.result
