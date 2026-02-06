package com.sulake.habbo.communication.messages.parser.help
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class GuideSessionMessageMessageEventParser implements IMessageParser
   {
      
      private var var_3125:String;
      
      private var var_1229:int;
      
      public function GuideSessionMessageMessageEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_3125 = param1.readString();
         var_1229 = param1.readInteger();
         return true;
      }
      
      public function get chatMessage() : String
      {
         return var_3125;
      }
      
      public function get senderId() : int
      {
         return var_1229;
      }
   }
}

