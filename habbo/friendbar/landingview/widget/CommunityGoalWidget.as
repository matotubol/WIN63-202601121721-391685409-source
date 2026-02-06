package com.sulake.habbo.friendbar.landingview.widget
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.runtime.class_17;
   import com.sulake.core.runtime.class_31;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.communication.messages.outgoing.quest.GetCommunityGoalProgressMessageComposer;
   import com.sulake.habbo.communication.messages.parser.quest.CommunityGoalProgressMessageEventParser;
   import com.sulake.habbo.friendbar.landingview.*;
   import com.sulake.habbo.friendbar.landingview.interfaces.ILandingViewWidget;
   import com.sulake.habbo.friendbar.landingview.interfaces.ISettingsAwareWidget;
   import com.sulake.habbo.friendbar.landingview.layout.CommonWidgetSettings;
   import com.sulake.habbo.friendbar.landingview.layout.WidgetContainerLayout;
   import com.sulake.habbo.communication.messages.incoming.quest.CommunityGoalProgressMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.quest.class_4083;
   
   public class CommunityGoalWidget implements class_31, ILandingViewWidget, ISettingsAwareWidget
   {
      
      private static const METER_INITIAL_DELAY_MS:int = 1500;
      
      private static const METER_BUILDUP_TIME_MS:int = 1000;
      
      private static const CHALLENGE_LEVEL_NEEDLE_BASE_FRAMES:Array = [0,8,16,23];
      
      protected var _landingView:HabboLandingView;
      
      protected var var_156:class_1812;
      
      private var var_5000:IStaticBitmapWrapperWindow;
      
      protected var _communityProgress:class_4083;
      
      private var var_3118:Boolean = false;
      
      private var var_3621:Number = 0;
      
      private var _buildupProgress:Number = 0;
      
      private var var_265:Boolean = false;
      
      private var var_3808:Boolean = true;
      
      private var var_2469:Boolean = false;
      
      public function CommunityGoalWidget(param1:HabboLandingView, param2:Boolean = false)
      {
         super();
         _landingView = param1;
         var_2469 = param2;
      }
      
      public function get container() : class_1741
      {
         return var_156;
      }
      
      public function dispose() : void
      {
         if(_landingView != null && _landingView.windowManager)
         {
            class_17(_landingView.windowManager).removeUpdateReceiver(this);
         }
         _landingView = null;
         var_156 = null;
         _communityProgress = null;
      }
      
      public function get disposed() : Boolean
      {
         return _landingView == null;
      }
      
      public function initialize() : void
      {
         _landingView.communicationManager.addHabboConnectionMessageEvent(new CommunityGoalProgressMessageEvent(onCommunityGoalProgress));
         var_156 = class_1812(var_2469 ? _landingView.getXmlWindow("community_goal_voting") : _landingView.getXmlWindow("community_goal"));
         var_5000 = IStaticBitmapWrapperWindow(var_156.findChildByName("meter_needle"));
         if(!var_2469)
         {
            var _loc1_:class_1741 = var_156.findChildByName("community_catalog_button");
            var_3808 = _landingView.getBoolean("landing.view.community.interactive");
            null.visible = var_3808;
            null.procedure = onCommunityCatalogButtonClick;
         }
         HabboLandingView.positionAfterAndStretch(var_156,"community_title","hdr_line");
      }
      
      private function campaignizeMeterElementAssetUri(param1:class_1741) : void
      {
         var _loc3_:IStaticBitmapWrapperWindow = IStaticBitmapWrapperWindow(param1);
         var _loc2_:int = int(_loc3_.assetUri.indexOf(".png"));
         _loc3_.assetUri = _loc3_.assetUri.substr(0,_loc2_) + "_" + _communityProgress.goalCode + ".png";
      }
      
      protected function setCampaignLocalization(param1:String, param2:String) : void
      {
         var _loc3_:class_1741 = var_156.findChildByName(param1);
         if(_loc3_ != null)
         {
            _loc3_.caption = "${" + param2 + "." + _communityProgress.goalCode + "}";
         }
      }
      
      protected function getCurrentNeedleFrame() : int
      {
         if(_communityProgress.communityHighestAchievedLevel >= CHALLENGE_LEVEL_NEEDLE_BASE_FRAMES.length - 1)
         {
            return CHALLENGE_LEVEL_NEEDLE_BASE_FRAMES[CHALLENGE_LEVEL_NEEDLE_BASE_FRAMES.length - 1];
         }
         var _loc1_:int = int(CHALLENGE_LEVEL_NEEDLE_BASE_FRAMES[_communityProgress.communityHighestAchievedLevel]);
         var _loc2_:int = CHALLENGE_LEVEL_NEEDLE_BASE_FRAMES[_communityProgress.communityHighestAchievedLevel + 1] - _loc1_;
         return _loc1_ + Math.floor(_communityProgress.percentCompletionTowardsNextLevel * (_loc2_ + 0.001) / 100);
      }
      
      private function initializeLocalizations() : void
      {
         var _loc1_:int = 0;
         if(_communityProgress != null && _communityProgress.goalCode != null)
         {
            _loc1_ = 0;
            while(_loc1_ < CHALLENGE_LEVEL_NEEDLE_BASE_FRAMES.length)
            {
               campaignizeMeterElementAssetUri(var_156.findChildByName("meter_level_" + _loc1_));
               if(_loc1_ > 0)
               {
                  campaignizeMeterElementAssetUri(var_156.findChildByName("meter_level_" + _loc1_ + "_icon"));
                  campaignizeMeterElementAssetUri(var_156.findChildByName("meter_level_" + _loc1_ + "_icon_locked"));
               }
               _loc1_++;
            }
            setCampaignLocalization("community_title","landing.view.community.headline");
            setCampaignLocalization("goal_caption","landing.view.community.caption");
            setCampaignLocalization("goal_info","landing.view.community.info");
            setCampaignLocalization("community_catalog_button","landing.view.community_catalog_button.text");
            var_265 = true;
         }
      }
      
      private function refreshContent() : void
      {
         var _loc3_:int = 0;
         if(_communityProgress == null)
         {
            var_156.visible = false;
            return;
         }
         if(!var_265)
         {
            initializeLocalizations();
         }
         _loc3_ = 1;
         while(_loc3_ < CHALLENGE_LEVEL_NEEDLE_BASE_FRAMES.length)
         {
            var_156.findChildByName("meter_level_" + _loc3_).visible = false;
            var_156.findChildByName("meter_level_" + _loc3_ + "_icon").visible = false;
            var_156.findChildByName("meter_level_" + _loc3_ + "_icon_locked").visible = false;
            _loc3_++;
         }
         _landingView.localizationManager.registerParameter("landing.view.community.meter","userRank",_communityProgress.personalContributionRank.toString());
         _landingView.localizationManager.registerParameter("landing.view.community.meter","userAmount",_communityProgress.personalContributionScore.toString());
         _landingView.localizationManager.registerParameter("landing.view.community.meter","totalAmount",_communityProgress.communityTotalScore.toString());
         if(_communityProgress != null && _communityProgress.goalCode != null)
         {
            _landingView.localizationManager.registerParameter("landing.view.community.meter." + _communityProgress.goalCode,"totalAmount",_communityProgress.communityTotalScore.toString());
            setCampaignLocalization("community_total_status","landing.view.community.meter");
            if(var_2469)
            {
               setCampaignLocalization("community_vote_one_button","landing.view.vote_one_button.text");
               setCampaignLocalization("community_vote_two_button","landing.view.vote_two_button.text");
            }
         }
         var _loc1_:ITextWindow = ITextWindow(var_156.findChildByName("goal_info"));
         _loc1_.height = _loc1_.textHeight + 6;
         if(!var_2469)
         {
            var_156.findChildByName("community_catalog_button").visible = var_3808;
         }
         var_156.visible = true;
         var_156.invalidate();
      }
      
      protected function updateMeter(param1:int, param2:Boolean = true) : void
      {
         var _loc3_:int = 0;
         var _loc4_:Boolean = false;
         _loc3_ = 1;
         while(_loc3_ < CHALLENGE_LEVEL_NEEDLE_BASE_FRAMES.length)
         {
            _loc4_ = param2 && param1 >= CHALLENGE_LEVEL_NEEDLE_BASE_FRAMES[_loc3_];
            var_156.findChildByName("meter_level_" + _loc3_).visible = _loc4_;
            var_156.findChildByName("meter_level_" + _loc3_ + "_icon").visible = _loc4_;
            var_156.findChildByName("meter_level_" + _loc3_ + "_icon_locked").visible = !_loc4_;
            _loc3_++;
         }
         var_5000.assetUri = "landing_view_needle_meter_needle" + param1;
      }
      
      public function refresh() : void
      {
         requestCommunityGoalProgress();
         refreshContent();
      }
      
      private function requestCommunityGoalProgress() : void
      {
         if(!var_3118)
         {
            _landingView.send(new GetCommunityGoalProgressMessageComposer());
            var_3118 = true;
         }
      }
      
      public function update(param1:uint) : void
      {
         var_3621 += param1;
         if(var_3621 > 1500)
         {
            _buildupProgress += param1 / 1000;
            if(_buildupProgress > 1)
            {
               _buildupProgress = 1;
               class_17(_landingView.windowManager).removeUpdateReceiver(this);
            }
            updateMeter(Math.floor(getCurrentNeedleFrame() * _buildupProgress));
         }
      }
      
      private function onCommunityGoalProgress(param1:IMessageEvent) : void
      {
         _communityProgress = CommunityGoalProgressMessageEventParser(param1.parser).data;
         var_3118 = false;
         refreshContent();
         class_17(_landingView.windowManager).registerUpdateReceiver(this,10);
      }
      
      private function onCommunityCatalogButtonClick(param1:class_1758, param2:class_1741) : void
      {
         var _loc3_:String = null;
         if(param1.type == "WME_CLICK")
         {
            _loc3_ = _landingView.getProperty("landing.view.community.catalog.target");
            _landingView.catalog.openCatalogPage(_loc3_);
            _landingView.tracking.trackGoogle("landingView","click_communityCatalogTarget");
         }
      }
      
      public function set settings(param1:CommonWidgetSettings) : void
      {
         WidgetContainerLayout.applyCommonWidgetSettings(var_156,param1);
      }
      
      protected function get communityProgress() : class_4083
      {
         return _communityProgress;
      }
   }
}

