package com.sulake.habbo.communication.messages.incoming.groupforums
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.groupforums.ForumsListMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class ForumsListMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function ForumsListMessageEvent(param1:Function)
      {
         super(param1,ForumsListMessageEventParser);
      }
      
      public function getParser() : ForumsListMessageEventParser
      {
         return ForumsListMessageEventParser(this.var_15);
      }
   }
}

