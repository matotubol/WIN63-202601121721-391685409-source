package com.sulake.habbo.communication.messages.outgoing.competition
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class ForwardToACompetitionRoomMessageComposer implements IMessageComposer
   {
      
      private var var_120:Array = [];
      
      public function ForwardToACompetitionRoomMessageComposer(param1:String, param2:int)
      {
         super();
         this.var_120.push(param1);
         this.var_120.push(param2);
      }
      
      public function getMessageArray() : Array
      {
         return this.var_120;
      }
      
      public function dispose() : void
      {
         this.var_120 = null;
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
   }
}

