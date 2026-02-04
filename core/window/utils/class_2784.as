package com.sulake.core.window.utils
{
   import flash.utils.Dictionary;
   
   public class class_2784
   {
      
      public function class_2784()
      {
         super();
      }
      
      public static function fillTables(param1:Dictionary, param2:Dictionary = null) : void
      {
         var _loc3_:String = null;
         param1["default"] = 0;
         param1["active"] = 1;
         param1["focused"] = 2;
         param1["hovering"] = 4;
         param1["selected"] = 8;
         param1["pressed"] = 16;
         param1["disabled"] = 32;
         param1["locked"] = 64;
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

