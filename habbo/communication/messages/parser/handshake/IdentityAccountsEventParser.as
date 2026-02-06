package com.sulake.habbo.communication.messages.parser.handshake
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import flash.utils.Dictionary;
   
   [SecureSWF(rename="true")]
   public class IdentityAccountsEventParser implements IMessageParser
   {
      
      private var var_2147:Dictionary;
      
      public function IdentityAccountsEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         if(var_2147)
         {
            var_2147 = null;
         }
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_2147 = new Dictionary();
         var _loc2_:int = param1.readInteger();
         var _loc3_:int = 0;
         while(0 < _loc2_)
         {
            var_2147[param1.readInteger()] = param1.readString();
            _loc3_++;
         }
         return true;
      }
      
      public function get accounts() : Dictionary
      {
         return var_2147;
      }
   }
}

