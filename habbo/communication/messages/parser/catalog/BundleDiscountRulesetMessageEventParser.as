package com.sulake.habbo.communication.messages.parser.catalog
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.catalog.class_1766;
   
   [SecureSWF(rename="true")]
   public class BundleDiscountRulesetMessageEventParser implements IMessageParser
   {
      
      private var _bundleDiscountRuleset:class_1766;
      
      public function BundleDiscountRulesetMessageEventParser()
      {
         super();
      }
      
      public function get bundleDiscountRuleset() : class_1766
      {
         return _bundleDiscountRuleset;
      }
      
      public function flush() : Boolean
      {
         _bundleDiscountRuleset = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _bundleDiscountRuleset = new class_1766(param1);
         return true;
      }
   }
}

