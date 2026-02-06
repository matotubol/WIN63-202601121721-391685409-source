package com.sulake.habbo.communication.messages.parser.help
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class GuideTicketCreationResultMessageEventParser implements IMessageParser
   {
      
      private static const const_832:int = 0;
      
      private static const const_864:int = 1;
      
      private static const const_931:int = 2;
      
      private static const const_338:int = 3;
      
      private var var_1122:int = -1;
      
      public function GuideTicketCreationResultMessageEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         var_1122 = -1;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_1122 = param1.readInteger();
         return true;
      }
      
      public function get localizationCode() : String
      {
         switch(var_1122)
         {
            case 0:
               return "sent";
            case 1:
               return "blocked";
            case 2:
               return "nochat";
            case 3:
               return "alreadyreported";
            default:
               return "invalid";
         }
      }
   }
}

