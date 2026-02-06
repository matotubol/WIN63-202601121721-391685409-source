package com.sulake.habbo.communication.messages.parser.help
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class GuideTicketResolutionMessageEventParser implements IMessageParser
   {
      
      private static const const_537:int = 0;
      
      private static const const_288:int = 1;
      
      private static const const_1131:int = 2;
      
      private var var_2249:int = -1;
      
      public function GuideTicketResolutionMessageEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         var_2249 = -1;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_2249 = param1.readInteger();
         return true;
      }
      
      public function get localizationCode() : String
      {
         if(var_2249 == 0 || var_2249 == 1)
         {
            return "valid";
         }
         return "invalid";
      }
   }
}

