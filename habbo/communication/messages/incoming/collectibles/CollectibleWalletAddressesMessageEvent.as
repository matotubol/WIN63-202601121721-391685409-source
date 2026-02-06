package com.sulake.habbo.communication.messages.incoming.collectibles
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.collectibles.CollectibleWalletAddressesMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class CollectibleWalletAddressesMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function CollectibleWalletAddressesMessageEvent(param1:Function)
      {
         super(param1,CollectibleWalletAddressesMessageEventParser);
      }
      
      public function getParser() : CollectibleWalletAddressesMessageEventParser
      {
         return var_15 as CollectibleWalletAddressesMessageEventParser;
      }
   }
}

