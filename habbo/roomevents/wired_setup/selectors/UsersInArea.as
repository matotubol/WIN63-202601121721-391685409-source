package com.sulake.habbo.roomevents.wired_setup.selectors
{
   public class UsersInArea extends InArea
   {
      
      public function UsersInArea()
      {
         super();
      }
      
      override public function get code() : int
      {
         return SelectorCodes.USERS_IN_AREA;
      }
   }
}

