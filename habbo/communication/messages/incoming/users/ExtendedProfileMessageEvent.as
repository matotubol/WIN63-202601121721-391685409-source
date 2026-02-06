package com.sulake.habbo.communication.messages.incoming.users
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.users.ExtendedProfileMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class ExtendedProfileMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function ExtendedProfileMessageEvent(param1:Function)
      {
         super(param1,ExtendedProfileMessageEventParser);
      }
      
      public function get data() : class_2228
      {
         return ExtendedProfileMessageEventParser(var_15).data;
      }
   }
}

