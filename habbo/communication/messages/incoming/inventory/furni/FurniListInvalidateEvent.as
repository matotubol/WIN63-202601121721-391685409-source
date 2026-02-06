package com.sulake.habbo.communication.messages.incoming.inventory.furni
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.inventory.furni.FurniListInvalidateEventParser;
   
   [SecureSWF(rename="true")]
   public class FurniListInvalidateEvent extends MessageEvent implements IMessageEvent
   {
      
      public function FurniListInvalidateEvent(param1:Function)
      {
         super(param1,FurniListInvalidateEventParser);
      }
      
      public function getParser() : FurniListInvalidateEventParser
      {
         return this.var_15 as FurniListInvalidateEventParser;
      }
   }
}

