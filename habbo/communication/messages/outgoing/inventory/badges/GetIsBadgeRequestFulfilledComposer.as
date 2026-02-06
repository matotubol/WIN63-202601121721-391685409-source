package com.sulake.habbo.communication.messages.outgoing.inventory.badges
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class GetIsBadgeRequestFulfilledComposer implements IMessageComposer
   {
      
      private var var_120:Array = [];
      
      public function GetIsBadgeRequestFulfilledComposer(param1:String)
      {
         super();
         this.var_120.push(param1);
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

