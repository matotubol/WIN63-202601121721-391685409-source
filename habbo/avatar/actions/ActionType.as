package com.sulake.habbo.avatar.actions
{
   public class ActionType
   {
      
      private var var_197:int;
      
      private var _value:int;
      
      private var var_2010:Array = [];
      
      private var var_2328:Boolean = true;
      
      private var var_3351:Boolean = true;
      
      public function ActionType(param1:XML)
      {
         super();
         var_197 = parseInt(param1.@value);
         _value = parseInt(param1.@value);
         var _loc3_:String = String(param1.@prevents);
         if(_loc3_ != "")
         {
            var_2010 = _loc3_.split(",");
         }
         var_2328 = String(param1.@preventheadturn) == "true";
         var _loc2_:String = String(param1.@animated);
         if(_loc2_ == "")
         {
            var_3351 = true;
         }
         else
         {
            var_3351 = _loc2_ == "true";
         }
      }
      
      public function get id() : int
      {
         return var_197;
      }
      
      public function get value() : int
      {
         return _value;
      }
      
      public function get prevents() : Array
      {
         return var_2010;
      }
      
      public function get preventHeadTurn() : Boolean
      {
         return var_2328;
      }
      
      public function get isAnimated() : Boolean
      {
         return var_3351;
      }
   }
}

