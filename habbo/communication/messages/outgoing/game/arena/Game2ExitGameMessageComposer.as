package com.sulake.habbo.communication.messages.outgoing.game.arena
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   public class Game2ExitGameMessageComposer implements IMessageComposer
   {
      
      private var var_4496:Boolean;
      
      public function Game2ExitGameMessageComposer(param1:Boolean = true)
      {
         super();
         var_4496 = param1;
      }
      
      public function getMessageArray() : Array
      {
         return [var_4496];
      }
      
      public function dispose() : void
      {
      }
   }
}

