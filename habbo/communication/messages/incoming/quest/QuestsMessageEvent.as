package com.sulake.habbo.communication.messages.incoming.quest
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.quest.QuestsMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class QuestsMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function QuestsMessageEvent(param1:Function)
      {
         super(param1,QuestsMessageEventParser);
      }
      
      public function getParser() : QuestsMessageEventParser
      {
         return var_15 as QuestsMessageEventParser;
      }
   }
}

