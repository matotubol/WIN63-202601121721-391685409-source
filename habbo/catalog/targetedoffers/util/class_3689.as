package com.sulake.habbo.catalog.targetedoffers.util
{
   import com.sulake.habbo.localization.class_27;
   import com.sulake.habbo.utils.FriendlyTime;
   
   public class class_3689
   {
      
      public function class_3689()
      {
         super();
      }
      
      public static function getStringFromSeconds(param1:class_27, param2:uint) : String
      {
         var _loc3_:int = Math.floor(param2 / 60 / 60);
         if(_loc3_ > 24)
         {
            return FriendlyTime.getFriendlyTime(param1,param2,"",1);
         }
         if(_loc3_ > 0)
         {
            return FriendlyTime.getLocalization(param1,"friendlytime.hours.short",_loc3_);
         }
         return convertSecondsToTime(param2);
      }
      
      public static function convertSecondsToTime(param1:int) : String
      {
         var _loc2_:int = Math.floor(param1 / 60 / 60);
         var _loc4_:int = Math.floor((param1 - _loc2_ * 60 * 60) / 60);
         var _loc3_:int = param1 - _loc2_ * 60 * 60 - _loc4_ * 60;
         var _loc5_:String = "";
         if(_loc2_ > 0)
         {
            _loc5_ = _loc2_ + ":";
         }
         _loc5_ = _loc4_ < 10 ? _loc5_ + "0" + _loc4_ : _loc5_ + _loc4_;
         if(_loc2_ == 0)
         {
            _loc5_ += ":";
            _loc5_ = _loc3_ < 10 ? _loc5_ + "0" + _loc3_ : _loc5_ + _loc3_;
         }
         return _loc5_;
      }
   }
}

