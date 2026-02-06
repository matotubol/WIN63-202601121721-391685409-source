package com.sulake.habbo.communication.messages.parser.game.lobby
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.parser.inventory.achievements.AchievementsEventParser;
   
   public class UserGameAchievementsMessageParser implements IMessageParser
   {
      
      private var var_2912:int;
      
      private var var_1423:AchievementsEventParser;
      
      public function UserGameAchievementsMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_2912 = param1.readInteger();
         var_1423 = new AchievementsEventParser();
         var_1423.parse(param1);
         return true;
      }
      
      public function get gameTypeId() : int
      {
         return var_2912;
      }
      
      public function get achievements() : Array
      {
         return var_1423.achievements;
      }
      
      public function get defaultCategory() : String
      {
         return var_1423.defaultCategory;
      }
   }
}

