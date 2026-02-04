package com.sulake.habbo.room.messages
{
   public class RoomObjectAvatarEffectUpdateMessage extends RoomObjectUpdateStateMessage
   {
      
      private var var_205:int;
      
      private var var_4011:int;
      
      public function RoomObjectAvatarEffectUpdateMessage(param1:int = 0, param2:int = 0)
      {
         super();
         var_205 = param1;
         var_4011 = param2;
      }
      
      public function get effect() : int
      {
         return var_205;
      }
      
      public function get delayMilliSeconds() : int
      {
         return var_4011;
      }
   }
}

