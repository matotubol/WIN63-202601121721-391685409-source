package com.sulake.habbo.communication.messages.incoming.room.engine
{
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.room.engine.FurnitureAliasesMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class FurnitureAliasesMessageEvent extends MessageEvent
   {
      
      public function FurnitureAliasesMessageEvent(param1:Function)
      {
         super(param1,FurnitureAliasesMessageEventParser);
      }
      
      public function getParser() : FurnitureAliasesMessageEventParser
      {
         return var_15 as FurnitureAliasesMessageEventParser;
      }
   }
}

