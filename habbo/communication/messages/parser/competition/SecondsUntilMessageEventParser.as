package com.sulake.habbo.communication.messages.parser.competition
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class SecondsUntilMessageEventParser implements IMessageParser
   {
      
      private var var_3666:String;
      
      private var var_4000:int;
      
      public function SecondsUntilMessageEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_3666 = param1.readString();
         var_4000 = param1.readInteger();
         return true;
      }
      
      public function get timeStr() : String
      {
         return var_3666;
      }
      
      public function get secondsUntil() : int
      {
         return var_4000;
      }
   }
}

