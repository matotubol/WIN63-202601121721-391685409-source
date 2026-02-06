package com.sulake.habbo.communication.messages.incoming.inventory.furni
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.inventory.furni.FurniListAddOrUpdateEventParser;
   
   [SecureSWF(rename="true")]
   public class FurniListAddOrUpdateEvent extends MessageEvent implements IMessageEvent
   {
      
      public function FurniListAddOrUpdateEvent(param1:Function)
      {
         super(param1,FurniListAddOrUpdateEventParser);
      }
      
      public function getParser() : FurniListAddOrUpdateEventParser
      {
         return this.var_15 as FurniListAddOrUpdateEventParser;
      }
   }
}

