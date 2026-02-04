package com.sulake.habbo.friendbar.events
{
   import flash.events.Event;
   
   public class FindFriendsNotificationEvent extends Event
   {
      
      public static const TYPE:String = "FIND_FRIENDS_RESULT";
      
      private var var_2614:Boolean;
      
      public function FindFriendsNotificationEvent(param1:Boolean)
      {
         var_2614 = param1;
         super("FIND_FRIENDS_RESULT");
      }
      
      public function get success() : Boolean
      {
         return var_2614;
      }
   }
}

