package com.sulake.habbo.communication.messages.incoming.catalog
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.catalog.GiftWrappingConfigurationEventParser;
   
   [SecureSWF(rename="true")]
   public class GiftWrappingConfigurationEvent extends MessageEvent implements IMessageEvent
   {
      
      public function GiftWrappingConfigurationEvent(param1:Function)
      {
         super(param1,GiftWrappingConfigurationEventParser);
      }
      
      public function getParser() : GiftWrappingConfigurationEventParser
      {
         return this.var_15 as GiftWrappingConfigurationEventParser;
      }
   }
}

