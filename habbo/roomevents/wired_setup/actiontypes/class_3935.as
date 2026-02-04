package com.sulake.habbo.roomevents.wired_setup.actiontypes
{
   public class class_3935 extends DefaultActionType
   {
      
      public function class_3935()
      {
         super();
      }
      
      override public function get code() : int
      {
         return class_4061.MOVE_FURNI_TO_FURNI;
      }
      
      override public function furniSelectionTitle(param1:int) : String
      {
         return "wiredfurni.params.sources.furni.title.mv." + param1;
      }
      
      override public function advancedAlwaysVisible() : Boolean
      {
         return true;
      }
      
      override public function get forceHidePickFurniInstructions() : Boolean
      {
         return true;
      }
   }
}

