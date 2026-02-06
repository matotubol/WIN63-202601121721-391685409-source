package com.sulake.habbo.communication.messages.incoming.quest
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class class_2098
   {
      
      private var var_2955:String;
      
      private var var_3737:int;
      
      private var var_3414:int;
      
      private var var_2381:int;
      
      private var var_197:int;
      
      private var var_2940:Boolean;
      
      private var var_230:String;
      
      private var var_3851:String;
      
      private var var_4689:int;
      
      private var var_3645:String;
      
      private var var_3577:int;
      
      private var var_2919:int;
      
      private var var_3399:int;
      
      private var var_4967:int;
      
      private var _catalogPageName:String;
      
      private var var_3552:String;
      
      private var var_4351:Boolean;
      
      private var var_2705:Boolean;
      
      private var var_3145:int;
      
      private var var_2926:Date = new Date();
      
      public function class_2098(param1:IMessageDataWrapper)
      {
         super();
         var_2955 = param1.readString();
         var_3737 = param1.readInteger();
         var_3414 = param1.readInteger();
         var_2381 = param1.readInteger();
         var_197 = param1.readInteger();
         var_2940 = param1.readBoolean();
         var_230 = param1.readString();
         var_3851 = param1.readString();
         var_4689 = param1.readInteger();
         var_3645 = param1.readString();
         var_3577 = param1.readInteger();
         var_2919 = param1.readInteger();
         var_4967 = param1.readInteger();
         _catalogPageName = param1.readString();
         var_3552 = param1.readString();
         var_4351 = param1.readBoolean();
         var_2705 = param1.readBoolean();
         if(var_2705)
         {
            var_3145 = param1.readInteger();
         }
      }
      
      public static function getCampaignLocalizationKeyForCode(param1:String) : String
      {
         return "quests." + param1;
      }
      
      public function get campaignCode() : String
      {
         return var_2955;
      }
      
      public function get localizationCode() : String
      {
         return var_3645;
      }
      
      public function get completedQuestsInCampaign() : int
      {
         return var_3737;
      }
      
      public function get questCountInCampaign() : int
      {
         return var_3414;
      }
      
      public function get activityPointType() : int
      {
         return var_2381;
      }
      
      public function get accepted() : Boolean
      {
         return var_2940;
      }
      
      public function get id() : int
      {
         return var_197;
      }
      
      public function get type() : String
      {
         return var_230;
      }
      
      public function get imageVersion() : String
      {
         return var_3851;
      }
      
      public function get rewardCurrencyAmount() : int
      {
         return var_4689;
      }
      
      public function get completedSteps() : int
      {
         return var_3577;
      }
      
      public function get totalSteps() : int
      {
         return var_2919;
      }
      
      public function get isCompleted() : Boolean
      {
         return var_3577 == var_2919;
      }
      
      public function get waitPeriodSeconds() : int
      {
         if(var_3399 < 1)
         {
            return 0;
         }
         var _loc1_:Date = new Date();
         var _loc2_:int = _loc1_.getTime() - var_2926.getTime();
         return int(Math.max(0,var_3399 - Math.floor(_loc2_ / 1000)));
      }
      
      public function get isSeasonal() : Boolean
      {
         return var_2705;
      }
      
      public function get secondsLeft() : int
      {
         if(var_3145 <= 0)
         {
            return 0;
         }
         var _loc1_:Date = new Date();
         var _loc2_:int = (_loc1_.getTime() - var_2926.getTime()) / 1000;
         return var_3145 - _loc2_;
      }
      
      public function getCampaignLocalizationKey() : String
      {
         return getCampaignLocalizationKeyForCode(campaignCode);
      }
      
      public function getQuestLocalizationKey() : String
      {
         return this.getCampaignLocalizationKey() + "." + var_3645;
      }
      
      public function get completedCampaign() : Boolean
      {
         return var_197 < 1;
      }
      
      public function set id(param1:int) : void
      {
         var_197 = param1;
      }
      
      public function set accepted(param1:Boolean) : void
      {
         var_2940 = param1;
      }
      
      public function get lastQuestInCampaign() : Boolean
      {
         return var_3737 >= var_3414;
      }
      
      public function get receiveTime() : Date
      {
         return var_2926;
      }
      
      public function set waitPeriodSeconds(param1:int) : void
      {
         var_3399 = param1;
      }
      
      public function get sortOrder() : int
      {
         return var_4967;
      }
      
      public function get catalogPageName() : String
      {
         return _catalogPageName;
      }
      
      public function get chainCode() : String
      {
         return var_3552;
      }
      
      public function get campaignChainCode() : String
      {
         if(var_2705)
         {
            return var_2955 + "." + var_3552;
         }
         return var_2955;
      }
      
      public function get easy() : Boolean
      {
         return var_4351;
      }
   }
}

