package com.sulake.habbo.communication.messages.parser.game.lobby
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class AchievementResolutionCompletedMessageEventParser implements IMessageParser
   {
      
      private var var_3283:String;
      
      private var var_2806:String;
      
      public function AchievementResolutionCompletedMessageEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         var_3283 = "";
         var_2806 = "";
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_3283 = param1.readString();
         var_2806 = param1.readString();
         return true;
      }
      
      public function get stuffCode() : String
      {
         return var_3283;
      }
      
      public function get badgeCode() : String
      {
         return var_2806;
      }
   }
}

