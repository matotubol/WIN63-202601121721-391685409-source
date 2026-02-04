package com.sulake.core.window.utils
{
   import com.sulake.core.utils.class_2468;
   import com.sulake.core.utils.class_55;
   
   public class XMLPropertyArrayParser extends class_2468
   {
      
      public function XMLPropertyArrayParser()
      {
         super();
      }
      
      public static function parse(param1:XMLList) : Array
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:class_55 = new class_55();
         var _loc3_:Array = [];
         var _loc2_:Array = [];
         _loc4_ = int(class_2468.parseVariableList(param1,_loc6_,_loc3_));
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            _loc2_.push(new PropertyStruct(_loc6_.getKey(_loc5_),_loc6_.getWithIndex(_loc5_),_loc3_[_loc5_],true));
            _loc5_++;
         }
         return _loc2_;
      }
   }
}

