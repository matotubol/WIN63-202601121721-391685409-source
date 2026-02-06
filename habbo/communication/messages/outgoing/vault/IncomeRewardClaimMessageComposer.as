package com.sulake.habbo.communication.messages.outgoing.vault
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.communication.util.Byte;
   import com.sulake.core.runtime.class_13;
   
   [SecureSWF(rename="true")]
   public class IncomeRewardClaimMessageComposer implements IMessageComposer, class_13
   {
      
      private var var_120:Array = [];
      
      public function IncomeRewardClaimMessageComposer(param1:int)
      {
         super();
         var_120.push(new Byte(param1));
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

