package com.sulake.habbo.communication.messages.incoming.catalog
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.catalog.ProductOfferEventParser;
   
   [SecureSWF(rename="true")]
   public class ProductOfferEvent extends MessageEvent implements IMessageEvent
   {
      
      public function ProductOfferEvent(param1:Function)
      {
         super(param1,ProductOfferEventParser);
      }
      
      public function getParser() : ProductOfferEventParser
      {
         return this.var_15 as ProductOfferEventParser;
      }
   }
}

