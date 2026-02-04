package com.sulake.room.utils
{
   public class class_2119
   {
      
      public function class_2119()
      {
         super();
      }
      
      public static function checkRequiredAttributes(param1:Object, param2:Array) : Boolean
      {
         var _loc3_:XML = null;
         var _loc4_:XMLList = null;
         if(param1 == null || param2 == null)
         {
            return false;
         }
         var _loc5_:int = 0;
         if(param1 is XML)
         {
            _loc3_ = param1 as XML;
            _loc5_ = 0;
            while(_loc5_ < param2.length)
            {
               if(_loc3_.attribute(String(param2[_loc5_])).length() == 0)
               {
                  return false;
               }
               _loc5_++;
            }
         }
         else
         {
            if(!(param1 is XMLList))
            {
               return false;
            }
            _loc4_ = param1 as XMLList;
            _loc5_ = 0;
            while(_loc5_ < param2.length)
            {
               if(_loc3_.attribute(String(param2[_loc5_])).length() == 0)
               {
                  return false;
               }
               _loc5_++;
            }
         }
         return true;
      }
   }
}

