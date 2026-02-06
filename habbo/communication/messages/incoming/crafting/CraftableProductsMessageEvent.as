package com.sulake.habbo.communication.messages.incoming.crafting
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.crafting.CraftableProductsMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class CraftableProductsMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function CraftableProductsMessageEvent(param1:Function)
      {
         super(param1,CraftableProductsMessageEventParser);
      }
      
      public function getParser() : CraftableProductsMessageEventParser
      {
         return var_15 as CraftableProductsMessageEventParser;
      }
   }
}

