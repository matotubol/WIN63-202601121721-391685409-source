package com.sulake.habbo.communication.messages.parser.handshake
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class AuthenticationOKMessageEventParser implements IMessageParser
   {
      
      private var var_2685:int;
      
      private var var_1452:Array;
      
      private var var_3182:int;
      
      public function AuthenticationOKMessageEventParser()
      {
         super();
         var_1452 = [];
      }
      
      public function flush() : Boolean
      {
         var_2685 = -1;
         var_1452 = [];
         var_3182 = -1;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_2685 = param1.readInteger();
         var _loc2_:int = param1.readInteger();
         var _loc3_:int = 0;
         while(0 < _loc2_)
         {
            var_1452.push(param1.readShort());
            _loc3_++;
         }
         var_3182 = param1.readInteger();
         return true;
      }
      
      public function get accountId() : int
      {
         return var_2685;
      }
      
      public function get suggestedLoginActions() : Array
      {
         return var_1452;
      }
      
      public function get identityId() : int
      {
         return var_3182;
      }
   }
}

