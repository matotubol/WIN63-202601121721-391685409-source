package com.sulake.habbo.communication.messages.parser.moderation
{
   import com.sulake.core.runtime.class_13;
   import flash.utils.getTimer;
   
   [SecureSWF(rename="true")]
   public class class_3291 implements class_13
   {
      
      public static const STATE_OPEN:int = 1;
      
      public static const const_951:int = 2;
      
      public static const const_585:int = 3;
      
      private var var_3038:int;
      
      private var var_61:int;
      
      private var var_2851:int;
      
      private var var_5149:int;
      
      private var var_3499:Number;
      
      private var _priority:int;
      
      private var var_3729:int;
      
      private var var_4609:int;
      
      private var var_4955:String;
      
      private var var_150:int;
      
      private var _reportedUserName:String;
      
      private var var_4242:int;
      
      private var var_4031:String;
      
      private var var_986:String;
      
      private var var_4684:int;
      
      private var var_2388:Array;
      
      private var var_1134:Boolean = false;
      
      private var var_4647:Number;
      
      public function class_3291(param1:int, param2:int, param3:int, param4:int, param5:Number, param6:int, param7:int, param8:int, param9:String, param10:int, param11:String, param12:int, param13:String, param14:String, param15:int, param16:Array)
      {
         super();
         var_3038 = param1;
         var_61 = param2;
         var_2851 = param3;
         var_5149 = param4;
         var_3499 = param5;
         _priority = param6;
         var_3729 = param7;
         var_4609 = param8;
         var_4955 = param9;
         var_150 = param10;
         _reportedUserName = param11;
         var_4242 = param12;
         var_4031 = param13;
         var_986 = param14;
         var_4684 = param15;
         var_2388 = param16;
         var_4647 = getTimer();
      }
      
      public function get issueId() : int
      {
         return var_3038;
      }
      
      public function get state() : int
      {
         return var_61;
      }
      
      public function get categoryId() : int
      {
         return var_2851;
      }
      
      public function get reportedCategoryId() : int
      {
         return var_5149;
      }
      
      public function get issueAgeInMilliseconds() : Number
      {
         return var_3499;
      }
      
      public function get priority() : int
      {
         return _priority;
      }
      
      public function get groupingId() : int
      {
         return var_3729;
      }
      
      public function get reporterUserId() : int
      {
         return var_4609;
      }
      
      public function get reporterUserName() : String
      {
         return var_4955;
      }
      
      public function get reportedUserId() : int
      {
         return var_150;
      }
      
      public function get reportedUserName() : String
      {
         return _reportedUserName;
      }
      
      public function get pickerUserId() : int
      {
         return var_4242;
      }
      
      public function get pickerUserName() : String
      {
         return var_4031;
      }
      
      public function get message() : String
      {
         return var_986;
      }
      
      public function get chatRecordId() : int
      {
         return var_4684;
      }
      
      public function get patterns() : Array
      {
         return var_2388;
      }
      
      public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         for each(var _loc1_ in var_2388)
         {
            _loc1_.dispose();
         }
         var_2388 = [];
         var_1134 = true;
      }
      
      public function get disposed() : Boolean
      {
         return var_1134;
      }
      
      public function getOpenTime(param1:int) : String
      {
         var _loc7_:int = (var_3499 + param1 - var_4647) / 1000;
         var _loc5_:int = _loc7_ / 60;
         var _loc6_:int = _loc5_ % 60;
         var _loc4_:int = _loc5_ / 60;
         var _loc2_:String = (_loc6_ < 10 ? "0" : "") + _loc6_;
         var _loc3_:String = (_loc4_ < 10 ? "0" : "") + _loc4_;
         return _loc3_ + ":" + _loc2_;
      }
   }
}

