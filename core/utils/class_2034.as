package com.sulake.core.utils
{
   import flash.system.Capabilities;
   
   public class class_2034
   {
      
      private static var var_4077:int;
      
      private static var var_5116:int;
      
      private static var var_3932:String;
      
      init();
      
      public function class_2034()
      {
         super();
      }
      
      public static function get majorVersion() : int
      {
         return var_4077;
      }
      
      public static function get majorRevision() : int
      {
         return var_5116;
      }
      
      public static function get operatingSystem() : String
      {
         return var_3932;
      }
      
      private static function init() : void
      {
         var _loc1_:String = Capabilities.version;
         var _loc3_:Array = _loc1_.split(" ");
         var _loc2_:Array = _loc3_[1].split(",");
         var_3932 = _loc3_[0];
         var_4077 = parseInt(_loc2_[0]);
         var_5116 = parseInt(_loc2_[1]);
      }
   }
}

