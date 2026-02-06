package com.sulake.habbo.communication.messages.outgoing.game.directory
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   public class Game2GetAccountGameStatusMessageComposer implements IMessageComposer
   {
      
      private var var_24:Array = [];
      
      public function Game2GetAccountGameStatusMessageComposer(param1:int)
      {
         super();
         var_24.push(param1);
      }
      
      public function getMessageArray() : Array
      {
         return var_24;
      }
      
      public function dispose() : void
      {
      }
   }
}

