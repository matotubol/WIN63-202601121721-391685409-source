package com.sulake.habbo.communication.messages.parser.room.chat
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class RemainingMutePeriodEventParser implements IMessageParser
   {
      
      private var var_4041:int = 0;
      
      public function RemainingMutePeriodEventParser()
      {
         super();
      }
      
      public function get secondsRemaining() : int
      {
         return var_4041;
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_4041 = param1.readInteger();
         return true;
      }
   }
}

