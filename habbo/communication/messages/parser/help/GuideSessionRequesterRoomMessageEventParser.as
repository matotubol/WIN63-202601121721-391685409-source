package com.sulake.habbo.communication.messages.parser.help
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class GuideSessionRequesterRoomMessageEventParser implements IMessageParser
   {
      
      private var var_5053:int;
      
      public function GuideSessionRequesterRoomMessageEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_5053 = param1.readInteger();
         return true;
      }
      
      public function getRequesterRoomId() : int
      {
         return var_5053;
      }
   }
}

