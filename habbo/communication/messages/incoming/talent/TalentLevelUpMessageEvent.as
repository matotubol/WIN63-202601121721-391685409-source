package com.sulake.habbo.communication.messages.incoming.talent
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.talent.TalentLevelUpMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class TalentLevelUpMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function TalentLevelUpMessageEvent(param1:Function)
      {
         super(param1,TalentLevelUpMessageEventParser);
      }
      
      public function getParser() : TalentLevelUpMessageEventParser
      {
         return var_15 as TalentLevelUpMessageEventParser;
      }
   }
}

