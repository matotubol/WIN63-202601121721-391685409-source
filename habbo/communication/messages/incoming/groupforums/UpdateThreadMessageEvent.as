package com.sulake.habbo.communication.messages.incoming.groupforums
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.groupforums.UpdateThreadMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class UpdateThreadMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function UpdateThreadMessageEvent(param1:Function)
      {
         super(param1,UpdateThreadMessageEventParser);
      }
      
      public function getParser() : UpdateThreadMessageEventParser
      {
         return this.var_15 as UpdateThreadMessageEventParser;
      }
   }
}

