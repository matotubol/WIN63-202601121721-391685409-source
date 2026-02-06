package com.sulake.habbo.communication.messages.parser.room.session
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class YouArePlayingGameMessageEventParser implements IMessageParser
   {
      
      private var var_900:Boolean = false;
      
      public function YouArePlayingGameMessageEventParser()
      {
         super();
      }
      
      public function get isPlaying() : Boolean
      {
         return var_900;
      }
      
      public function flush() : Boolean
      {
         var_900 = false;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_900 = param1.readBoolean();
         return true;
      }
   }
}

