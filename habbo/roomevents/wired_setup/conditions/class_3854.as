package com.sulake.habbo.roomevents.wired_setup.conditions
{
   public class class_3854 extends DefaultConditionType
   {
      
      public function class_3854()
      {
         super();
      }
      
      override public function get code() : int
      {
         return class_4100.TRIGGERER_IS_ON_FURNI;
      }
      
      override public function get negativeCode() : int
      {
         return class_4100.NOT_TRIGGERER_IS_ON_FURNI;
      }
   }
}

