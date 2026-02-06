package com.sulake.habbo.communication.messages.parser.catalog
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.catalog.class_2681;
   
   [SecureSWF(rename="true")]
   public class PurchaseOKMessageEventParser implements IMessageParser
   {
      
      private var _offer:class_2681;
      
      public function PurchaseOKMessageEventParser()
      {
         super();
      }
      
      public function get offer() : class_2681
      {
         return _offer;
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _offer = new class_2681(param1);
         return true;
      }
   }
}

