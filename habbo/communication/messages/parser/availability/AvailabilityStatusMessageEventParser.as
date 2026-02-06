package com.sulake.habbo.communication.messages.parser.availability
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class AvailabilityStatusMessageEventParser implements IMessageParser
   {
      
      private var _isOpen:Boolean;
      
      private var var_2732:Boolean;
      
      private var var_3207:Boolean;
      
      public function AvailabilityStatusMessageEventParser()
      {
         super();
      }
      
      public function get isOpen() : Boolean
      {
         return _isOpen;
      }
      
      public function get onShutDown() : Boolean
      {
         return var_2732;
      }
      
      public function get isAuthenticHabbo() : Boolean
      {
         return var_3207;
      }
      
      public function flush() : Boolean
      {
         _isOpen = false;
         var_2732 = false;
         var_3207 = false;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _isOpen = param1.readBoolean();
         var_2732 = param1.readBoolean();
         if(param1.bytesAvailable)
         {
            var_3207 = param1.readBoolean();
         }
         return true;
      }
   }
}

