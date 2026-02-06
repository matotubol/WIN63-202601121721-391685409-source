package com.sulake.habbo.communication.messages.incoming.room.session
{
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.room.session.FlatAccessibleMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class FlatAccessibleMessageEvent extends MessageEvent
   {
      
      public function FlatAccessibleMessageEvent(param1:Function)
      {
         super(param1,FlatAccessibleMessageEventParser);
      }
      
      public function getParser() : FlatAccessibleMessageEventParser
      {
         return var_15 as FlatAccessibleMessageEventParser;
      }
   }
}

