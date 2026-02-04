package com.sulake.habbo.catalog.purse
{
   import flash.events.Event;
   
   public class PurseEvent extends Event
   {
      
      public static const CREDIT_BALANCE:String = "catalog_purse_credit_balance";
      
      public static const ACTIVITY_POINT_BALANCE:String = "catalog_purse_activity_point_balance";
      
      public static const const_1147:String = "catalog_purse_emerald_balance";
      
      public static const SILVER_BALANCE:String = "catalog_purse_silver_balance";
      
      private var var_3634:int;
      
      private var var_2381:int;
      
      public function PurseEvent(param1:String, param2:int, param3:int, param4:Boolean = false, param5:Boolean = false)
      {
         super(param1,param4,param5);
         var_3634 = param2;
         var_2381 = param3;
      }
      
      public function get balance() : int
      {
         return var_3634;
      }
      
      public function get activityPointType() : int
      {
         return var_2381;
      }
   }
}

