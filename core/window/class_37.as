package com.sulake.core.window
{
   import com.sulake.core.utils.class_55;
   import com.sulake.core.window.components.class_2052;
   import com.sulake.core.window.utils.INotify;
   import com.sulake.core.window.utils.class_2001;
   import flash.geom.Rectangle;
   
   public interface class_37
   {
      
      function create(param1:String, param2:uint, param3:uint, param4:uint, param5:Rectangle, param6:Function = null, param7:String = "", param8:uint = 0, param9:Array = null, param10:class_1741 = null, param11:Array = null, param12:String = "") : class_1741;
      
      function destroy(param1:class_1741) : void;
      
      function buildFromXML(param1:XML, param2:uint = 1, param3:class_55 = null) : class_1741;
      
      function windowToXMLString(param1:class_1741) : String;
      
      function getDesktop(param1:uint) : class_2052;
      
      function notify(param1:String, param2:String, param3:Function, param4:uint = 0) : INotify;
      
      function confirm(param1:String, param2:String, param3:uint, param4:Function) : class_2001;
      
      function confirmWithModal(param1:String, param2:String, param3:uint, param4:Function) : class_2001;
      
      function findWindowByName(param1:String) : class_1741;
      
      function findWindowByTag(param1:String) : class_1741;
      
      function groupWindowsWithTag(param1:String, param2:Array, param3:int = 0) : uint;
   }
}

