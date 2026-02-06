package com.sulake.habbo.communication.messages.incoming.quest
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class class_4101
   {
      
      private var var_3898:int;
      
      private var var_4141:String;
      
      private var var_5009:int;
      
      private var var_4886:String;
      
      private var var_4359:Boolean;
      
      private var _localizedName:String;
      
      public function class_4101(param1:IMessageDataWrapper)
      {
         super();
         var_3898 = param1.readInteger();
         var_4141 = param1.readString();
         var_5009 = param1.readInteger();
         var_4886 = param1.readString();
         var_4359 = param1.readBoolean();
         _localizedName = param1.readString();
      }
      
      public function get communityGoalId() : int
      {
         return var_3898;
      }
      
      public function get communityGoalCode() : String
      {
         return var_4141;
      }
      
      public function get userRank() : int
      {
         return var_5009;
      }
      
      public function get rewardCode() : String
      {
         return var_4886;
      }
      
      public function get badge() : Boolean
      {
         return var_4359;
      }
      
      public function get localizedName() : String
      {
         return _localizedName;
      }
   }
}

