package com.sulake.habbo.catalog.purse
{
   public interface class_1831
   {
      
      function set credits(param1:int) : void;
      
      function set silverBalance(param1:int) : void;
      
      function set emeraldBalance(param1:int) : void;
      
      function set clubDays(param1:int) : void;
      
      function set clubPeriods(param1:int) : void;
      
      function get isExpiring() : Boolean;
      
      function get minutesUntilExpiration() : int;
      
      function set isExpiring(param1:Boolean) : void;
      
      function get credits() : int;
      
      function get silverBalance() : int;
      
      function get emeraldBalance() : int;
      
      function get clubDays() : int;
      
      function get clubPeriods() : int;
      
      function get hasClubLeft() : Boolean;
      
      function get isVIP() : Boolean;
      
      function get pastClubDays() : int;
      
      function get pastVipDays() : int;
      
      function getActivityPointsForType(param1:int) : int;
   }
}

