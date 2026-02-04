package com.sulake.core.window.theme
{
   public interface IThemeManager
   {
      
      function getStyle(param1:String, param2:uint, param3:String) : uint;
      
      function getThemeAndIntent(param1:uint, param2:uint) : Object;
      
      function getIntents(param1:uint, param2:String, param3:uint) : Array;
      
      function getPropertyDefaults(param1:uint) : class_2458;
      
      function getThemes() : Array;
   }
}

