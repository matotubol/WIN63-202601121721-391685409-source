package com.sulake.habbo.communication.messages.parser.room.bots
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class BotErrorEventParser implements IMessageParser
   {
      
      private var var_2759:int;
      
      public function BotErrorEventParser()
      {
         super();
      }
      
      public function get errorCode() : int
      {
         return var_2759;
      }
      
      public function flush() : Boolean
      {
         var_2759 = -1;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         var_2759 = param1.readInteger();
         return true;
      }
   }
}

