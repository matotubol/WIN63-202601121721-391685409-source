package com.sulake.habbo.communication.messages.parser.competition
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class CompetitionVotingInfoMessageEventParser implements IMessageParser
   {
      
      private var var_3122:int;
      
      private var var_897:String;
      
      private var var_1587:int;
      
      private var var_3873:int;
      
      public function CompetitionVotingInfoMessageEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_3122 = param1.readInteger();
         var_897 = param1.readString();
         var_1587 = param1.readInteger();
         var_3873 = param1.readInteger();
         return true;
      }
      
      public function get goalId() : int
      {
         return var_3122;
      }
      
      public function get goalCode() : String
      {
         return var_897;
      }
      
      public function get isVotingAllowedForUser() : Boolean
      {
         return var_1587 == 0;
      }
      
      public function get votesRemaining() : int
      {
         return var_3873;
      }
      
      public function get resultCode() : int
      {
         return var_1587;
      }
   }
}

