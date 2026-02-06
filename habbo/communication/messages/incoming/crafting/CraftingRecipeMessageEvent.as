package com.sulake.habbo.communication.messages.incoming.crafting
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.crafting.CraftingRecipeMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class CraftingRecipeMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function CraftingRecipeMessageEvent(param1:Function)
      {
         super(param1,CraftingRecipeMessageEventParser);
      }
      
      public function getParser() : CraftingRecipeMessageEventParser
      {
         return var_15 as CraftingRecipeMessageEventParser;
      }
   }
}

