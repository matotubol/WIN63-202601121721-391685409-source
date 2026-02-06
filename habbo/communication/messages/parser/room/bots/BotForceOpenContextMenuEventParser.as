package com.sulake.habbo.communication.messages.parser.room.bots
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class BotForceOpenContextMenuEventParser implements IMessageParser
   {
      
      private var var_1504:int;
      
      public function BotForceOpenContextMenuEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         var_1504 = -1;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_1504 = param1.readInteger();
         return true;
      }
      
      public function get botId() : int
      {
         return var_1504;
      }
   }
}

