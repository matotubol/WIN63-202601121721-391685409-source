package com.sulake.habbo.friendlist
{
   public class class_2242
   {
      
      public static const NONE:int = 0;
      
      public static const const_347:int = 1;
      
      public static const SMILE:int = 2;
      
      public static const BOBBA:int = 3;
      
      private static const _asString:Array = ["none","heart","smile","bobba"];
      
      public function class_2242()
      {
         super();
      }
      
      public static function statusAsString(param1:int) : String
      {
         return _asString[param1];
      }
      
      public static function get displayableStatuses() : Array
      {
         return [1,2,3];
      }
      
      public static function stringAsStatus(param1:String) : int
      {
         for each(var _loc2_ in displayableStatuses)
         {
            if(statusAsString(_loc2_) == param1)
            {
               return _loc2_;
            }
         }
         return 0;
      }
   }
}

