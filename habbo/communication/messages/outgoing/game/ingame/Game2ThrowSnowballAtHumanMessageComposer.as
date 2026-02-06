package com.sulake.habbo.communication.messages.outgoing.game.ingame
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   public class Game2ThrowSnowballAtHumanMessageComposer implements IMessageComposer
   {
      
      private var var_24:Array = [];
      
      public function Game2ThrowSnowballAtHumanMessageComposer(param1:int, param2:int, param3:int, param4:int)
      {
         super();
         var_24.push(param1);
         var_24.push(param2);
         var_24.push(param3);
         var_24.push(param4);
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

