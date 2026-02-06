package com.sulake.habbo.communication.messages.outgoing.game.lobby
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class GetResolutionAchievementsMessageComposer implements IMessageComposer
   {
      
      private var var_24:Array = [];
      
      public function GetResolutionAchievementsMessageComposer(param1:int, param2:int = 0)
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

