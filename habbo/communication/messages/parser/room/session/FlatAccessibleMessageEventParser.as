package com.sulake.habbo.communication.messages.parser.room.session
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class FlatAccessibleMessageEventParser implements IMessageParser
   {
      
      private var _flatId:int = 0;
      
      private var _userName:String = null;
      
      public function FlatAccessibleMessageEventParser()
      {
         super();
      }
      
      public function get userName() : String
      {
         return _userName;
      }
      
      public function get flatId() : int
      {
         return _flatId;
      }
      
      public function flush() : Boolean
      {
         _userName = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _flatId = param1.readInteger();
         _userName = param1.readString();
         return true;
      }
   }
}

