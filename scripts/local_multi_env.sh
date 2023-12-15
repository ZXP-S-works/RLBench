run()
{
args="
--tasks=${tasks}
--save_path=/home/zxp/projects/C2F_bi_equi/c2f_bi_equi_data/${train_val}
--image_size=128,128
--renderer=opengl
--episodes_per_task=100
--processes=1
--all_variations=False
--variations=0
"

jn=${run_name}_${gpu}

./local_env.sh ${args}
}

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
'meat_off_grill'
'open_drawer'
'reach_and_drag'
'push_buttons'
'stack_cups'
'turn_tap'
'put_item_in_drawer'
'place_shape_in_shape_sorter'
)

for tasks in "${task_names[@]}"
  do
    for train_val in 'val'
    do
      run
      done
  done