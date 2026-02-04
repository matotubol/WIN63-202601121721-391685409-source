package com.sulake.habbo.session
{
   public class HabboClubLevelEnum
   {
      
      public static const NO_CLUB:int = 0;
      
      public static const CLUB:int = 1;
      
      public static const VIP:int = 2;
      
      public function HabboClubLevelEnum()
      {
         super();
      }
      
      public static function HasClub(param1:int) : Boolean
      {
         return param1 >= 1;
      }
      
      public static function HasVip(param1:int) : Boolean
      {
         return param1 >= 1;
      }
   }
}

