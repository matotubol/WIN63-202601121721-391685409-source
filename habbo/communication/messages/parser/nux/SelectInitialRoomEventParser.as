package com.sulake.habbo.communication.messages.parser.nux
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class SelectInitialRoomEventParser implements IMessageParser
   {
      
      private var _status:int;
      
      private var var_1951:int;
      
      public function SelectInitialRoomEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _status = param1.readShort();
         var_1951 = param1.readInteger();
         return true;
      }
      
      public function get status() : int
      {
         return _status;
      }
      
      public function get roomId() : int
      {
         return var_1951;
      }
   }
}

