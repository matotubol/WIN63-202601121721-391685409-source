package com.sulake.habbo.communication.messages.incoming.talent
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.talent.TalentTrackMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class TalentTrackMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function TalentTrackMessageEvent(param1:Function)
      {
         super(param1,TalentTrackMessageEventParser);
      }
      
      public function getParser() : TalentTrackMessageEventParser
      {
         return var_15 as TalentTrackMessageEventParser;
      }
   }
}

