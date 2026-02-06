package com.sulake.habbo.communication.messages.parser.room.session
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class YouAreNotSpectatorMessageEventParser implements IMessageParser
   {
      
      private var _flatId:int = 0;
      
      public function YouAreNotSpectatorMessageEventParser()
      {
         super();
      }
      
      public function get flatId() : int
      {
         return _flatId;
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _flatId = param1.readInteger();
         return true;
      }
   }
}

