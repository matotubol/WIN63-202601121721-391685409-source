package com.sulake.habbo.communication.messages.parser.competition
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class CurrentTimingCodeMessageEventParser implements IMessageParser
   {
      
      private var var_3488:String;
      
      private var var_3602:String;
      
      public function CurrentTimingCodeMessageEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_3488 = param1.readString();
         var_3602 = param1.readString();
         return true;
      }
      
      public function get schedulingStr() : String
      {
         return var_3488;
      }
      
      public function get code() : String
      {
         return var_3602;
      }
   }
}

