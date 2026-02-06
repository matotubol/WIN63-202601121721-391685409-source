package com.sulake.habbo.communication.messages.incoming.room.permissions
{
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.room.permissions.YouAreOwnerMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class YouAreOwnerMessageEvent extends MessageEvent
   {
      
      public function YouAreOwnerMessageEvent(param1:Function)
      {
         super(param1,YouAreOwnerMessageEventParser);
      }
      
      public function getParser() : YouAreOwnerMessageEventParser
      {
         return var_15 as YouAreOwnerMessageEventParser;
      }
   }
}

