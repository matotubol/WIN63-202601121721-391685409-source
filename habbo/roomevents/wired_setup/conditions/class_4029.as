package com.sulake.habbo.roomevents.wired_setup.conditions
{
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_2397;
   import com.sulake.habbo.roomevents.wired_setup.common.utils.ChronoFieldMaskFilter;
   import com.sulake.habbo.roomevents.wired_setup.common.utils.ChronoFieldRangeFilter;
   
   public class class_4029 extends class_3762
   {
      
      public function class_4029()
      {
         super();
      }
      
      override public function get code() : int
      {
         return class_4100.DATE_MATCHES;
      }
      
      override public function get legacyInputMode() : Boolean
      {
         return true;
      }
      
      override public function onEditStart(param1:class_2397) : void
      {
         super.onEditStart(param1);
         var _loc5_:int = int(param1.intParams[0]);
         var _loc3_:int = int(param1.intParams[1]);
         var _loc11_:int = int(param1.intParams[2]);
         var _loc9_:int = int(param1.intParams[3]);
         var _loc12_:int = int(param1.intParams[4]);
         var _loc8_:int = int(param1.intParams[5]);
         var _loc2_:int = int(param1.intParams[6]);
         var _loc10_:int = int(param1.intParams[7]);
         var _loc7_:ChronoFieldMaskFilter = new ChronoFieldMaskFilter("weekday",_loc11_,7);
         var _loc13_:ChronoFieldRangeFilter = new ChronoFieldRangeFilter("day",_loc5_,_loc9_,_loc12_,1);
         var _loc4_:ChronoFieldMaskFilter = new ChronoFieldMaskFilter("month",_loc8_,12);
         var _loc6_:ChronoFieldRangeFilter = new ChronoFieldRangeFilter("year",_loc3_,_loc2_,_loc10_);
         initializeMaskFilter(_loc7_);
         initializeRangeFilter(_loc13_);
         initializeMaskFilter(_loc4_);
         initializeRangeFilter(_loc6_);
      }
      
      override public function readIntParamsFromForm() : Array
      {
         var _loc1_:Array = [];
         var _loc5_:ChronoFieldMaskFilter = readMaskFilter("weekday",7);
         var _loc3_:ChronoFieldRangeFilter = readRangeFilter("day",1);
         var _loc2_:ChronoFieldMaskFilter = readMaskFilter("month",12);
         var _loc4_:ChronoFieldRangeFilter = readRangeFilter("year");
         _loc1_.push(_loc3_.useFilter ? 1 : 0);
         _loc1_.push(_loc4_.useFilter ? 1 : 0);
         _loc1_.push(_loc5_.mask);
         _loc1_.push(_loc3_.min);
         _loc1_.push(_loc3_.max);
         _loc1_.push(_loc2_.mask);
         _loc1_.push(_loc4_.min);
         _loc1_.push(_loc4_.max);
         return _loc1_;
      }
   }
}

