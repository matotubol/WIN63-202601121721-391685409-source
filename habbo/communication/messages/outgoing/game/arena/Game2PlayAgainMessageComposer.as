package com.sulake.habbo.communication.messages.outgoing.game.arena
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   public class Game2PlayAgainMessageComposer implements IMessageComposer
   {
      
      private var var_24:Array = [];
      
      public function Game2PlayAgainMessageComposer()
      {
         super();
      }
      
      public function getMessageArray() : Array
      {
         return var_24;
      }
      
      public function dispose() : void
      {
         var_24 = [];
      }
   }
}

