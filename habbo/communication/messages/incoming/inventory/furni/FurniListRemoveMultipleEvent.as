package com.sulake.habbo.communication.messages.incoming.inventory.furni
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.inventory.furni.FurniListRemoveMultipleEventParser;
   
   [SecureSWF(rename="true")]
   public class FurniListRemoveMultipleEvent extends MessageEvent implements IMessageEvent
   {
      
      public function FurniListRemoveMultipleEvent(param1:Function)
      {
         super(param1,FurniListRemoveMultipleEventParser);
      }
      
      public function getParser() : FurniListRemoveMultipleEventParser
      {
         return this.var_15 as FurniListRemoveMultipleEventParser;
      }
   }
}

