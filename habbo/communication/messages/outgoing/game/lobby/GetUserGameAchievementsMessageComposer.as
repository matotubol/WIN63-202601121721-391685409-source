package com.sulake.habbo.communication.messages.outgoing.game.lobby
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   public class GetUserGameAchievementsMessageComposer implements IMessageComposer
   {
      
      private var var_2912:int;
      
      public function GetUserGameAchievementsMessageComposer(param1:int)
      {
         super();
         var_2912 = param1;
      }
      
      public function getMessageArray() : Array
      {
         return [var_2912];
      }
      
      public function dispose() : void
      {
      }
   }
}

