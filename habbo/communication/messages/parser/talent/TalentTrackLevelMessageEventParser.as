package com.sulake.habbo.communication.messages.parser.talent
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class TalentTrackLevelMessageEventParser implements IMessageParser
   {
      
      private var var_2988:String;
      
      private var var_2493:int;
      
      private var var_4315:int;
      
      public function TalentTrackLevelMessageEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         var_2988 = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_2988 = param1.readString();
         var_2493 = param1.readInteger();
         var_4315 = param1.readInteger();
         return true;
      }
      
      public function get talentTrackName() : String
      {
         return var_2988;
      }
      
      public function get level() : int
      {
         return var_2493;
      }
      
      public function get maxLevel() : int
      {
         return var_4315;
      }
   }
}

