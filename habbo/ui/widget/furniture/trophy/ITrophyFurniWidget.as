package com.sulake.habbo.ui.widget.furniture.trophy
{
   import com.sulake.core.assets.class_40;
   import com.sulake.habbo.window.class_38;
   
   public interface ITrophyFurniWidget
   {
      
      function get assets() : class_40;
      
      function get name() : String;
      
      function get date() : String;
      
      function get color() : int;
      
      function get windowManager() : class_38;
      
      function get message() : String;
   }
}

