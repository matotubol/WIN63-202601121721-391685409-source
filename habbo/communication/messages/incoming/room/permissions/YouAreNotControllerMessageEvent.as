package com.sulake.habbo.communication.messages.incoming.room.permissions
{
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.room.permissions.YouAreNotControllerMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class YouAreNotControllerMessageEvent extends MessageEvent
   {
      
      public function YouAreNotControllerMessageEvent(param1:Function)
      {
         super(param1,YouAreNotControllerMessageEventParser);
      }
      
      public function getParser() : YouAreNotControllerMessageEventParser
      {
         return var_15 as YouAreNotControllerMessageEventParser;
      }
   }
}

