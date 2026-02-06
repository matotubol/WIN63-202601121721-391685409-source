package com.sulake.habbo.communication.messages.incoming.talent
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.talent.TalentTrackLevelMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class TalentTrackLevelMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function TalentTrackLevelMessageEvent(param1:Function)
      {
         super(param1,TalentTrackLevelMessageEventParser);
      }
      
      public function getParser() : TalentTrackLevelMessageEventParser
      {
         return var_15 as TalentTrackLevelMessageEventParser;
      }
   }
}

