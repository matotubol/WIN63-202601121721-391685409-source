package com.sulake.habbo.friendbar.events
{
   import com.sulake.habbo.friendbar.data.class_2307;
   import flash.events.Event;
   
   public class NotificationEvent extends Event
   {
      
      public static const FRIEND_NOTIFICATION_EVENT:String = "FBE_NOTIFICATION_EVENT";
      
      public var friendId:int;
      
      public var notification:class_2307;
      
      public function NotificationEvent(param1:int, param2:class_2307)
      {
         super("FBE_NOTIFICATION_EVENT");
         this.friendId = param1;
         this.notification = param2;
      }
   }
}

