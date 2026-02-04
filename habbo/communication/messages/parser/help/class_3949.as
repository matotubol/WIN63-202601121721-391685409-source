package com.sulake.habbo.communication.messages.parser.help
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class class_3949 implements IMessageParser
   {
      
      private var var_1951:int = 0;
      
      private var _roomName:String = "";
      
      public function class_3949()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_1951 = param1.readInteger();
         _roomName = param1.readString();
         return true;
      }
      
      public function getRoomId() : int
      {
         return var_1951;
      }
      
      public function getRoomName() : String
      {
         return _roomName;
      }
   }
}

