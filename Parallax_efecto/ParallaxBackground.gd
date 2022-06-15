extends ParallaxBackground

func _ready():
	set_process(true)
	
func _process(delta):
	scroll_base_offset -= Vector2(100, 0)* delta
