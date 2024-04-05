#task_names=(
#'place_wine_at_rack_location'
#'place_cups'
#'light_bulb_in'
#'put_groceries_in_cupboard'
#'slide_block_to_color_target'
#'sweep_to_dustpan_of_size'
#'stack_blocks'
#'close_jar'
#'insert_onto_square_peg'
#'put_money_in_safe'
#'meat_off_grill'
#'open_drawer'
#'reach_and_drag'
#'push_buttons'
#'stack_cups'
#'turn_tap'
#'put_item_in_drawer'
#'place_shape_in_shape_sorter'
#)


task_names=(
'place_wine_at_rack_location'
'place_cups'
'light_bulb_in'
'put_groceries_in_cupboard'
'slide_block_to_color_target'
'sweep_to_dustpan_of_size'
'stack_blocks'
'close_jar'
'insert_onto_square_peg'
'put_money_in_safe'
'meat_off_grill'
'open_drawer'
'reach_and_drag'
'push_buttons'
'stack_cups'
'turn_tap'
'put_item_in_drawer'
'place_shape_in_shape_sorter'
)

for task in "${task_names[@]}"
  do
    python ../look_demos.py --task=${task}
  done