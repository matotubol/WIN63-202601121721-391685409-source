package com.sulake.core.window.utils
{
   import com.sulake.core.window.enum.class_2051;
   import flash.utils.Dictionary;
   
   public class class_3794 extends class_2051
   {
      
      public function class_3794()
      {
         super();
      }
      
      public static function fillTables(param1:Dictionary, param2:Dictionary = null) : void
      {
         param1["null"] = 0;
         param1["bound_to_parent_rect"] = 32;
         param1["child_window"] = 33;
         param1["embedded_controller"] = 51;
         param1["expand_to_accommodate_children"] = 131072;
         param1["input_event_processor"] = 1;
         param1["internal_event_handling"] = 9;
         param1["mouse_dragging_target"] = 32768;
         param1["mouse_dragging_trigger"] = 257;
         param1["mouse_scaling_target"] = 65536;
         param1["mouse_scaling_trigger"] = 12288;
         param1["horizontal_mouse_scaling_trigger"] = 4096;
         param1["vertical_mouse_scaling_trigger"] = 8192;
         param1["observe_parent_input_events"] = 5;
         param1["parent_window"] = 1;
         param1["resize_to_accommodate_children"] = 147456;
         param1["relative_horizontal_scale_center"] = 192;
         param1["relative_horizontal_scale_fixed"] = 0;
         param1["relative_horizontal_scale_move"] = 64;
         param1["relative_horizontal_scale_strech"] = 128;
         param1["relative_scale_center"] = 3264;
         param1["relative_scale_fixed"] = 0;
         param1["relative_scale_move"] = 1088;
         param1["relative_scale_strech"] = 2176;
         param1["relative_vertical_scale_center"] = 3072;
         param1["relative_vertical_scale_fixed"] = 0;
         param1["relative_vertical_scale_move"] = 1024;
         param1["relative_vertical_scale_strech"] = 2048;
         param1["on_resize_align_left"] = 0;
         param1["on_resize_align_right"] = 262144;
         param1["on_resize_align_center"] = 786432;
         param1["on_resize_align_top"] = 0;
         param1["on_resize_align_bottom"] = 1048576;
         param1["on_resize_align_middle"] = 3145728;
         param1["on_accommodate_align_left"] = 0;
         param1["on_accommodate_align_right"] = 262144;
         param1["on_accommodate_align_center"] = 786432;
         param1["on_accommodate_align_top"] = 0;
         param1["on_accommodate_align_bottom"] = 1048576;
         param1["on_accommodate_align_middle"] = 3145728;
         param1["route_input_events_to_parent"] = 3;
         param1["use_parent_graphic_context"] = 16;
         param1["draggable_with_mouse"] = 33025;
         param1["scalable_with_mouse"] = 77824;
         param1["reflect_horizontal_resize_to_parent"] = 4194304;
         param1["reflect_vertical_resize_to_parent"] = 8388608;
         param1["reflect_resize_to_parent"] = 12582912;
         param1["force_clipping"] = 1073741824;
         param1["inherit_caption"] = 2147483648;
         if(param2 != null)
         {
            for(var _loc3_ in param1)
            {
               param2[param1[_loc3_]] = _loc3_;
            }
         }
      }
   }
}

