package com.sulake.habbo.communication.messages.incoming.users
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class class_3429
   {
      
      private var var_5161:int;
      
      private var var_4823:String;
      
      private var var_4898:Number;
      
      private var var_5015:int;
      
      private var var_4887:int;
      
      private var var_4956:int;
      
      private var var_4340:int;
      
      private var var_5137:int;
      
      private var var_4928:int;
      
      public function class_3429(param1:IMessageDataWrapper = null)
      {
         super();
         var_5161 = param1.readInteger();
         var_4823 = param1.readString();
         var_4898 = param1.readDouble();
         var_5015 = param1.readInteger();
         var_4887 = param1.readInteger();
         var_4956 = param1.readInteger();
         var_4340 = param1.readInteger();
         var_5137 = param1.readInteger();
         var_4928 = param1.readInteger();
      }
      
      public function get currentHcStreak() : int
      {
         return var_5161;
      }
      
      public function get firstSubscriptionDate() : String
      {
         return var_4823;
      }
      
      public function get kickbackPercentage() : Number
      {
         return var_4898;
      }
      
      public function get totalCreditsMissed() : int
      {
         return var_5015;
      }
      
      public function get totalCreditsRewarded() : int
      {
         return var_4887;
      }
      
      public function get totalCreditsSpent() : int
      {
         return var_4956;
      }
      
      public function get creditRewardForStreakBonus() : int
      {
         return var_4340;
      }
      
      public function get creditRewardForMonthlySpent() : int
      {
         return var_5137;
      }
      
      public function get timeUntilPayday() : int
      {
         return var_4928;
      }
   }
}

