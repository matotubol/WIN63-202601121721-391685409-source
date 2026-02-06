package com.sulake.habbo.communication.messages.parser.catalog
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.catalog.class_2138;
   
   [SecureSWF(rename="true")]
   public class ProductOfferEventParser implements IMessageParser
   {
      
      private var var_3075:class_2138;
      
      public function ProductOfferEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_3075 = new class_2138(param1);
         return true;
      }
      
      public function get offerData() : class_2138
      {
         return var_3075;
      }
   }
}

