package com.sulake.habbo.communication.messages.incoming.roomsettings
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.roomsettings.FlatControllersEventParser;
   
   [SecureSWF(rename="true")]
   public class FlatControllersEvent extends MessageEvent implements IMessageEvent
   {
      
      public function FlatControllersEvent(param1:Function)
      {
         super(param1,FlatControllersEventParser);
      }
      
      public function getParser() : FlatControllersEventParser
      {
         return this.var_15 as FlatControllersEventParser;
      }
   }
}

