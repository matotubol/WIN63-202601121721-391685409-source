package com.sulake.habbo.room.messages
{
   public class RoomObjectAvatarExpressionUpdateMessage extends RoomObjectUpdateStateMessage
   {
      
      private var var_3120:int = -1;
      
      public function RoomObjectAvatarExpressionUpdateMessage(param1:int = -1)
      {
         super();
         var_3120 = param1;
      }
      
      public function get expressionType() : int
      {
         return var_3120;
      }
   }
}

