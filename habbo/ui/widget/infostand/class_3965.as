package com.sulake.habbo.ui.widget.infostand
{
   public class class_3965
   {
      
      public function class_3965()
      {
         super();
      }
      
      public static function formatSeconds(param1:Number) : String
      {
         var _loc3_:uint = Math.floor(param1);
         var _loc4_:uint = Math.floor(_loc3_ / 3600);
         var _loc7_:int = _loc4_ * 3600;
         var _loc6_:uint = (_loc3_ - _loc7_) / 60;
         var _loc5_:uint = _loc3_ - _loc7_ - _loc6_ * 60;
         var _loc8_:String = _loc4_ + ":";
         var _loc9_:String = (_loc6_ < 10 ? "0" : "") + _loc6_ + ":";
         var _loc2_:String = (_loc5_ < 10 ? "0" : "") + _loc5_;
         return _loc8_ + _loc9_ + _loc2_;
      }
   }
}

