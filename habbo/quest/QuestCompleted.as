package com.sulake.habbo.quest
{
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_2250;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.communication.messages.outgoing.quest.GetQuestsMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.quest.OpenQuestTrackerMessageComposer;
   import com.sulake.habbo.communication.messages.incoming.quest.class_2098;
   
   public class QuestCompleted implements class_13
   {
      
      private static const const_650:int = 2000;
      
      private static const TEXT_HEIGHT_SPACING:int = 5;
      
      private static const MIN_DESC_HEIGHT:int = 31;
      
      private var _window:class_2250;
      
      private var _questEngine:HabboQuestEngine;
      
      private var var_147:class_2098;
      
      private var var_1101:Animation;
      
      private var var_1926:int;
      
      public function QuestCompleted(param1:HabboQuestEngine)
      {
         super();
         _questEngine = param1;
      }
      
      public function dispose() : void
      {
         _questEngine = null;
         var_147 = null;
         if(_window)
         {
            _window.dispose();
            _window = null;
         }
         if(var_1101)
         {
            var_1101.dispose();
            var_1101 = null;
         }
      }
      
      public function get disposed() : Boolean
      {
         return _window == null;
      }
      
      public function onQuest(param1:class_2098) : void
      {
         close();
      }
      
      public function onQuestCancelled() : void
      {
         close();
      }
      
      public function onQuestCompleted(param1:class_2098, param2:Boolean) : void
      {
         if(param2)
         {
            prepare(param1);
            var_1926 = 2000;
         }
      }
      
      private function close() : void
      {
         if(_window)
         {
            _window.visible = false;
         }
      }
      
      private function onNextQuest(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         _window.visible = false;
         _questEngine.questController.questDetails.openForNextQuest = _questEngine.getBoolean("questing.showDetailsForNextQuest");
         _questEngine.send(new OpenQuestTrackerMessageComposer());
      }
      
      private function onMoreQuests(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type == "WME_CLICK")
         {
            _window.visible = false;
            _questEngine.questController.questsList.setOpenOnQuestsEvent();
            _questEngine.send(new GetQuestsMessageComposer());
         }
      }
      
      public function prepare(param1:class_2098) : void
      {
         var_147 = param1;
         if(_window == null)
         {
            _window = class_2250(_questEngine.getXmlWindow("QuestCompletedDialog"));
            _window.findChildByTag("close").procedure = onNextQuest;
            _window.findChildByName("next_quest_button").procedure = onNextQuest;
            _window.findChildByName("more_quests_button").procedure = onMoreQuests;
            _window.findChildByName("catalog_link_region").procedure = onCatalogLink;
            var_1101 = _questEngine.getTwinkleAnimation(_window);
         }
         _window.findChildByName("catalog_link_txt").caption = _questEngine.localization.getLocalizationWithParams("quests.completed.cataloglink","","currencyname",_questEngine.catalog.getActivityPointName(var_147.activityPointType));
         var _loc2_:String = "quests.completed.reward";
         _questEngine.localization.registerParameter(_loc2_,"amount",var_147.rewardCurrencyAmount.toString());
         _questEngine.localization.registerParameter(_loc2_,"currencyname",_questEngine.catalog.getActivityPointName(var_147.activityPointType));
         _window.findChildByName("reward_txt").caption = _questEngine.localization.getLocalization(_loc2_,_loc2_);
         _window.findChildByName("reward_txt").visible = var_147.activityPointType >= 0 && var_147.rewardCurrencyAmount > 0;
         _window.visible = false;
         _window.findChildByName("congrats_txt").caption = _questEngine.localization.getLocalization(var_147.lastQuestInCampaign ? "quests.completed.campaign.caption" : "quests.completed.quest.caption");
         _window.findChildByName("more_quests_button").visible = var_147.lastQuestInCampaign;
         _window.findChildByName("campaign_reward_icon").visible = var_147.lastQuestInCampaign;
         _window.findChildByName("catalog_link_region").visible = !var_147.lastQuestInCampaign && var_147.rewardCurrencyAmount > 0;
         _window.findChildByName("next_quest_button").visible = !var_147.lastQuestInCampaign;
         _window.findChildByName("reward_icon").visible = !var_147.lastQuestInCampaign;
         _window.findChildByName("campaign_reward_icon").visible = var_147.lastQuestInCampaign;
         _window.findChildByName("campaign_pic_bitmap").visible = var_147.lastQuestInCampaign;
         setWindowTitle(var_147.lastQuestInCampaign ? "quests.completed.campaign.title" : "quests.completed.quest.title");
         _questEngine.setupCampaignImage(_window,param1,var_147.lastQuestInCampaign);
         var _loc5_:ITextWindow = ITextWindow(_window.findChildByName("desc_txt"));
         var _loc3_:int = int(_loc5_.height);
         setDesc(var_147.getQuestLocalizationKey() + ".completed");
         _loc5_.height = Math.max(31,_loc5_.textHeight + 5);
         var _loc4_:int = _loc5_.height - _loc3_;
         _window.height += _loc4_;
      }
      
      private function setWindowTitle(param1:String) : void
      {
         _questEngine.localization.registerParameter(param1,"category",_questEngine.getCampaignName(var_147));
         _window.caption = _questEngine.localization.getLocalization(param1,param1);
      }
      
      private function setDesc(param1:String) : void
      {
         _window.findChildByName("desc_txt").caption = _questEngine.localization.getLocalization(param1,param1);
      }
      
      private function onCatalogLink(param1:class_1758, param2:class_1741 = null) : void
      {
         if(param1.type == "WME_CLICK")
         {
            _questEngine.openCatalog(var_147);
         }
      }
      
      public function update(param1:uint) : void
      {
         if(var_1926 > 0)
         {
            var_1926 -= param1;
            if(var_1926 < 1)
            {
               _window.center();
               _window.visible = true;
               _window.activate();
               if(var_147.lastQuestInCampaign)
               {
                  var_1101.restart();
               }
               else
               {
                  var_1101.stop();
               }
            }
         }
         if(var_1101 != null)
         {
            var_1101.update(param1);
         }
      }
   }
}

