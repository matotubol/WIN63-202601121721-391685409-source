package com.sulake.habbo.inventory.purse
{
   import flash.utils.getTimer;
   
   public class Purse
   {
      
      private var _isExpiring:Boolean = false;
      
      private var _isCitizenshipVipExpiring:Boolean = false;
      
      private var var_3642:int = 0;
      
      private var var_3764:int = 0;
      
      private var var_5006:int = 0;
      
      private var var_4299:Boolean = false;
      
      private var var_4740:Boolean = false;
      
      private var var_4373:int = 0;
      
      private var var_4368:int = -1;
      
      private var var_331:int;
      
      public function Purse()
      {
         super();
      }
      
      public function get clubDays() : int
      {
         return var_3642;
      }
      
      public function set clubDays(param1:int) : void
      {
         var_331 = getTimer();
         var_3642 = Math.max(0,param1);
      }
      
      public function get clubPeriods() : int
      {
         return var_3764;
      }
      
      public function set clubPeriods(param1:int) : void
      {
         var_331 = getTimer();
         var_3764 = Math.max(0,param1);
      }
      
      public function get clubPastPeriods() : int
      {
         return var_5006;
      }
      
      public function set clubPastPeriods(param1:int) : void
      {
         var_331 = getTimer();
         var_5006 = Math.max(0,param1);
      }
      
      public function get clubHasEverBeenMember() : Boolean
      {
         return var_4299;
      }
      
      public function set clubHasEverBeenMember(param1:Boolean) : void
      {
         var_331 = getTimer();
         var_4299 = param1;
      }
      
      public function get isVIP() : Boolean
      {
         return var_4740;
      }
      
      public function set isVIP(param1:Boolean) : void
      {
         var_331 = getTimer();
         var_4740 = param1;
      }
      
      public function get minutesUntilExpiration() : int
      {
         var _loc1_:int = (getTimer() - var_331) / 60000;
         var _loc2_:int = var_4373 - _loc1_;
         return _loc2_ > 0 ? _loc2_ : 0;
      }
      
      public function set minutesUntilExpiration(param1:int) : void
      {
         var_331 = getTimer();
         var_4373 = param1;
      }
      
      public function get clubIsExpiring() : Boolean
      {
         return _isExpiring;
      }
      
      public function set clubIsExpiring(param1:Boolean) : void
      {
         _isExpiring = param1;
      }
      
      public function get citizenshipVipIsExpiring() : Boolean
      {
         return _isCitizenshipVipExpiring;
      }
      
      public function set citizenshipVipIsExpiring(param1:Boolean) : void
      {
         _isCitizenshipVipExpiring = param1;
      }
      
      public function get minutesSinceLastModified() : int
      {
         return var_4368;
      }
      
      public function set minutesSinceLastModified(param1:int) : void
      {
         var_331 = getTimer();
         var_4368 = param1;
      }
   }
}

