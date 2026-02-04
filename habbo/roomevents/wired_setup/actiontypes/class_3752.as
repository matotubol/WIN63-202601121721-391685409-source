package com.sulake.habbo.roomevents.wired_setup.actiontypes
{
   public class class_3752 extends DefaultActionType
   {
      
      public function class_3752()
      {
         super();
      }
      
      override public function get code() : int
      {
         return class_4061.MOVE_FURNI_TO_USER;
      }
      
      override public function furniSelectionTitle(param1:int) : String
      {
         return "wiredfurni.params.sources.furni.title.mv.0";
      }
      
      override public function userSelectionTitle(param1:int) : String
      {
         return "wiredfurni.params.sources.furni.title.mv_user";
      }
      
      override public function advancedAlwaysVisible() : Boolean
      {
         return true;
      }
   }
}

