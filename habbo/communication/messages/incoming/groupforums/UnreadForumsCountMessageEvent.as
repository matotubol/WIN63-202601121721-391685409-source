package com.sulake.habbo.communication.messages.incoming.groupforums
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.groupforums.UnreadForumsCountMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class UnreadForumsCountMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function UnreadForumsCountMessageEvent(param1:Function)
      {
         super(param1,UnreadForumsCountMessageEventParser);
      }
      
      public function getParser() : UnreadForumsCountMessageEventParser
      {
         return this.var_15 as UnreadForumsCountMessageEventParser;
      }
   }
}

