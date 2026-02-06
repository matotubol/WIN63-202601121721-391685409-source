package com.sulake.habbo.communication.messages.incoming.inventory.achievements
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class class_3303
   {
      
      public static const const_988:int = -1;
      
      public static const const_184:int = 0;
      
      public static const const_512:int = 1;
      
      public static const const_556:int = 2;
      
      private var var_2755:int;
      
      private var var_2493:int;
      
      private var var_605:String;
      
      private var var_3134:int;
      
      private var var_3805:int;
      
      private var var_4189:int;
      
      private var var_4375:int;
      
      private var var_3013:int;
      
      private var var_3600:Boolean;
      
      private var var_191:String;
      
      private var var_5078:String;
      
      private var var_4874:int;
      
      private var var_5113:int;
      
      private var var_61:int;
      
      public function class_3303(param1:IMessageDataWrapper)
      {
         super();
         var_2755 = param1.readInteger();
         var_2493 = param1.readInteger();
         var_605 = param1.readString();
         var_3134 = param1.readInteger();
         var_3805 = Math.max(1,param1.readInteger());
         var_4189 = param1.readInteger();
         var_4375 = param1.readInteger();
         var_3013 = param1.readInteger();
         var_3600 = param1.readBoolean();
         var_191 = param1.readString();
         var_5078 = param1.readString();
         var_4874 = param1.readInteger();
         var_5113 = param1.readInteger();
         var_61 = param1.readShort();
      }
      
      public function get achievementId() : int
      {
         return var_2755;
      }
      
      public function get badgeId() : String
      {
         return var_605;
      }
      
      public function get level() : int
      {
         return var_2493;
      }
      
      public function get scoreAtStartOfLevel() : int
      {
         return var_3134;
      }
      
      public function get scoreLimit() : int
      {
         return var_3805 - var_3134;
      }
      
      public function get levelRewardPoints() : int
      {
         return var_4189;
      }
      
      public function get levelRewardPointType() : int
      {
         return var_4375;
      }
      
      public function get currentPoints() : int
      {
         return var_3013 - var_3134;
      }
      
      public function get finalLevel() : Boolean
      {
         return var_3600;
      }
      
      public function get category() : String
      {
         return var_191;
      }
      
      public function get subCategory() : String
      {
         return var_5078;
      }
      
      public function get levelCount() : int
      {
         return var_4874;
      }
      
      public function get state() : int
      {
         return var_61;
      }
      
      public function get firstLevelAchieved() : Boolean
      {
         return var_2493 > 1 || var_3600;
      }
      
      public function setMaxProgress() : void
      {
         var_3013 = var_3805;
      }
      
      public function get displayMethod() : int
      {
         return var_5113;
      }
   }
}

