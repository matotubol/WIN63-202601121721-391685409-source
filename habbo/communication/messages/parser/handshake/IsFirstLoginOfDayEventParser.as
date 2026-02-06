package com.sulake.habbo.communication.messages.parser.handshake
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class IsFirstLoginOfDayEventParser implements IMessageParser
   {
      
      private var var_5181:Boolean;
      
      public function IsFirstLoginOfDayEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return false;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         this.var_5181 = param1.readBoolean();
         return true;
      }
      
      public function get isFirstLoginOfDay() : Boolean
      {
         return var_5181;
      }
   }
}

