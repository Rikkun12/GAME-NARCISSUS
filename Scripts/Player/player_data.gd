# player_data.gd
extends Node

# Define the signal at the top of the script.
signal health_changed

# Variables for health. Using a setter makes emitting the signal easy.
var max_life: int = 10
var life: float = 10.0:
	set(value):
		# Clamp the value so it doesn't go below 0 or above max_life.
		life = clamp(value, 0.0, max_life)
		# EMIT THE SIGNAL! Any node connected to this will now react.
		health_changed.emit()

# A function to test taking damage.
func take_damage(amount: float):
	self.life -= amount # The setter and signal are automatically called here.
