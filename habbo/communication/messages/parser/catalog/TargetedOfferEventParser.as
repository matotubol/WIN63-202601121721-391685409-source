package com.sulake.habbo.communication.messages.parser.catalog
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.catalog.class_2869;
   
   [SecureSWF(rename="true")]
   public class TargetedOfferEventParser implements IMessageParser
   {
      
      private var var_24:class_2869;
      
      public function TargetedOfferEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         var_24 = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_24 = new class_2869().parse(param1);
         return true;
      }
      
      public function get data() : class_2869
      {
         return var_24;
      }
   }
}

