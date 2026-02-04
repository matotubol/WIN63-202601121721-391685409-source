package com.sulake.habbo.help
{
   import com.sulake.core.assets.class_40;
   import com.sulake.core.window.class_1741;
   import com.sulake.habbo.localization.class_27;
   
   public interface INameChangeUI
   {
      
      function get localization() : class_27;
      
      function get assets() : class_40;
      
      function get myName() : String;
      
      function buildXmlWindow(param1:String, param2:uint = 1) : class_1741;
      
      function checkName(param1:String) : void;
      
      function changeName(param1:String) : void;
      
      function showView() : void;
      
      function hideView() : void;
   }
}

