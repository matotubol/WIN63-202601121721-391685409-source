package com.sulake.habbo.window.theme
{
   import com.sulake.core.window.enum.PivotPoint;
   import com.sulake.core.window.graphics.SkinContainer;
   import com.sulake.core.window.theme.IThemeManager;
   import com.sulake.core.window.theme.PropertyMap;
   import com.sulake.core.window.theme.class_2458;
   import com.sulake.core.window.theme.class_2901;
   import com.sulake.core.window.utils.class_3398;
   import com.sulake.habbo.window.widgets.IlluminaBorderWidget;
   import com.sulake.habbo.window.widgets.class_2086;
   import flash.utils.Dictionary;
   
   public class ThemeManager implements IThemeManager
   {
      
      private static const const_1031:int = 100;
      
      private static const THEMES:Array = ["None","Volter","Ubuntu","Illumina Light","Illumina Dark","Icon","Legacy border"];
      
      private var var_693:Dictionary;
      
      private var var_779:SkinContainer;
      
      public function ThemeManager(param1:SkinContainer)
      {
         super();
         var_779 = param1;
         var _loc5_:PropertyMap = new PropertyMap();
         _loc5_.addBoolean("always_show_selection",false);
         null.addEnumeration("antialias_type","advanced",["normal","advanced"]);
         null.addString("asset_uri",null);
         null.addBoolean("auto_arrange_items",true);
         null.addEnumeration("auto_size","none",["none","left","center","right"]);
         null.addString("bitmap_asset_name",null);
         null.addBoolean("border",false);
         null.addHex("border_color",0);
         null.addBoolean("condense_white",false);
         null.addBoolean("container_resize_to_columns",false);
         null.addEnumeration("direction","down",["up","down","left","right"]);
         null.addBoolean("display_as_password",false);
         null.addBoolean("display_raw",false);
         null.addBoolean("editable",true);
         null.addHex("etching_color",0);
         null.addBoolean("fit_size_to_contents",false);
         null.addBoolean("focus_capturer",false);
         null.addBoolean("greyscale",false);
         null.addEnumeration("grid_fit_type","pixel",["pixel","none","subpixel"]);
         null.addBoolean("handle_bitmap_disposing",true);
         null.addString("help_page","");
         null.addEnumeration("link_target","default",["default","_blank","_parent","_self","_top","internal"]);
         null.addInt("spacing",0);
         null.addInt("margin_left",0);
         null.addInt("margin_top",0);
         null.addInt("margin_right",0);
         null.addInt("margin_bottom",0);
         null.addInt("max_chars",0);
         null.addInt("max_lines",0);
         null.addArray("item_array",[]);
         null.addBoolean("mouse_wheel_enabled",true);
         null.addBoolean("multiline",false);
         null.addEnumeration("pivot_point",PivotPoint.PIVOT_NAMES[0],class_2901.PIVOT_POINT_RANGE);
         null.addInt("pointer_offset",0);
         null.addBoolean("resize_on_item_update",false);
         null.addBoolean("inverse_resize_on_item_update",false);
         null.addString("restrict",null);
         null.addBoolean("scale_to_fit_items",false);
         null.addString("scrollable","");
         null.addNumber("scroll_step_h",-1);
         null.addNumber("scroll_step_v",-1);
         null.addBoolean("selectable",true);
         null.addBoolean("stretched_x",true);
         null.addBoolean("stretched_y",true);
         null.addHex("text_color",0);
         null.addEnumeration("text_style","regular",class_3398.getStyleNameArrayRef());
         null.addString("tool_tip_caption","");
         null.addUint("tool_tip_delay",500);
         null.addBoolean("tool_tip_is_dynamic",false);
         null.addBoolean("interactive_cursor_disabled",false);
         null.addBoolean("vertical",false);
         null.addEnumeration("widget_type","",class_2086.WIDGET_TYPES);
         null.addBoolean("word_wrap",false);
         null.addNumber("zoom_x",1);
         null.addNumber("zoom_y",1);
         null.addBoolean("open_upward",false);
         null.addBoolean("keep_open_on_deactivate",false);
         null.addInt("padding_horizontal",6);
         null.addInt("padding_vertical",6);
         null.addString("overflow_replace","");
         null.addBoolean("wrap_x",false);
         null.addBoolean("wrap_y",false);
         null.addNumber("rotation",0);
         null.addEnumeration("illumina_border:border_style","illumina_light",IlluminaBorderWidget.BORDER_STYLES);
         var_693 = new Dictionary();
         var_693["None"] = new Theme("None",false,0,4294967295,null);
         var _loc4_:int = 0;
         while(var_779.skinRendererExists(1,_loc4_))
         {
            _loc4_++;
         }
         var_693["Icon"] = new Theme("Icon",false,0,_loc4_,null);
         var _loc2_:int = 0;
         while(var_779.skinRendererExists(30,_loc2_) && _loc2_ < 100)
         {
            _loc2_++;
         }
         var_693["Legacy border"] = new Theme("Legacy border",false,0,_loc2_,null);
         var_693["Volter"] = new Theme("Volter",true,0,3,null.clone());
         var _loc3_:PropertyMap = null.clone();
         null.addEnumeration("antialias_type","advanced",["normal","advanced"]);
         null.addEnumeration("text_style","u_regular",class_3398.getStyleNameArrayRef());
         var_693["Ubuntu"] = new Theme("Ubuntu",true,3,5,null);
         _loc3_ = null.clone();
         null.addEnumeration("antialias_type","advanced",["normal","advanced"]);
         null.addHex("etching_color",3003121663);
         null.addEnumeration("text_style","il_regular",class_3398.getStyleNameArrayRef());
         var_693["Illumina Light"] = new Theme("Illumina Light",true,100,100,null);
         _loc3_ = null.clone();
         null.addEnumeration("illumina_border:border_style","illumina_dark",IlluminaBorderWidget.BORDER_STYLES);
         var_693["Illumina Dark"] = new Theme("Illumina Dark",true,200,100,null);
      }
      
      public function getStyle(param1:String, param2:uint, param3:String) : uint
      {
         var _loc4_:int = 0;
         var _loc6_:* = 0;
         if(param1 == "None")
         {
            return int(param3);
         }
         var _loc5_:Theme = var_693[param1];
         if(_loc5_ == null)
         {
            return 0;
         }
         _loc4_ = 0;
         while(_loc4_ < _loc5_.styleCount)
         {
            _loc6_ = _loc5_.baseStyle + _loc4_;
            if(param3 == var_779.getIntentByTypeAndStyle(param2,_loc6_))
            {
               return _loc6_;
            }
            _loc4_++;
         }
         return _loc5_.baseStyle;
      }
      
      public function getThemeAndIntent(param1:uint, param2:uint) : Object
      {
         var _loc4_:String = var_779.getIntentByTypeAndStyle(param1,param2);
         if(param1 == 1)
         {
            return {
               "theme":"Icon",
               "intent":_loc4_
            };
         }
         if(param1 == 30 && param2 < 100)
         {
            return {
               "theme":"Legacy border",
               "intent":_loc4_
            };
         }
         for each(var _loc3_ in var_693)
         {
            if(_loc3_.isReal && _loc3_.coversStyle(param2))
            {
               return {
                  "theme":_loc3_.name,
                  "intent":_loc4_
               };
            }
         }
         return {
            "theme":"None",
            "intent":_loc4_
         };
      }
      
      public function getIntents(param1:uint, param2:String, param3:uint) : Array
      {
         var _loc4_:Array = [];
         if(param2 != "None")
         {
            var _loc6_:Theme = var_693[param2];
            var _loc5_:int = 0;
            while(0 < null.styleCount)
            {
               var _loc7_:String = var_779.getIntentByTypeAndStyle(param1,null.baseStyle + 0);
               if(_loc7_ != null)
               {
                  _loc4_.push(null);
               }
               _loc5_++;
            }
         }
         if(_loc4_.length == 0)
         {
            _loc4_.push(param3.toString());
         }
         return _loc4_;
      }
      
      public function getPropertyDefaults(param1:uint) : class_2458
      {
         var _loc2_:PropertyMap = null;
         for each(var _loc3_ in var_693)
         {
            if(_loc3_.isReal && _loc3_.coversStyle(param1))
            {
               _loc2_ = _loc3_.propertyDefaults;
               break;
            }
         }
         if(_loc2_ == null)
         {
            _loc2_ = new PropertyMap();
         }
         return _loc2_;
      }
      
      public function getThemes() : Array
      {
         return THEMES;
      }
   }
}

