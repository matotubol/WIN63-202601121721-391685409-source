package com.sulake.habbo.communication.messages.parser.inventory.achievements
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class AchievementsScoreEventParser implements IMessageParser
   {
      
      private var var_808:int;
      
      public function AchievementsScoreEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_808 = param1.readInteger();
         return true;
      }
      
      public function get score() : int
      {
         return var_808;
      }
   }
}

