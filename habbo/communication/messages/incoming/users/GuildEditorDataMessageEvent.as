package com.sulake.habbo.communication.messages.incoming.users
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.users.GuildEditorDataMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class GuildEditorDataMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function GuildEditorDataMessageEvent(param1:Function)
      {
         super(param1,GuildEditorDataMessageEventParser);
      }
      
      public function get data() : class_1957
      {
         return GuildEditorDataMessageEventParser(var_15).data;
      }
   }
}

