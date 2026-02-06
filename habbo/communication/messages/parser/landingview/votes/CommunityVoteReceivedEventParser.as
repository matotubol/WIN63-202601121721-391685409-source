package com.sulake.habbo.communication.messages.parser.landingview.votes
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class CommunityVoteReceivedEventParser implements IMessageParser
   {
      
      private var var_3956:Boolean;
      
      public function CommunityVoteReceivedEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_3956 = param1.readBoolean();
         return true;
      }
      
      public function get acknowledged() : Boolean
      {
         return var_3956;
      }
   }
}

