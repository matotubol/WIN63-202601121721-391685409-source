package com.sulake.habbo.friendbar.landingview.widget
{
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.class_2010;
   import com.sulake.habbo.friendbar.landingview.*;
   import com.sulake.habbo.friendbar.landingview.interfaces.ILandingViewWidget;
   import com.sulake.habbo.friendbar.landingview.interfaces.ISettingsAwareWidget;
   import com.sulake.habbo.friendbar.landingview.layout.CommonWidgetSettings;
   import com.sulake.habbo.friendbar.landingview.layout.WidgetContainerLayout;
   import com.sulake.habbo.window.widgets.class_2478;
   import package_39.class_1884;
   import package_4.class_2005;
   import package_62.class_2885;
   import package_62.class_4083;
   
   public class CommunityGoalPrizesWidget implements ILandingViewWidget, ISettingsAwareWidget
   {
      
      private var _landingView:HabboLandingView;
      
      private var _container:class_1812;
      
      private var var_24:class_4083;
      
      private var var_975:String;
      
      public function CommunityGoalPrizesWidget(param1:HabboLandingView)
      {
         super();
         _landingView = param1;
      }
      
      public function get container() : class_1741
      {
         return _container;
      }
      
      public function dispose() : void
      {
         _landingView = null;
         _container = null;
         var_24 = null;
      }
      
      public function initialize() : void
      {
         _container = class_1812(_landingView.getXmlWindow("achievement_competition_prizes"));
         _landingView.communicationManager.addHabboConnectionMessageEvent(new class_2005(onUserObject));
         _landingView.communicationManager.addHabboConnectionMessageEvent(new class_2885(onCommunityGoalProgress));
         _landingView.communicationManager.addHabboConnectionMessageEvent(new class_1884(onUserChange));
      }
      
      public function refresh() : void
      {
         refreshContent();
      }
      
      public function get disposed() : Boolean
      {
         return _landingView == null;
      }
      
      private function refreshContent() : void
      {
         if(var_24 == null)
         {
            _container.visible = false;
            return;
         }
         _container.visible = true;
         setPrizeRankLimits(1);
         setPrizeRankLimits(2);
         setPrizeRankLimits(3);
         _landingView.localizationManager.registerParameter(getCompetitionSpecificKey("yourrankinfo"),"points","" + var_24.personalContributionScore);
         _container.findChildByName("caption_txt").caption = getCompetitionSpecificText("caption");
         _container.findChildByName("info_txt").caption = getCompetitionSpecificText("info");
         _container.findChildByName("reward_name_txt").caption = getCompetitionSpecificText("rewardname");
         _container.findChildByName("reward_info_txt").caption = getCompetitionSpecificText("rewardinfo");
         _container.findChildByName("rank_1_txt").caption = getCompetitionSpecificText("rank1");
         _container.findChildByName("rank_2_txt").caption = getCompetitionSpecificText("rank2");
         _container.findChildByName("rank_3_txt").caption = getCompetitionSpecificText("rank3");
         _container.findChildByName("user_rank_border").visible = !var_24.hasGoalExpired || var_24.personalContributionRank > 0;
         var _loc1_:String = var_24.hasGoalExpired ? "yourfinalrank" : (var_24.personalContributionRank > 0 ? "yourrank" : "youarenotranked");
         _landingView.localizationManager.registerParameter(getKey(_loc1_),"rank","" + var_24.personalContributionRank);
         _container.findChildByName("user_rank_txt").caption = getText(_loc1_);
         _container.findChildByName("user_rank_info_txt").visible = !var_24.hasGoalExpired;
         _container.findChildByName("user_rank_info_txt").caption = getCompetitionSpecificText(var_24.personalContributionRank > 0 ? "yourrankinfo" : "youarenotrankedinfo");
         IStaticBitmapWrapperWindow(_container.findChildByName("reward_image")).assetUri = "${image.library.url}reception/" + var_24.goalCode + "Reward.png";
      }
      
      private function setPrizeRankLimits(param1:int) : void
      {
         var _loc4_:int = 0;
         _loc4_ = 0;
         var _loc5_:int = 1;
         _loc4_ = 0;
         while(_loc4_ < param1)
         {
            _loc5_ += resolveStartRank(param1 - _loc4_);
            _loc4_++;
         }
         var _loc3_:int = 0;
         _loc4_ = 0;
         while(_loc4_ < param1)
         {
            _loc3_ += resolveEndRank(param1 - _loc4_);
            _loc4_++;
         }
         var _loc6_:String = _loc5_ == _loc3_ ? getKey("rank") : getKey("ranks");
         var _loc2_:* = _landingView.localizationManager.getLocalizationWithParams(_loc6_,"","start",_loc5_,"end",_loc3_);
         _container.findChildByName("rank_" + param1 + "_info_txt").caption = _loc2_;
      }
      
      private function resolveStartRank(param1:int) : int
      {
         return var_24.rewardUserLimits[param1 - 2];
      }
      
      private function resolveEndRank(param1:int) : int
      {
         return var_24.rewardUserLimits[param1 - 1];
      }
      
      private function onCommunityGoalProgress(param1:class_2885) : void
      {
         var_24 = param1.getParser().data;
         refreshContent();
      }
      
      private function getKey(param1:String) : String
      {
         return "landing.view.competition.prizes." + param1;
      }
      
      private function getCompetitionSpecificKey(param1:String) : String
      {
         var _loc2_:String = getKey(var_24.goalCode + "." + param1);
         class_21.log("foobar: " + _loc2_);
         return _loc2_;
      }
      
      private function getCompetitionSpecificText(param1:String) : String
      {
         var _loc2_:String = getCompetitionSpecificKey(param1);
         return "${" + _loc2_ + "}";
      }
      
      private function getText(param1:String) : String
      {
         var _loc2_:String = getKey(param1);
         return "${" + _loc2_ + "}";
      }
      
      private function onUserObject(param1:class_2005) : void
      {
         var_975 = param1.getParser().figure;
         refreshAvatarInfo();
      }
      
      private function onUserChange(param1:class_1884) : void
      {
         if(param1 != null && param1.id == -1)
         {
            var_975 = param1.figure;
            refreshAvatarInfo();
         }
      }
      
      private function refreshAvatarInfo() : void
      {
         var _loc1_:class_2010 = class_2010(_container.findChildByName("avatar_image"));
         var _loc2_:class_2478 = class_2478(_loc1_.widget);
         _loc2_.figure = var_975;
      }
      
      public function set settings(param1:CommonWidgetSettings) : void
      {
         WidgetContainerLayout.applyCommonWidgetSettings(_container,param1);
      }
   }
}

