package com.sulake.habbo.communication.messages.parser.room.bots
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class BotCommandConfigurationEventParser implements IMessageParser
   {
      
      private var var_1504:int;
      
      private var var_2966:int;
      
      private var var_24:String;
      
      public function BotCommandConfigurationEventParser()
      {
         super();
      }
      
      public function get botId() : int
      {
         return var_1504;
      }
      
      public function get commandId() : int
      {
         return var_2966;
      }
      
      public function get data() : String
      {
         return var_24;
      }
      
      public function flush() : Boolean
      {
         var_1504 = -1;
         var_2966 = -1;
         var_24 = "";
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_1504 = param1.readInteger();
         var_2966 = param1.readInteger();
         var_24 = param1.readString();
         return true;
      }
   }
}

