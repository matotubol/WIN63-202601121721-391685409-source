package com.sulake.habbo.communication.messages.incoming.inventory.furni
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.inventory.furni.FurniListRemoveEventParser;
   
   [SecureSWF(rename="true")]
   public class FurniListRemoveEvent extends MessageEvent implements IMessageEvent
   {
      
      public function FurniListRemoveEvent(param1:Function)
      {
         super(param1,FurniListRemoveEventParser);
      }
      
      public function getParser() : FurniListRemoveEventParser
      {
         return this.var_15 as FurniListRemoveEventParser;
      }
   }
}

