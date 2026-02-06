package com.sulake.habbo.communication.messages.incoming.room.session
{
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.room.session.HanditemConfigurationMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class HanditemConfigurationMessageEvent extends MessageEvent
   {
      
      public function HanditemConfigurationMessageEvent(param1:Function)
      {
         super(param1,HanditemConfigurationMessageEventParser);
      }
      
      public function getParser() : HanditemConfigurationMessageEventParser
      {
         return var_15 as HanditemConfigurationMessageEventParser;
      }
   }
}

