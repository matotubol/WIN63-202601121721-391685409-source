package com.sulake.habbo.communication.messages.incoming.catalog
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.catalog.RoomAdPurchaseInfoEventParser;
   
   [SecureSWF(rename="true")]
   public class RoomAdPurchaseInfoEvent extends MessageEvent implements IMessageEvent
   {
      
      public function RoomAdPurchaseInfoEvent(param1:Function)
      {
         super(param1,RoomAdPurchaseInfoEventParser);
      }
      
      public function getParser() : RoomAdPurchaseInfoEventParser
      {
         return this.var_15 as RoomAdPurchaseInfoEventParser;
      }
   }
}

