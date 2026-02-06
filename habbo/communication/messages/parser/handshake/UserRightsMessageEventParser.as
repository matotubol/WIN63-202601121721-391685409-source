package com.sulake.habbo.communication.messages.parser.handshake
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class UserRightsMessageEventParser implements IMessageParser
   {
      
      private var var_2971:int;
      
      private var var_3788:int;
      
      private var _isAmbassador:Boolean;
      
      public function UserRightsMessageEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_2971 = param1.readInteger();
         var_3788 = param1.readInteger();
         _isAmbassador = param1.readBoolean();
         return true;
      }
      
      public function get clubLevel() : int
      {
         return var_2971;
      }
      
      public function get securityLevel() : int
      {
         return var_3788;
      }
      
      public function get isAmbassador() : Boolean
      {
         return _isAmbassador;
      }
   }
}

