package com.sulake.habbo.communication.messages.parser.handshake
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class NoobnessLevelMessageEventParser implements IMessageParser
   {
      
      private var var_3371:int;
      
      public function NoobnessLevelMessageEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_3371 = param1.readInteger();
         return true;
      }
      
      public function get noobnessLevel() : int
      {
         return var_3371;
      }
   }
}

