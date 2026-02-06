package com.sulake.habbo.communication.messages.parser.mysterybox
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class GotMysteryBoxPrizeMessageEventParser implements IMessageParser
   {
      
      private var var_2763:String;
      
      private var var_1015:int;
      
      public function GotMysteryBoxPrizeMessageEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         var_2763 = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_2763 = param1.readString();
         var_1015 = param1.readInteger();
         return true;
      }
      
      public function get contentType() : String
      {
         return var_2763;
      }
      
      public function get classId() : int
      {
         return var_1015;
      }
   }
}

