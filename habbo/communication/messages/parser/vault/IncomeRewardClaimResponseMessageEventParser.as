package com.sulake.habbo.communication.messages.parser.vault
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class IncomeRewardClaimResponseMessageEventParser implements IMessageParser
   {
      
      private var var_4317:int;
      
      private var var_1122:Boolean;
      
      public function IncomeRewardClaimResponseMessageEventParser()
      {
         super();
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_4317 = param1.readByte();
         var_1122 = param1.readBoolean();
         return true;
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function get rewardCategory() : int
      {
         return var_4317;
      }
      
      public function get result() : Boolean
      {
         return var_1122;
      }
   }
}

