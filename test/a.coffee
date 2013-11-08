global_func_args = (a, b) ->
  true

global_func = ->
  true

@fn = ->

global_func_single = -> true
global_func_single_args = (a, b) -> true
global_func_single_args_fat_arrow = (a, b) => true
global_func_single_args_fat_arrow_deconstruct = ({ @a, @b }) => true

String::prototype_single = -> true
String::prototype_single_args = (a, b) -> true
String::prototype_single_args_empty = () -> true
String::prototype_single_args_deconstruct = ({ @a, @b }) -> true

member_oneline = asd : -> true
member_oneline_args = asd : (a, b) -> true
member_oneline_args_empty = asd : () -> true
member_oneline_deconstruct = asd : ({@a, @b }) -> true
member =
  oneline             : -> true
  oneline_empty_args  : () -> true
  seperated_empty_ags : () ->
    true
  seperated           : ->
    true
  seperated_args_deconstruct : ({@a, @b}) =>
    true

