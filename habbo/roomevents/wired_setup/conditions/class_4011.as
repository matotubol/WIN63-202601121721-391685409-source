package com.sulake.habbo.roomevents.wired_setup.conditions
{
   public class class_4011 extends DefaultConditionType
   {
      
      public function class_4011()
      {
         super();
      }
      
      override public function get code() : int
      {
         return class_4100.STUFF_TYPE_MATCHES;
      }
      
      override public function get negativeCode() : int
      {
         return class_4100.NOT_STUFF_TYPE_MATCHES;
      }
      
      override public function furniSelectionTitle(param1:int) : String
      {
         return "wiredfurni.params.sources.furni.title.match." + param1;
      }
      
      override public function advancedAlwaysVisible() : Boolean
      {
         return true;
      }
   }
}

