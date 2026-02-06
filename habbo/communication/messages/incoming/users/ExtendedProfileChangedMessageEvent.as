package com.sulake.habbo.communication.messages.incoming.users
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.users.ExtendedProfileChangedMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class ExtendedProfileChangedMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function ExtendedProfileChangedMessageEvent(param1:Function)
      {
         super(param1,ExtendedProfileChangedMessageEventParser);
      }
      
      public function get userId() : int
      {
         return ExtendedProfileChangedMessageEventParser(var_15).userId;
      }
   }
}

