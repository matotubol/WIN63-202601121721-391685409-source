package com.sulake.habbo.communication.messages.incoming.crafting
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.crafting.CraftingRecipesAvailableMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class CraftingRecipesAvailableMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function CraftingRecipesAvailableMessageEvent(param1:Function)
      {
         super(param1,CraftingRecipesAvailableMessageEventParser);
      }
      
      public function getParser() : CraftingRecipesAvailableMessageEventParser
      {
         return var_15 as CraftingRecipesAvailableMessageEventParser;
      }
   }
}

