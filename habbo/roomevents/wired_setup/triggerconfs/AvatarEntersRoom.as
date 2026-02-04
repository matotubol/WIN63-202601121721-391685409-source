package com.sulake.habbo.roomevents.wired_setup.triggerconfs
{
   public class AvatarEntersRoom extends DefaultTriggerConf
   {
      
      public function AvatarEntersRoom()
      {
         super();
      }
      
      override public function get code() : int
      {
         return class_4093.AVATAR_ENTERS_ROOM;
      }
   }
}

