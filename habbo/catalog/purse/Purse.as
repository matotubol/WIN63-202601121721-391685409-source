package com.sulake.habbo.catalog.purse
{
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   
   public class Purse implements class_1831
   {
      
      private var var_3831:int = 0;
      
      private var var_2546:Dictionary = new Dictionary();
      
      private var var_3642:int = 0;
      
      private var var_3764:int = 0;
      
      private var var_4740:Boolean = false;
      
      private var var_4545:int = 0;
      
      private var var_4257:int = 0;
      
      private var _isExpiring:Boolean = false;
      
      private var var_4373:int = 0;
      
      private var var_4368:int;
      
      private var var_331:int;
      
      private var var_3240:int = 0;
      
      private var var_3311:int = 0;
      
      public function Purse()
      {
         super();
      }
      
      public function get credits() : int
      {
         return var_3831;
      }
      
      public function set credits(param1:int) : void
      {
         var_331 = getTimer();
         var_3831 = param1;
      }
      
      public function get clubDays() : int
      {
         return var_3642;
      }
      
      public function set clubDays(param1:int) : void
      {
         var_331 = getTimer();
         var_3642 = param1;
      }
      
      public function get clubPeriods() : int
      {
         return var_3764;
      }
      
      public function set clubPeriods(param1:int) : void
      {
         var_331 = getTimer();
         var_3764 = param1;
      }
      
      public function get hasClubLeft() : Boolean
      {
         return var_3642 > 0 || var_3764 > 0;
      }
      
      public function get isVIP() : Boolean
      {
         return var_4740;
      }
      
      public function get isExpiring() : Boolean
      {
         return _isExpiring;
      }
      
      public function set isExpiring(param1:Boolean) : void
      {
         _isExpiring = param1;
      }
      
      public function set isVIP(param1:Boolean) : void
      {
         var_4740 = param1;
      }
      
      public function get pastClubDays() : int
      {
         return var_4545;
      }
      
      public function set pastClubDays(param1:int) : void
      {
         var_331 = getTimer();
         var_4545 = param1;
      }
      
      public function get pastVipDays() : int
      {
         return var_4257;
      }
      
      public function set pastVipDays(param1:int) : void
      {
         var_331 = getTimer();
         var_4257 = param1;
      }
      
      public function get activityPoints() : Dictionary
      {
         return var_2546;
      }
      
      public function set activityPoints(param1:Dictionary) : void
      {
         var_331 = getTimer();
         var_2546 = param1;
      }
      
      public function getActivityPointsForType(param1:int) : int
      {
         return var_2546[param1];
      }
      
      public function set minutesUntilExpiration(param1:int) : void
      {
         var_331 = getTimer();
         var_4373 = param1;
      }
      
      public function get minutesUntilExpiration() : int
      {
         var _loc1_:int = (getTimer() - var_331) / 60000;
         var _loc2_:int = var_4373 - _loc1_;
         return _loc2_ > 0 ? _loc2_ : 0;
      }
      
      public function set minutesSinceLastModified(param1:int) : void
      {
         var_331 = getTimer();
         var_4368 = param1;
      }
      
      public function get minutesSinceLastModified() : int
      {
         return var_4368;
      }
      
      public function get lastUpdated() : int
      {
         return var_331;
      }
      
      public function get emeraldBalance() : int
      {
         return var_3240;
      }
      
      public function set emeraldBalance(param1:int) : void
      {
         var_3240 = param1;
      }
      
      public function get silverBalance() : int
      {
         return var_3311;
      }
      
      public function set silverBalance(param1:int) : void
      {
         var_3311 = param1;
      }
   }
}

