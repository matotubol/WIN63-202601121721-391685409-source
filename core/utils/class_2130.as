package com.sulake.core.utils
{
   import flash.system.Capabilities;
   
   public class class_2130
   {
      
      private static var var_4077:int;
      
      private static var var_4049:int;
      
      private static var var_4047:Boolean;
      
      public function class_2130()
      {
         super();
      }
      
      public static function isVersionAtLeast(param1:int, param2:int) : Boolean
      {
         if(param1 < class_2130.majorVersion)
         {
            return true;
         }
         if(param1 == class_2130.majorVersion && param2 <= class_2130.minorVersion)
         {
            return true;
         }
         return false;
      }
      
      public static function get majorVersion() : int
      {
         parseVersion();
         return var_4077;
      }
      
      public static function get minorVersion() : int
      {
         parseVersion();
         return var_4049;
      }
      
      private static function parseVersion() : void
      {
         if(var_4047)
         {
            return;
         }
         var _loc2_:Array = Capabilities.version.split(" ");
         var _loc3_:Array = _loc2_[1].split(",");
         var _loc1_:int = int(_loc3_.length);
         var_4077 = _loc1_ >= 1 ? parseInt(_loc3_[0]) : 0;
         var_4049 = _loc1_ >= 2 ? parseInt(_loc3_[1]) : 0;
         var_4047 = true;
      }
   }
}

