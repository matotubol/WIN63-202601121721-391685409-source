package com.sulake.habbo.communication.messages.incoming.catalog
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.catalog.SellablePetPalettesMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class SellablePetPalettesMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function SellablePetPalettesMessageEvent(param1:Function)
      {
         super(param1,SellablePetPalettesMessageEventParser);
      }
      
      public function getParser() : SellablePetPalettesMessageEventParser
      {
         return this.var_15 as SellablePetPalettesMessageEventParser;
      }
   }
}

