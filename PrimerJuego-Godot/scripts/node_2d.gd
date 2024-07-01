extends Node2D
@export var enemy_scene: PackedScene
var score

func _ready():
	new_game()

func _on_player_hit(): #muere
	game_over()
	
func game_over():
	$enemyTimer.stop()
	$scoreTimer2.stop()
	
func new_game():
	score = 0
	$player.start($Marker2D.position)
	$startTimer3.start()
	
func _on_enemy_timer_timeout():
	var enemy = enemy_scene.instantiate()
	var enemy_spawn_location = $enemyPath/enemyPathFollow
	enemy_spawn_location.progress_ratio = randf()
	var direction = enemy_spawn_location.rotation + PI / 2
	enemy.position = enemy_spawn_location.position
	
	direction += randf_range(-PI/4,PI/4)
	enemy.rotation = direction
	
	var velocity = Vector2(randf_range(100,250),0)
	enemy.linear_velocity = velocity.rotated(direction)
	add_child(enemy)
	
func _on_score_timer_2_timeout():
	score += 1

func _on_start_timer_3_timeout():
	$enemyTimer.start()
	$scoreTimer2.start()


