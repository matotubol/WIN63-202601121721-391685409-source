package com.sulake.habbo.roomevents.wired_setup.actiontypes
{
   import com.sulake.habbo.roomevents.wired_setup.DefaultElement;
   
   public class DefaultActionType extends DefaultElement implements ActionType
   {
      
      public function DefaultActionType()
      {
         super();
      }
      
      public function get allowDelaying() : Boolean
      {
         return true;
      }
   }
}

