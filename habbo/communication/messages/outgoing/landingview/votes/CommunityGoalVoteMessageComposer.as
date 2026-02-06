package com.sulake.habbo.communication.messages.outgoing.landingview.votes
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class CommunityGoalVoteMessageComposer implements IMessageComposer
   {
      
      private var var_5279:int;
      
      public function CommunityGoalVoteMessageComposer(param1:int)
      {
         super();
         this.var_5279 = param1;
      }
      
      public function dispose() : void
      {
      }
      
      public function getMessageArray() : Array
      {
         return [var_5279];
      }
   }
}

