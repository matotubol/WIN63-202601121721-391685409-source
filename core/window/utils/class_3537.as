package com.sulake.core.window.utils
{
   import com.sulake.core.window.enum.class_1911;
   import flash.utils.Dictionary;
   
   public class class_3537 extends class_1911
   {
      
      public function class_3537()
      {
         super();
      }
      
      public static function fillTables(param1:Dictionary, param2:Dictionary = null) : void
      {
         var _loc3_:String = null;
         param1["background"] = 2;
         param1["bitmap"] = 21;
         param1["border"] = 30;
         param1["boxsizer"] = 17;
         param1["border_notify"] = 33;
         param1["bubble"] = 45;
         param1["bubble_pointer_up"] = 46;
         param1["bubble_pointer_right"] = 47;
         param1["bubble_pointer_down"] = 48;
         param1["bubble_pointer_left"] = 49;
         param1["button"] = 60;
         param1["button_thick"] = 61;
         param1["button_icon"] = 62;
         param1["button_group_left"] = 67;
         param1["button_group_center"] = 68;
         param1["button_group_right"] = 69;
         param1["checkbox"] = 70;
         param1["closebutton"] = 72;
         param1["container"] = 4;
         param1["container_button"] = 41;
         param1["display_object_wrapper"] = 20;
         param1["dropmenu"] = 102;
         param1["dropmenu_item"] = 103;
         param1["droplist"] = 105;
         param1["droplist_item"] = 106;
         param1["formatted_text"] = 15;
         param1["frame"] = 35;
         param1["frame_notify"] = 38;
         param1["header"] = 6;
         param1["html"] = 11;
         param1["icon"] = 1;
         param1["iconbutton"] = 79;
         param1["itemgrid"] = 52;
         param1["itemgrid_horizontal"] = 54;
         param1["itemgrid_vertical"] = 53;
         param1["itemlist"] = 50;
         param1["itemlist_horizontal"] = 51;
         param1["itemlist_vertical"] = 50;
         param1["label"] = 12;
         param1["maximizebox"] = 74;
         param1["menu"] = 100;
         param1["menu_item"] = 101;
         param1["submenu"] = 104;
         param1["minimizebox"] = 73;
         param1["notify"] = 9;
         param1["null"] = 0;
         param1["password"] = 78;
         param1["radiobutton"] = 71;
         param1["region"] = 5;
         param1["restorebox"] = 75;
         param1["scaler"] = 120;
         param1["scaler_horizontal"] = 122;
         param1["scaler_vertical"] = 121;
         param1["scrollbar_horizontal"] = 130;
         param1["scrollbar_vertical"] = 131;
         param1["scrollbar_slider_button_up"] = 139;
         param1["scrollbar_slider_button_down"] = 137;
         param1["scrollbar_slider_button_left"] = 138;
         param1["scrollbar_slider_button_right"] = 136;
         param1["scrollbar_slider_bar_horizontal"] = 132;
         param1["scrollbar_slider_bar_vertical"] = 133;
         param1["scrollbar_slider_track_horizontal"] = 134;
         param1["scrollbar_slider_track_vertical"] = 135;
         param1["scrollable_itemlist"] = 55;
         param1["scrollable_itemlist_vertical"] = 56;
         param1["scrollable_itemgrid_vertical"] = 140;
         param1["scrollable_itemlist_horizontal"] = 57;
         param1["selector"] = 42;
         param1["selector_list"] = 43;
         param1["static_bitmap"] = 23;
         param1["submenu"] = 104;
         param1["tab_button"] = 93;
         param1["tab_container_button"] = 94;
         param1["tab_context"] = 91;
         param1["tab_content"] = 90;
         param1["tab_selector"] = 92;
         param1["text"] = 10;
         param1["input"] = 77;
         param1["link"] = 14;
         param1["toolbar"] = 7;
         param1["tooltip"] = 8;
         param1["widget"] = 16;
         if(param2 != null)
         {
            for(_loc3_ in param1)
            {
               param2[param1[_loc3_]] = _loc3_;
            }
         }
      }
   }
}

