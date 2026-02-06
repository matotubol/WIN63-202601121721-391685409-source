package com.sulake.habbo.communication.messages.incoming.room.permissions
{
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.room.permissions.YouAreControllerMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class YouAreControllerMessageEvent extends MessageEvent
   {
      
      public function YouAreControllerMessageEvent(param1:Function)
      {
         super(param1,YouAreControllerMessageEventParser);
      }
      
      public function getParser() : YouAreControllerMessageEventParser
      {
         return var_15 as YouAreControllerMessageEventParser;
      }
   }
}

