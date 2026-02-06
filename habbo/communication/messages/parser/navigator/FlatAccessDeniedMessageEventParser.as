package com.sulake.habbo.communication.messages.parser.navigator
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class FlatAccessDeniedMessageEventParser implements IMessageParser
   {
      
      private var _flatId:int = 0;
      
      private var _userName:String = null;
      
      public function FlatAccessDeniedMessageEventParser()
      {
         super();
      }
      
      public function get flatId() : int
      {
         return _flatId;
      }
      
      public function get userName() : String
      {
         return _userName;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _flatId = param1.readInteger();
         if(param1.bytesAvailable)
         {
            _userName = param1.readString();
         }
         return true;
      }
      
      public function flush() : Boolean
      {
         _userName = null;
         return true;
      }
   }
}

