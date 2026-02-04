package com.sulake.habbo.roomevents.wired_setup.conditions
{
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_2397;
   import com.sulake.habbo.roomevents.wired_setup.common.utils.ChronoFieldRangeFilter;
   
   public class class_3763 extends class_3762
   {
      
      private static var SECONDS_CONTAINER_NAME:String = "second";
      
      private static var MINUTES_CONTAINER_NAME:String = "minute";
      
      private static var HOURS_CONTAINER_NAME:String = "hour";
      
      public function class_3763()
      {
         super();
      }
      
      override public function get code() : int
      {
         return class_4100.TIME_MATCHES;
      }
      
      override public function get legacyInputMode() : Boolean
      {
         return true;
      }
      
      override public function onEditStart(param1:class_2397) : void
      {
         super.onEditStart(param1);
         var _loc11_:int = int(param1.intParams[0]);
         var _loc10_:int = int(param1.intParams[1]);
         var _loc2_:int = int(param1.intParams[2]);
         var _loc7_:int = int(param1.intParams[3]);
         var _loc12_:int = int(param1.intParams[4]);
         var _loc4_:int = int(param1.intParams[5]);
         var _loc6_:int = int(param1.intParams[6]);
         var _loc8_:int = int(param1.intParams[7]);
         var _loc5_:int = int(param1.intParams[8]);
         var _loc9_:ChronoFieldRangeFilter = new ChronoFieldRangeFilter(SECONDS_CONTAINER_NAME,_loc11_,_loc7_,_loc12_);
         var _loc13_:ChronoFieldRangeFilter = new ChronoFieldRangeFilter(MINUTES_CONTAINER_NAME,_loc10_,_loc4_,_loc6_);
         var _loc3_:ChronoFieldRangeFilter = new ChronoFieldRangeFilter(HOURS_CONTAINER_NAME,_loc2_,_loc8_,_loc5_);
         initializeRangeFilter(_loc9_);
         initializeRangeFilter(_loc13_);
         initializeRangeFilter(_loc3_);
      }
      
      override public function readIntParamsFromForm() : Array
      {
         var _loc1_:Array = [];
         var _loc3_:ChronoFieldRangeFilter = readRangeFilter(SECONDS_CONTAINER_NAME);
         var _loc4_:ChronoFieldRangeFilter = readRangeFilter(MINUTES_CONTAINER_NAME);
         var _loc2_:ChronoFieldRangeFilter = readRangeFilter(HOURS_CONTAINER_NAME);
         _loc1_.push(_loc3_.useFilter ? 1 : 0);
         _loc1_.push(_loc4_.useFilter ? 1 : 0);
         _loc1_.push(_loc2_.useFilter ? 1 : 0);
         _loc1_.push(_loc3_.min);
         _loc1_.push(_loc3_.max);
         _loc1_.push(_loc4_.min);
         _loc1_.push(_loc4_.max);
         _loc1_.push(_loc2_.min);
         _loc1_.push(_loc2_.max);
         return _loc1_;
      }
   }
}

