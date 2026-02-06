package com.sulake.habbo.communication.messages.outgoing.game.ingame
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   public class Game2MakeSnowballMessageComposer implements IMessageComposer
   {
      
      private var var_24:Array = [];
      
      public function Game2MakeSnowballMessageComposer(param1:int, param2:int)
      {
         super();
         var_24.push(param1);
         var_24.push(param2);
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

