package com.sulake.habbo.communication.messages.parser.collectibles
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class CollectibleMintTokenOffersMessageEventParser implements IMessageParser
   {
      
      private var _tokenOffers:Vector.<class_2884>;
      
      public function CollectibleMintTokenOffersMessageEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         _tokenOffers = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _tokenOffers = new Vector.<class_2884>();
         var _loc3_:int = param1.readInteger();
         var _loc4_:int = 0;
         while(0 < _loc3_)
         {
            var _loc2_:class_2884 = new class_2884(param1);
            _tokenOffers.push(null);
            _loc4_++;
         }
         return true;
      }
      
      public function get tokenOffers() : Vector.<class_2884>
      {
         return _tokenOffers;
      }
   }
}

