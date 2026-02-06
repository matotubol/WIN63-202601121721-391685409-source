package com.sulake.habbo.communication.messages.parser.game.lobby
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class AchievementResolutionProgressMessageEventParser implements IMessageParser
   {
      
      private var _stuffId:int;
      
      private var var_2755:int;
      
      private var var_3015:String;
      
      private var var_2868:int;
      
      private var var_3180:int;
      
      private var _endTime:int;
      
      public function AchievementResolutionProgressMessageEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         _stuffId = -1;
         var_2755 = 0;
         var_3015 = "";
         var_2868 = 0;
         var_3180 = 0;
         _endTime = 0;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _stuffId = param1.readInteger();
         var_2755 = param1.readInteger();
         var_3015 = param1.readString();
         var_2868 = param1.readInteger();
         var_3180 = param1.readInteger();
         _endTime = param1.readInteger();
         return true;
      }
      
      public function get stuffId() : int
      {
         return _stuffId;
      }
      
      public function get achievementId() : int
      {
         return var_2755;
      }
      
      public function get requiredLevelBadgeCode() : String
      {
         return var_3015;
      }
      
      public function get userProgress() : int
      {
         return var_2868;
      }
      
      public function get totalProgress() : int
      {
         return var_3180;
      }
      
      public function get endTime() : int
      {
         return _endTime;
      }
   }
}

