package com.sulake.habbo.communication.messages.incoming.quest
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.runtime.class_13;
   
   [SecureSWF(rename="true")]
   public class class_4083 implements class_13
   {
      
      private var var_4723:Boolean;
      
      private var var_4559:int;
      
      private var var_4706:int;
      
      private var var_5021:int;
      
      private var var_4965:int;
      
      private var var_4432:int;
      
      private var var_4504:int;
      
      private var var_897:String;
      
      private var var_4819:int;
      
      private var var_1877:Array = [];
      
      public function class_4083(param1:IMessageDataWrapper)
      {
         super();
         var_4723 = param1.readBoolean();
         var_4559 = param1.readInteger();
         var_4706 = param1.readInteger();
         var_5021 = param1.readInteger();
         var_4965 = param1.readInteger();
         var_4432 = param1.readInteger();
         var_4504 = param1.readInteger();
         var_897 = param1.readString();
         var_4819 = param1.readInteger();
         var _loc2_:int = param1.readInteger();
         var _loc3_:int = 0;
         while(0 < _loc2_)
         {
            var_1877.push(param1.readInteger());
            _loc3_++;
         }
      }
      
      public function dispose() : void
      {
         var_1877 = null;
      }
      
      public function get disposed() : Boolean
      {
         return var_1877 == null;
      }
      
      public function get hasGoalExpired() : Boolean
      {
         return var_4723;
      }
      
      public function get personalContributionScore() : int
      {
         return var_4559;
      }
      
      public function get personalContributionRank() : int
      {
         return var_4706;
      }
      
      public function get communityTotalScore() : int
      {
         return var_5021;
      }
      
      public function get communityHighestAchievedLevel() : int
      {
         return var_4965;
      }
      
      public function get scoreRemainingUntilNextLevel() : int
      {
         return var_4432;
      }
      
      public function get percentCompletionTowardsNextLevel() : int
      {
         return var_4504;
      }
      
      public function get timeRemainingInSeconds() : int
      {
         return var_4819;
      }
      
      public function get rewardUserLimits() : Array
      {
         return var_1877;
      }
      
      public function get goalCode() : String
      {
         return var_897;
      }
   }
}

