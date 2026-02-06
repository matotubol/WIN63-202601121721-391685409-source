package com.sulake.habbo.communication.messages.outgoing.game.directory
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class Game2QuickJoinGameMessageComposer implements IMessageComposer
   {
      
      public function Game2QuickJoinGameMessageComposer()
      {
         super();
      }
      
      public function getMessageArray() : Array
      {
         return [];
      }
      
      public function dispose() : void
      {
      }
   }
}

