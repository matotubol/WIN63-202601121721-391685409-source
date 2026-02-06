package com.sulake.habbo.communication.messages.incoming.moderation
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class class_3770
   {
      
      private var var_1270:int;
      
      private var _userName:String;
      
      private var var_4620:int;
      
      private var var_4765:int;
      
      private var var_3279:Boolean;
      
      private var var_4718:int;
      
      private var var_4554:int;
      
      private var var_4792:int;
      
      private var var_5086:int;
      
      private var var_4828:int;
      
      private var var_4093:String;
      
      private var var_4256:String;
      
      private var var_3182:int;
      
      private var var_4988:int;
      
      private var var_4305:String;
      
      private var var_975:String;
      
      private var var_4613:String;
      
      private var var_4192:String = "";
      
      private var var_4735:int = 0;
      
      public function class_3770(param1:IMessageDataWrapper)
      {
         super();
         var_1270 = param1.readInteger();
         _userName = param1.readString();
         var_975 = param1.readString();
         var_4620 = param1.readInteger();
         var_4765 = param1.readInteger();
         var_3279 = param1.readBoolean();
         var_4718 = param1.readInteger();
         var_4554 = param1.readInteger();
         var_4792 = param1.readInteger();
         var_5086 = param1.readInteger();
         var_4828 = param1.readInteger();
         var_4093 = param1.readString();
         var_4256 = param1.readString();
         var_3182 = param1.readInteger();
         var_4988 = param1.readInteger();
         var_4305 = param1.readString();
         var_4613 = param1.readString();
         if(param1.bytesAvailable)
         {
            var_4192 = param1.readString();
            var_4735 = param1.readInteger();
         }
      }
      
      public function get userId() : int
      {
         return var_1270;
      }
      
      public function get userName() : String
      {
         return _userName;
      }
      
      public function get figure() : String
      {
         return var_975;
      }
      
      public function get registrationAgeInMinutes() : int
      {
         return var_4620;
      }
      
      public function get minutesSinceLastLogin() : int
      {
         return var_4765;
      }
      
      public function get online() : Boolean
      {
         return var_3279;
      }
      
      public function get cfhCount() : int
      {
         return var_4718;
      }
      
      public function get abusiveCfhCount() : int
      {
         return var_4554;
      }
      
      public function get cautionCount() : int
      {
         return var_4792;
      }
      
      public function get banCount() : int
      {
         return var_5086;
      }
      
      public function get tradingLockCount() : int
      {
         return var_4828;
      }
      
      public function get tradingExpiryDate() : String
      {
         return var_4093;
      }
      
      public function get lastPurchaseDate() : String
      {
         return var_4256;
      }
      
      public function get identityId() : int
      {
         return var_3182;
      }
      
      public function get identityRelatedBanCount() : int
      {
         return var_4988;
      }
      
      public function get primaryEmailAddress() : String
      {
         return var_4305;
      }
      
      public function get userClassification() : String
      {
         return var_4613;
      }
      
      public function get lastSanctionTime() : String
      {
         return var_4192;
      }
      
      public function get sanctionAgeHours() : int
      {
         return var_4735;
      }
   }
}

