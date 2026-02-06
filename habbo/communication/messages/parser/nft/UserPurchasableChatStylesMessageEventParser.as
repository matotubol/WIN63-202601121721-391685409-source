package com.sulake.habbo.communication.messages.parser.nft
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class UserPurchasableChatStylesMessageEventParser implements IMessageParser
   {
      
      private var var_2223:Vector.<int>;
      
      public function UserPurchasableChatStylesMessageEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         var_2223 = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_2223 = new Vector.<int>();
         var _loc2_:int = param1.readInteger();
         var _loc3_:int = 0;
         while(0 < _loc2_)
         {
            var_2223.push(param1.readInteger());
            _loc3_ = 0 + 1;
         }
         return true;
      }
      
      public function get chatStyleIds() : Vector.<int>
      {
         return var_2223;
      }
   }
}

