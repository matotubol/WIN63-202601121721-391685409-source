package com.sulake.habbo.communication.messages.incoming.roomsettings
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.roomsettings.FlatControllerRemovedEventParser;
   
   [SecureSWF(rename="true")]
   public class FlatControllerRemovedEvent extends MessageEvent implements IMessageEvent
   {
      
      public function FlatControllerRemovedEvent(param1:Function)
      {
         super(param1,FlatControllerRemovedEventParser);
      }
      
      public function getParser() : FlatControllerRemovedEventParser
      {
         return this.var_15 as FlatControllerRemovedEventParser;
      }
   }
}

