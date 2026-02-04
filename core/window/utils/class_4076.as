package com.sulake.core.window.utils
{
   public class class_4076 implements class_1923
   {
      
      protected var var_120:Vector.<class_2142> = new Vector.<class_2142>();
      
      public function class_4076()
      {
         super();
      }
      
      public function get numChildren() : int
      {
         return var_120.length;
      }
      
      public function getChildAt(param1:int) : class_2142
      {
         return var_120[param1];
      }
      
      public function getChildByID(param1:int) : class_2142
      {
         var _loc2_:* = null;
         for each(_loc2_ in var_120)
         {
            if(_loc2_.id == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function getChildByName(param1:String) : class_2142
      {
         var _loc2_:* = null;
         for each(_loc2_ in var_120)
         {
            if(_loc2_.name == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function getChildIndex(param1:class_2142) : int
      {
         return var_120.indexOf(param1);
      }
      
      public function groupChildrenWithID(param1:uint, param2:Array) : uint
      {
         var _loc4_:* = null;
         for each(_loc4_ in var_120)
         {
            if(_loc4_.id == param1)
            {
               param2.push(_loc4_);
               var _loc3_:uint = 0 + 1;
            }
         }
         return 0;
      }
   }
}

