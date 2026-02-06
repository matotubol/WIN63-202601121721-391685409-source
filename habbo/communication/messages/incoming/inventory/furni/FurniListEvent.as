package com.sulake.habbo.communication.messages.incoming.inventory.furni
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.inventory.furni.FurniListEventParser;
   
   [SecureSWF(rename="true")]
   public class FurniListEvent extends MessageEvent implements IMessageEvent
   {
      
      public function FurniListEvent(param1:Function)
      {
         super(param1,FurniListEventParser);
      }
      
      public function getParser() : FurniListEventParser
      {
         return this.var_15 as FurniListEventParser;
      }
   }
}

