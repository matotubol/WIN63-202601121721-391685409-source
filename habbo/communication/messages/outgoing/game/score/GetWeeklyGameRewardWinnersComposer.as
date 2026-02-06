package com.sulake.habbo.communication.messages.outgoing.game.score
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   public class GetWeeklyGameRewardWinnersComposer implements IMessageComposer
   {
      
      private var var_24:Array = [];
      
      public function GetWeeklyGameRewardWinnersComposer(param1:int)
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
         var_24 = null;
      }
   }
}

