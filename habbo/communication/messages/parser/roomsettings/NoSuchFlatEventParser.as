package com.sulake.habbo.communication.messages.parser.roomsettings
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class NoSuchFlatEventParser implements IMessageParser
   {
      
      private var _flatId:int;
      
      public function NoSuchFlatEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         this._flatId = param1.readInteger();
         return true;
      }
      
      public function get flatId() : int
      {
         return _flatId;
      }
   }
}

