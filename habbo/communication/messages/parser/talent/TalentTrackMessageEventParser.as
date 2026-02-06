package com.sulake.habbo.communication.messages.parser.talent
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class TalentTrackMessageEventParser implements IMessageParser
   {
      
      private var _talentTrack:class_3929;
      
      public function TalentTrackMessageEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         _talentTrack = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _talentTrack = new class_3929();
         _talentTrack.parse(param1);
         return true;
      }
      
      public function getTalentTrack() : class_3929
      {
         return _talentTrack;
      }
   }
}

