package com.sulake.habbo.roomevents.wired_setup.triggerconfs
{
   public class AvatarLeavesRoom extends DefaultTriggerConf
   {
      
      public function AvatarLeavesRoom()
      {
         super();
      }
      
      override public function get code() : int
      {
         return class_4093.AVATAR_LEAVES_ROOM;
      }
   }
}

