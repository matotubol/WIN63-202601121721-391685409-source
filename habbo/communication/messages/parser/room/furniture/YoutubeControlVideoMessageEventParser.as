package com.sulake.habbo.communication.messages.parser.room.furniture
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class YoutubeControlVideoMessageEventParser implements IMessageParser
   {
      
      private var var_2536:int;
      
      private var var_2966:int;
      
      public function YoutubeControlVideoMessageEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_2536 = param1.readInteger();
         var_2966 = param1.readInteger();
         return true;
      }
      
      public function get furniId() : int
      {
         return var_2536;
      }
      
      public function get commandId() : int
      {
         return var_2966;
      }
   }
}

