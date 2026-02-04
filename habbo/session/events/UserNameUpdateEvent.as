package com.sulake.habbo.session.events
{
   import flash.events.Event;
   
   public class UserNameUpdateEvent extends Event
   {
      
      public static const NAME_UPDATE:String = "unue_name_updated";
      
      private var _name:String;
      
      public function UserNameUpdateEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super("unue_name_updated",param2,param3);
         _name = param1;
      }
      
      public function get name() : String
      {
         return _name;
      }
   }
}

