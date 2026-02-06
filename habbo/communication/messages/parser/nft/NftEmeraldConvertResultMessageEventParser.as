package com.sulake.habbo.communication.messages.parser.nft
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class NftEmeraldConvertResultMessageEventParser implements IMessageParser
   {
      
      public static const name_6:int = 0;
      
      public static const const_638:int = 1;
      
      public static const const_267:int = 2;
      
      public static const const_396:int = 3;
      
      public static const const_769:int = 4;
      
      public static const const_354:int = 5;
      
      private var _stuffId:int;
      
      private var var_1122:int;
      
      public function NftEmeraldConvertResultMessageEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         _stuffId = 0;
         var_1122 = 0;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _stuffId = param1.readInteger();
         var_1122 = param1.readShort();
         return true;
      }
      
      public function get stuffId() : int
      {
         return _stuffId;
      }
      
      public function get result() : int
      {
         return var_1122;
      }
   }
}

