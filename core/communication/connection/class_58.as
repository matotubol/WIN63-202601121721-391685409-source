package com.sulake.core.communication.connection
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   public interface class_58
   {
      
      function connectionInit(param1:String, param2:int) : void;
      
      function messageReceived(param1:String) : void;
      
      function messageSent(param1:String) : void;
      
      function messageParseError(param1:IMessageDataWrapper) : void;
   }
}

