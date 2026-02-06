package com.sulake.habbo.communication.messages.incoming.roomsettings
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.roomsettings.FlatControllerAddedEventParser;
   
   [SecureSWF(rename="true")]
   public class FlatControllerAddedEvent extends MessageEvent implements IMessageEvent
   {
      
      public function FlatControllerAddedEvent(param1:Function)
      {
         super(param1,FlatControllerAddedEventParser);
      }
      
      public function getParser() : FlatControllerAddedEventParser
      {
         return this.var_15 as FlatControllerAddedEventParser;
      }
   }
}

