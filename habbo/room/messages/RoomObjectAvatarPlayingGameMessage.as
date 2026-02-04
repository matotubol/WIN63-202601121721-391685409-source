package com.sulake.habbo.room.messages
{
   public class RoomObjectAvatarPlayingGameMessage extends RoomObjectUpdateStateMessage
   {
      
      private var _isPlayingGame:Boolean;
      
      public function RoomObjectAvatarPlayingGameMessage(param1:Boolean = false)
      {
         super();
         _isPlayingGame = param1;
      }
      
      public function get isPlayingGame() : Boolean
      {
         return _isPlayingGame;
      }
   }
}

