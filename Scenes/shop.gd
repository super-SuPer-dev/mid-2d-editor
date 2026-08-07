extends Node2D

func interact():
	GameManager.toggle_disable_player_movement()
	$ShopUI.visible = !$ShopUI.visible
	
func toggle_show_interact():
	$InteractionBox.visible = !$InteractionBox.visible

func _on_button_pressed() -> void:
	GameManager.remove_coin(10)
