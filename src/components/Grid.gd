extends Area2D
class_name Grid

signal mouse_entered_cell(cell)
signal mouse_exited_cell(cell)
signal mouse_input_cell(input, cell)


const CELL_HEIGHT:int = 64
const CELL_WIDTH:int = 64
const HALF_CELL:Vector2 = Vector2(CELL_WIDTH / 2, CELL_HEIGHT / 2)

const NO_CELL: Vector2 = Vector2(-1,-1)

var selected_cell: Vector2 = NO_CELL

onready var collision: CollisionShape2D = $CollisionShape2D
onready var size: Vector2 = collision.get_shape().get_extents()


func _ready() -> void:
	self.connect("input_event", self, "_on_Grid_input_event")
	self.connect("mouse_exited", self, "_on_Grid_mouse_exited")
	

func _on_Grid_input_event(viewport: Viewport, event : InputEvent, shape_idx: int):
	if event is InputEventMouse:
		var cell = world_to_grid(event.position)
		
		if not is_in_grid(cell):
			cell = NO_CELL
					
		if cell != selected_cell:			
			if selected_cell != NO_CELL:
				emit_signal("mouse_exited_cell", selected_cell)
			
			if cell != NO_CELL:	
				emit_signal("mouse_entered_cell", cell)
			
			selected_cell = cell
			
		if event is InputEventMouseButton:
			emit_signal("mouse_input_cell", event, cell)


func _on_Grid_mouse_exited():
	if selected_cell != NO_CELL:
		emit_signal("mouse_exited_cell", selected_cell)
		selected_cell = NO_CELL
		
		
func is_in_grid(cell: Vector2) -> bool:
	return cell.x >= 0 \
		and cell.y >= 0 \
		and cell.x < size.x \
		and cell.y < size.y


func world_to_grid(position: Vector2) -> Vector2:
	var pos_without_offset = position - global_position
	return Vector2(floor(pos_without_offset.x / CELL_WIDTH),
		floor(pos_without_offset.y / CELL_HEIGHT))


func grid_to_world(cell: Vector2) -> Vector2:
	return Vector2(cell.x * CELL_WIDTH, cell.y * CELL_HEIGHT) \
		+ global_position \
		+ HALF_CELL
	
