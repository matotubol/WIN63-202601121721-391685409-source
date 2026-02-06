package com.sulake.habbo.communication.messages.parser.collectibles
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class NftStoreOffersMessageEventParser implements IMessageParser
   {
      
      private var var_2199:Array;
      
      public function NftStoreOffersMessageEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         var_2199 = [];
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_2199 = [];
         var _loc2_:int = param1.readInteger();
         var _loc3_:int = 0;
         while(0 < _loc2_)
         {
            var_2199.push(new class_3631(param1));
            _loc3_++;
         }
         return true;
      }
      
      public function get nftStoreOffers() : Array
      {
         return var_2199;
      }
   }
}

