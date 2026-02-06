package com.sulake.habbo.communication.messages.incoming.crafting
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.crafting.CraftingResultMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class CraftingResultMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function CraftingResultMessageEvent(param1:Function)
      {
         super(param1,CraftingResultMessageEventParser);
      }
      
      public function getParser() : CraftingResultMessageEventParser
      {
         return var_15 as CraftingResultMessageEventParser;
      }
   }
}

