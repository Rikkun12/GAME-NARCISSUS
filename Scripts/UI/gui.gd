'''extends CanvasLayer

const health_bar_size = 10
const health_offset = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in player_data.life:
		var new_health = Sprite2D.new()
		new_health.texture = $player_life.texture
		new_health.hframes = $player_life.hframes
		$player_life.add_child(new_health)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	display_HP()

func display_HP():
	for health in $player_life.get_children():
		var index = health.get_index()
		var x = (index % health_bar_size) * health_offset
		var y = (index / health_bar_size) * health_offset
		health.position = Vector2(x,y)
		
		var last_health = floor(player_data.life)
		if index > last_health:
			health.frame = 0
		if index == last_health:
			health.frame = (player_data.life - last_health) * 4
		if index < last_health:
			health.frame = 4
'''
