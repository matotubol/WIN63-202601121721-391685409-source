package com.sulake.habbo.communication.messages.incoming.catalog
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.catalog.BundleDiscountRulesetMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class BundleDiscountRulesetMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function BundleDiscountRulesetMessageEvent(param1:Function)
      {
         super(param1,BundleDiscountRulesetMessageEventParser);
      }
      
      public function getParser() : BundleDiscountRulesetMessageEventParser
      {
         return this.var_15 as BundleDiscountRulesetMessageEventParser;
      }
   }
}

