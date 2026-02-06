package com.sulake.habbo.communication.messages.incoming.quest
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.quest.SeasonalQuestsMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class SeasonalQuestsMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function SeasonalQuestsMessageEvent(param1:Function)
      {
         super(param1,SeasonalQuestsMessageEventParser);
      }
      
      public function getParser() : SeasonalQuestsMessageEventParser
      {
         return var_15 as SeasonalQuestsMessageEventParser;
      }
   }
}

