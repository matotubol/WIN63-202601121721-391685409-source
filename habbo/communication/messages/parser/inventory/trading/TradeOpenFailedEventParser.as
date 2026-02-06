package com.sulake.habbo.communication.messages.parser.inventory.trading
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class TradeOpenFailedEventParser implements IMessageParser
   {
      
      public static const const_870:int = 7;
      
      public static const const_458:int = 8;
      
      private var var_2352:int;
      
      private var _otherUserName:String;
      
      public function TradeOpenFailedEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_2352 = param1.readInteger();
         _otherUserName = param1.readString();
         return true;
      }
      
      public function get reason() : int
      {
         return var_2352;
      }
      
      public function get otherUserName() : String
      {
         return _otherUserName;
      }
   }
}

