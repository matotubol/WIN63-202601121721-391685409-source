package com.sulake.habbo.communication.messages.incoming.groupforums
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.groupforums.UpdateMessageMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class UpdateMessageMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function UpdateMessageMessageEvent(param1:Function)
      {
         super(param1,UpdateMessageMessageEventParser);
      }
      
      public function getParser() : UpdateMessageMessageEventParser
      {
         return this.var_15 as UpdateMessageMessageEventParser;
      }
   }
}

