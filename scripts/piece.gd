extends Control

@export var cell_size: Vector2i = Vector2i(128, 128)
@export var base_color: Color = Color(0.98, 0.953, 0.212)
@export var accent_color: Color = Color(0.212, 0.412, 0.984)
@export var outline_color: Color = Color(0.0, 0.0, 0.0)
@export var outline_thickness: float = 6.0

@export var shape_base: Array[Vector2i]
@export var shape_accent: Array[Vector2i]

var default_position = Vector2.ZERO

# internal
var _cells_local: Array[Vector2i] = []      # union of base+accent, rebased to start at (0,0)
var _occupied := {}                         # Set[Vector2i]

func _ready():
    visible = false
    mouse_filter = MOUSE_FILTER_IGNORE
    _build()

func _build():
    # clear previous nodes
    for c in get_children():
        c.queue_free()

    # rebase cells so the top-left occupied cell becomes (0,0)
    var all := shape_base.duplicate()
    all.append_array(shape_accent)
    if all.is_empty():
        size = Vector2.ZERO
        return

    var minx := INF
    var miny := INF
    var maxx := -INF
    var maxy := -INF
    for v in all:
        minx = min(minx, v.x)
        miny = min(miny, v.y)
        maxx = max(maxx, v.x)
        maxy = max(maxy, v.y)

    _cells_local.clear()
    _occupied.clear()
    for v in all:
        var l := Vector2i(v.x - int(minx), v.y - int(miny))
        _cells_local.append(l)
        _occupied[l] = true

    # draw blocks
    for cell in shape_base:
        var l := Vector2i(cell.x - int(minx), cell.y - int(miny))
        var r := ColorRect.new()
        r.size = Vector2(cell_size)
        r.position = Vector2(l) * Vector2(cell_size)
        r.color = base_color
        r.mouse_filter = Control.MOUSE_FILTER_IGNORE
        add_child(r)

    for cell in shape_accent:
        var l := Vector2i(cell.x - int(minx), cell.y - int(miny))
        var r := ColorRect.new()
        r.size = Vector2(cell_size)
        r.position = Vector2(l) * Vector2(cell_size)
        r.color = accent_color
        r.mouse_filter = Control.MOUSE_FILTER_IGNORE
        add_child(r)

    # size of the piece control (= bounding box)
    size = Vector2(
        (int(maxx - minx) + 1) * cell_size.x,
        (int(maxy - miny) + 1) * cell_size.y
    )

    queue_redraw()  # draw the outline

func _draw():
    if _cells_local.is_empty():
        return
    var cs := Vector2(cell_size)
    var t := outline_thickness
    var col := outline_color

    # For each occupied cell, draw the edges whose neighboring cell is empty
    for c in _cells_local:
        var p := Vector2(c) * cs
        # neighbors: up, right, down, left
        if not _occupied.has(c + Vector2i(0, -1)):
            draw_line(p, p + Vector2(cs.x, 0), col, t, true)                # top
        if not _occupied.has(c + Vector2i(1, 0)):
            draw_line(p + Vector2(cs.x, 0), p + Vector2(cs.x, cs.y), col, t, true)  # right
        if not _occupied.has(c + Vector2i(0, 1)):
            draw_line(p + Vector2(cs.x, cs.y), p + Vector2(0, cs.y), col, t, true)  # bottom
        if not _occupied.has(c + Vector2i(-1, 0)):
            draw_line(p + Vector2(0, cs.y), p, col, t, true)                 # left