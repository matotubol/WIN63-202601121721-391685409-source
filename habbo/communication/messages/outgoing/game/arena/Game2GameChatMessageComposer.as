package com.sulake.habbo.communication.messages.outgoing.game.arena
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   public class Game2GameChatMessageComposer implements IMessageComposer
   {
      
      private var var_2985:String;
      
      public function Game2GameChatMessageComposer(param1:String)
      {
         super();
         var_2985 = param1;
      }
      
      public function getMessageArray() : Array
      {
         return [var_2985];
      }
      
      public function dispose() : void
      {
         var_2985 = null;
      }
   }
}

