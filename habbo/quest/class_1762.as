package com.sulake.habbo.quest
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.window.utils.class_1750;
   import com.sulake.habbo.catalog.purse.class_2085;
   import com.sulake.habbo.communication.class_57;
   import com.sulake.habbo.communication.messages.parser.quest.class_2590;
   import com.sulake.habbo.communication.messages.parser.quest.class_2669;
   import com.sulake.habbo.communication.messages.parser.quest.class_3086;
   import com.sulake.habbo.communication.messages.parser.quest.class_3444;
   import com.sulake.habbo.communication.messages.parser.quest.class_3566;
   import com.sulake.habbo.quest.events.QuestCompletedEvent;
   import com.sulake.habbo.quest.events.QuestsListEvent;
   import flash.utils.Dictionary;
   import package_130.class_2829;
   import package_130.class_3358;
   import package_130.class_3514;
   import package_140.class_2687;
   import package_140.class_3081;
   import package_163.class_2796;
   import package_163.class_3305;
   import package_163.class_3661;
   import package_183.class_3147;
   import package_183.class_3152;
   import package_183.class_3401;
   import package_186.class_3340;
   import package_186.class_3511;
   import package_186.class_3635;
   import package_26.class_1799;
   import package_26.class_1861;
   import package_26.class_1961;
   import package_3.class_2238;
   import package_32.class_2887;
   import package_39.class_1980;
   import package_39.class_2407;
   import package_39.class_2600;
   import package_39.class_3192;
   import package_4.class_2803;
   import package_44.class_2355;
   import package_46.class_1918;
   import package_54.class_2039;
   import package_62.class_2611;
   import package_62.class_3375;
   import package_62.class_3476;
   import package_62.class_3496;
   import package_62.class_3517;
   import package_71.class_2196;
   
   [SecureSWF(rename="true")]
   public class class_1762 implements class_13
   {
      
      private var _questEngine:HabboQuestEngine;
      
      private var var_3694:class_1750;
      
      private var var_1134:Boolean = false;
      
      public function class_1762(param1:HabboQuestEngine)
      {
         super();
         _questEngine = param1;
         var _loc2_:class_57 = _questEngine.communication;
         _loc2_.addHabboConnectionMessageEvent(new class_3375(onQuests));
         _loc2_.addHabboConnectionMessageEvent(new class_2887(onRoomSettingsSaved));
         _loc2_.addHabboConnectionMessageEvent(new class_2687(onCompetitionVotingInfo));
         _loc2_.addHabboConnectionMessageEvent(new class_1861(onActivityPoints));
         _loc2_.addHabboConnectionMessageEvent(new class_3192(onFurnisChanged));
         _loc2_.addHabboConnectionMessageEvent(new class_3517(onQuestCompleted));
         _loc2_.addHabboConnectionMessageEvent(new class_3358(onAchievementResolutions));
         _loc2_.addHabboConnectionMessageEvent(new class_1799(onLevelUp));
         _loc2_.addHabboConnectionMessageEvent(new class_2407(onFurnisChanged));
         _loc2_.addHabboConnectionMessageEvent(new class_1961(onActivityPointsNotification));
         _loc2_.addHabboConnectionMessageEvent(new class_2829(onAchievementResolutionProgress));
         _loc2_.addHabboConnectionMessageEvent(new class_1980(onRoomEnter));
         _loc2_.addHabboConnectionMessageEvent(new class_2600(onFurnisChanged));
         _loc2_.addHabboConnectionMessageEvent(new class_2611(onSeasonalQuests));
         _loc2_.addHabboConnectionMessageEvent(new class_2796(onAchievements));
         _loc2_.addHabboConnectionMessageEvent(new class_3305(onAchievement));
         _loc2_.addHabboConnectionMessageEvent(new class_2238(onSubscriptionUserInfoEvent));
         _loc2_.addHabboConnectionMessageEvent(new class_3081(onCompetitionEntrySubmitResult));
         _loc2_.addHabboConnectionMessageEvent(new class_3514(onAchievementResolutionCompleted));
         _loc2_.addHabboConnectionMessageEvent(new class_3476(onQuest));
         _loc2_.addHabboConnectionMessageEvent(new class_3496(onQuestCancelled));
         _loc2_.addHabboConnectionMessageEvent(new class_3661(onAchievementsScore));
         _loc2_.addHabboConnectionMessageEvent(new class_2039(onRoomExit));
         _loc2_.addHabboConnectionMessageEvent(new class_2803(onIsFirstLoginOfDay));
      }
      
      public function get disposed() : Boolean
      {
         return var_1134;
      }
      
      private function onQuestCompleted(param1:IMessageEvent) : void
      {
         var _loc2_:class_3086 = (param1 as class_3517).getParser();
         class_21.log("Quest Completed: " + _loc2_.questData.campaignCode + " quest: " + _loc2_.questData.id);
         _questEngine.questController.onQuestCompleted(_loc2_.questData,_loc2_.showDialog);
         if(_questEngine.isSeasonalQuest(_loc2_.questData))
         {
            _questEngine.events.dispatchEvent(new QuestCompletedEvent("qce_seasonal",_loc2_.questData));
         }
      }
      
      private function onQuestCancelled(param1:IMessageEvent) : void
      {
         var _loc2_:class_3444 = class_3496(param1).getParser();
         class_21.log("Quest Cancelled: " + _loc2_.quest.id);
         _questEngine.questController.onQuestCancelled(_loc2_.quest.campaignChainCode);
         if(_loc2_.expired)
         {
            _questEngine.windowManager.alert("${quests.expired.title}","${quests.expired.body}",0,null);
         }
      }
      
      private function onQuests(param1:IMessageEvent) : void
      {
         var _loc2_:class_2669 = (param1 as class_3375).getParser();
         class_21.log("Got Quests: " + _loc2_.quests + ", " + _loc2_.openWindow);
         _questEngine.events.dispatchEvent(new QuestsListEvent("qu_quests",_loc2_.quests,_loc2_.openWindow));
      }
      
      private function onSeasonalQuests(param1:IMessageEvent) : void
      {
         var _loc2_:class_3566 = (param1 as class_2611).getParser();
         class_21.log("Got seasonal Quests: " + _loc2_.quests);
         _questEngine.events.dispatchEvent(new QuestsListEvent("qe_quests_seasonal",_loc2_.quests,true));
      }
      
      private function onQuest(param1:IMessageEvent) : void
      {
         var _loc2_:class_2590 = (param1 as class_3476).getParser();
         class_21.log("Got Quest: " + _loc2_.quest);
         _questEngine.questController.onQuest(_loc2_.quest);
      }
      
      public function dispose() : void
      {
         if(var_3694)
         {
            var_3694.dispose();
            var_3694 = null;
         }
         var_1134 = true;
      }
      
      private function onRoomEnter(param1:class_1980) : void
      {
         _questEngine.roomCompetitionController.onRoomEnter(param1);
         _questEngine.currentlyInRoom = true;
      }
      
      private function onRoomExit(param1:IMessageEvent) : void
      {
         _questEngine.questController.onRoomExit();
         _questEngine.achievementController.onRoomExit();
         _questEngine.roomCompetitionController.onRoomExit();
         _questEngine.currentlyInRoom = false;
      }
      
      private function onFurnisChanged(param1:IMessageEvent) : void
      {
         _questEngine.roomCompetitionController.onContextChanged();
      }
      
      private function onRoomSettingsSaved(param1:IMessageEvent) : void
      {
         _questEngine.roomCompetitionController.onContextChanged();
      }
      
      private function onAchievements(param1:IMessageEvent) : void
      {
         var _loc2_:class_2796 = param1 as class_2796;
         var _loc3_:class_3401 = _loc2_.getParser() as class_3401;
         _questEngine.achievementController.onAchievements(_loc3_.achievements,_loc3_.defaultCategory);
      }
      
      private function onAchievementResolutions(param1:class_3358) : void
      {
         var _loc2_:class_3340 = param1.getParser();
         _questEngine.achievementsResolutionController.onResolutionAchievements(_loc2_.stuffId,_loc2_.achievements,_loc2_.endTime);
      }
      
      private function onAchievementResolutionProgress(param1:class_2829) : void
      {
         var _loc2_:class_3635 = param1.getParser();
         _questEngine.achievementsResolutionController.onResolutionProgress(_loc2_.stuffId,_loc2_.achievementId,_loc2_.requiredLevelBadgeCode,_loc2_.userProgress,_loc2_.totalProgress,_loc2_.endTime);
      }
      
      private function onAchievementResolutionCompleted(param1:class_3514) : void
      {
         var _loc2_:class_3511 = param1.getParser();
         _questEngine.achievementsResolutionController.onResolutionCompleted(_loc2_.badgeCode,_loc2_.stuffCode);
      }
      
      private function onAchievement(param1:IMessageEvent) : void
      {
         var _loc2_:class_3305 = param1 as class_3305;
         var _loc3_:class_3152 = _loc2_.getParser() as class_3152;
         _questEngine.achievementController.onAchievement(_loc3_.achievement);
         _questEngine.achievementsResolutionController.onAchievement(_loc3_.achievement);
      }
      
      private function onAchievementsScore(param1:IMessageEvent) : void
      {
         var _loc2_:class_3661 = param1 as class_3661;
         var _loc3_:class_3147 = _loc2_.getParser() as class_3147;
         _questEngine.localization.registerParameter("achievements.categories.score","score",_loc3_.score.toString());
      }
      
      private function onLevelUp(param1:IMessageEvent) : void
      {
         var _loc2_:class_1799 = param1 as class_1799;
         var _loc3_:class_1918 = _loc2_.getParser();
         var _loc4_:String = _questEngine.localization.getBadgeBaseName(_loc3_.data.badgeCode);
         _questEngine.send(new class_2196("Achievements",_loc4_,"Leveled","",_loc3_.data.level));
         _questEngine.achievementsResolutionController.onLevelUp(_loc3_.data);
      }
      
      private function onIsFirstLoginOfDay(param1:IMessageEvent) : void
      {
         var _loc2_:class_2355 = (param1 as class_2803).getParser();
         _questEngine.setIsFirstLoginOfDay(_loc2_.isFirstLoginOfDay);
      }
      
      private function onCompetitionEntrySubmitResult(param1:class_3081) : void
      {
         _questEngine.roomCompetitionController.onCompetitionEntrySubmitResult(param1);
      }
      
      private function onCompetitionVotingInfo(param1:class_2687) : void
      {
         _questEngine.roomCompetitionController.onCompetitionVotingInfo(param1);
      }
      
      private function onSubscriptionUserInfoEvent(param1:class_2238) : void
      {
         if(param1.getParser().isVIP && param1.getParser().responseType == 2)
         {
            _questEngine.roomCompetitionController.sendRoomCompetitionInit();
         }
      }
      
      private function onActivityPoints(param1:IMessageEvent) : void
      {
         var _loc3_:Dictionary = class_1861(param1).points;
         for each(var _loc4_ in class_2085.values())
         {
            _questEngine.questController.onActivityPoints(_loc4_,0);
         }
         for(var _loc2_ in _loc3_)
         {
            _questEngine.questController.onActivityPoints(int(_loc2_),_loc3_[_loc2_]);
         }
      }
      
      private function onActivityPointsNotification(param1:class_1961) : void
      {
         _questEngine.questController.onActivityPoints(param1.type,param1.amount);
      }
   }
}

