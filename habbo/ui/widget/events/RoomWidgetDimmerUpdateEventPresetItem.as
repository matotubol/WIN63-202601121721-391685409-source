package com.sulake.habbo.ui.widget.events
{
   public class RoomWidgetDimmerUpdateEventPresetItem
   {
      
      private var var_197:int = 0;
      
      private var var_230:int = 0;
      
      private var _color:uint = 0;
      
      private var var_1711:uint = 0;
      
      public function RoomWidgetDimmerUpdateEventPresetItem(param1:int, param2:int, param3:uint, param4:uint)
      {
         super();
         var_197 = param1;
         var_230 = param2;
         _color = param3;
         var_1711 = param4;
      }
      
      public function get id() : int
      {
         return var_197;
      }
      
      public function get type() : int
      {
         return var_230;
      }
      
      public function get color() : uint
      {
         return _color;
      }
      
      public function get light() : int
      {
         return var_1711;
      }
   }
}

