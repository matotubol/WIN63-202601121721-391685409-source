package com.sulake.habbo.communication.messages.incoming.notifications
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class class_2847
   {
      
      private var var_230:int;
      
      private var var_2493:int;
      
      private var var_3439:int;
      
      private var var_4189:int;
      
      private var var_4375:int;
      
      private var var_4714:int;
      
      private var var_605:int;
      
      private var var_2806:String = "";
      
      private var var_4521:String = "";
      
      private var var_4019:int;
      
      private var var_191:String;
      
      private var var_5001:Boolean;
      
      public function class_2847(param1:IMessageDataWrapper)
      {
         super();
         var_230 = param1.readInteger();
         var_2493 = param1.readInteger();
         var_605 = param1.readInteger();
         var_2806 = param1.readString();
         var_3439 = param1.readInteger();
         var_4189 = param1.readInteger();
         var_4375 = param1.readInteger();
         var_4714 = param1.readInteger();
         var_4019 = param1.readInteger();
         var_4521 = param1.readString();
         var_191 = param1.readString();
         var_5001 = param1.readBoolean();
      }
      
      public function get type() : int
      {
         return var_230;
      }
      
      public function get level() : int
      {
         return var_2493;
      }
      
      public function get points() : int
      {
         return var_3439;
      }
      
      public function get levelRewardPoints() : int
      {
         return var_4189;
      }
      
      public function get levelRewardPointType() : int
      {
         return var_4375;
      }
      
      public function get bonusPoints() : int
      {
         return var_4714;
      }
      
      public function get badgeId() : int
      {
         return var_605;
      }
      
      public function get badgeCode() : String
      {
         return var_2806;
      }
      
      public function get removedBadgeCode() : String
      {
         return var_4521;
      }
      
      public function get achievementID() : int
      {
         return var_4019;
      }
      
      public function get category() : String
      {
         return var_191;
      }
      
      public function get showDialogToUser() : Boolean
      {
         return var_5001;
      }
   }
}

