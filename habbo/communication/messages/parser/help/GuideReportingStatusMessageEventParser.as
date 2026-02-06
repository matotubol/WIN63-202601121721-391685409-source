package com.sulake.habbo.communication.messages.parser.help
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import package_175.class_3018;
   
   [SecureSWF(rename="true")]
   public class GuideReportingStatusMessageEventParser implements IMessageParser
   {
      
      public static const const_813:int = 0;
      
      public static const const_706:int = 1;
      
      public static const const_1211:int = 2;
      
      public static const const_935:int = 3;
      
      private var var_3361:int;
      
      private var var_2976:class_3018;
      
      public function GuideReportingStatusMessageEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         var_2976 = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_3361 = param1.readInteger();
         if(var_3361 == 1)
         {
            var_2976 = new class_3018(param1);
         }
         return true;
      }
      
      public function get statusCode() : int
      {
         return var_3361;
      }
      
      public function get pendingTicket() : class_3018
      {
         return var_2976;
      }
      
      public function get localizationCode() : String
      {
         switch(var_3361 - 2)
         {
            case 0:
               return "blocked";
            case 1:
               return "tooquick";
            default:
               return "";
         }
      }
   }
}

