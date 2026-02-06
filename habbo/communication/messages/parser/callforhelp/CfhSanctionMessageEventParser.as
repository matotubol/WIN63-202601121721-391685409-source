package com.sulake.habbo.communication.messages.parser.callforhelp
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.callforhelp.class_3472;
   
   [SecureSWF(rename="true")]
   public class CfhSanctionMessageEventParser implements IMessageParser
   {
      
      private var var_3038:int = -1;
      
      private var var_2685:int = -1;
      
      private var var_3160:class_3472;
      
      public function CfhSanctionMessageEventParser()
      {
         super();
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_3038 = param1.readInteger();
         var_2685 = param1.readInteger();
         var_3160 = new class_3472(param1);
         return true;
      }
      
      public function get issueId() : int
      {
         return var_3038;
      }
      
      public function get accountId() : int
      {
         return var_2685;
      }
      
      public function get sanctionType() : class_3472
      {
         return var_3160;
      }
      
      public function flush() : Boolean
      {
         var_3038 = -1;
         var_2685 = -1;
         var_3160 = null;
         return true;
      }
   }
}

