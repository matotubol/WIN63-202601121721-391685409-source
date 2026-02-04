package com.sulake.habbo.avatar.events
{
   import flash.events.Event;
   
   public class AvatarUpdateEvent extends Event
   {
      
      public static const AVATAR_FIGURE_UPDATED:String = "AVATAR_FIGURE_UPDATED";
      
      private var var_975:String;
      
      public function AvatarUpdateEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super("AVATAR_FIGURE_UPDATED",param2,param3);
         var_975 = param1;
      }
      
      public function get figure() : String
      {
         return var_975;
      }
   }
}

