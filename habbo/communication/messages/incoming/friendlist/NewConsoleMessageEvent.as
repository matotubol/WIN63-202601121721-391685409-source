package com.sulake.habbo.communication.messages.incoming.friendlist
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.friendlist.NewConsoleMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class NewConsoleMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function NewConsoleMessageEvent(param1:Function)
      {
         super(param1,NewConsoleMessageEventParser);
      }
      
      public function getParser() : NewConsoleMessageEventParser
      {
         return this.var_15 as NewConsoleMessageEventParser;
      }
   }
}

