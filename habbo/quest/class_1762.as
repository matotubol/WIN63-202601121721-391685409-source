package com.sulake.habbo.quest
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.window.utils.class_1750;
   import com.sulake.habbo.catalog.purse.class_2085;
   import com.sulake.habbo.communication.class_57;
   import com.sulake.habbo.communication.messages.parser.quest.QuestMessageEventParser;
   import com.sulake.habbo.communication.messages.parser.quest.QuestsMessageEventParser;
   import com.sulake.habbo.communication.messages.parser.quest.QuestCompletedMessageEventParser;
   import com.sulake.habbo.communication.messages.parser.quest.QuestCancelledMessageEventParser;
   import com.sulake.habbo.communication.messages.parser.quest.SeasonalQuestsMessageEventParser;
   import com.sulake.habbo.quest.events.QuestCompletedEvent;
   import com.sulake.habbo.quest.events.QuestsListEvent;
   import flash.utils.Dictionary;
   import com.sulake.habbo.communication.messages.incoming.game.lobby.AchievementResolutionProgressMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.game.lobby.AchievementResolutionsMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.game.lobby.AchievementResolutionCompletedMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.competition.CompetitionVotingInfoMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.competition.CompetitionEntrySubmitResultMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.inventory.achievements.AchievementsEvent;
   import com.sulake.habbo.communication.messages.incoming.inventory.achievements.AchievementEvent;
   import com.sulake.habbo.communication.messages.incoming.inventory.achievements.AchievementsScoreEvent;
   import com.sulake.habbo.communication.messages.parser.inventory.achievements.AchievementsScoreEventParser;
   import com.sulake.habbo.communication.messages.parser.inventory.achievements.AchievementEventParser;
   import com.sulake.habbo.communication.messages.parser.inventory.achievements.AchievementsEventParser;
   import com.sulake.habbo.communication.messages.parser.game.lobby.AchievementResolutionsMessageEventParser;
   import com.sulake.habbo.communication.messages.parser.game.lobby.AchievementResolutionCompletedMessageEventParser;
   import com.sulake.habbo.communication.messages.parser.game.lobby.AchievementResolutionProgressMessageEventParser;
   import com.sulake.habbo.communication.messages.incoming.notifications.HabboAchievementNotificationMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.notifications.ActivityPointsMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.notifications.HabboActivityPointNotificationMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.users.ScrSendUserInfoEvent;
   import com.sulake.habbo.communication.messages.incoming.roomsettings.RoomSettingsSavedEvent;
   import com.sulake.habbo.communication.messages.incoming.room.engine.RoomEntryInfoMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.room.engine.ObjectRemoveMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.room.engine.ObjectAddMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.room.engine.ObjectRemoveMultipleMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.handshake.IsFirstLoginOfDayEvent;
   import com.sulake.habbo.communication.messages.parser.handshake.IsFirstLoginOfDayEventParser;
   import com.sulake.habbo.communication.messages.parser.notifications.HabboAchievementNotificationMessageEventParser;
   import com.sulake.habbo.communication.messages.incoming.room.session.CloseConnectionMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.quest.SeasonalQuestsMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.quest.QuestsMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.quest.QuestMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.quest.QuestCancelledMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.quest.QuestCompletedMessageEvent;
   import com.sulake.habbo.communication.messages.outgoing.tracking.EventLogMessageComposer;
   
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
         _loc2_.addHabboConnectionMessageEvent(new QuestsMessageEvent(onQuests));
         _loc2_.addHabboConnectionMessageEvent(new RoomSettingsSavedEvent(onRoomSettingsSaved));
         _loc2_.addHabboConnectionMessageEvent(new CompetitionVotingInfoMessageEvent(onCompetitionVotingInfo));
         _loc2_.addHabboConnectionMessageEvent(new ActivityPointsMessageEvent(onActivityPoints));
         _loc2_.addHabboConnectionMessageEvent(new ObjectRemoveMultipleMessageEvent(onFurnisChanged));
         _loc2_.addHabboConnectionMessageEvent(new QuestCompletedMessageEvent(onQuestCompleted));
         _loc2_.addHabboConnectionMessageEvent(new AchievementResolutionsMessageEvent(onAchievementResolutions));
         _loc2_.addHabboConnectionMessageEvent(new HabboAchievementNotificationMessageEvent(onLevelUp));
         _loc2_.addHabboConnectionMessageEvent(new ObjectRemoveMessageEvent(onFurnisChanged));
         _loc2_.addHabboConnectionMessageEvent(new HabboActivityPointNotificationMessageEvent(onActivityPointsNotification));
         _loc2_.addHabboConnectionMessageEvent(new AchievementResolutionProgressMessageEvent(onAchievementResolutionProgress));
         _loc2_.addHabboConnectionMessageEvent(new RoomEntryInfoMessageEvent(onRoomEnter));
         _loc2_.addHabboConnectionMessageEvent(new ObjectAddMessageEvent(onFurnisChanged));
         _loc2_.addHabboConnectionMessageEvent(new SeasonalQuestsMessageEvent(onSeasonalQuests));
         _loc2_.addHabboConnectionMessageEvent(new AchievementsEvent(onAchievements));
         _loc2_.addHabboConnectionMessageEvent(new AchievementEvent(onAchievement));
         _loc2_.addHabboConnectionMessageEvent(new ScrSendUserInfoEvent(onSubscriptionUserInfoEvent));
         _loc2_.addHabboConnectionMessageEvent(new CompetitionEntrySubmitResultMessageEvent(onCompetitionEntrySubmitResult));
         _loc2_.addHabboConnectionMessageEvent(new AchievementResolutionCompletedMessageEvent(onAchievementResolutionCompleted));
         _loc2_.addHabboConnectionMessageEvent(new QuestMessageEvent(onQuest));
         _loc2_.addHabboConnectionMessageEvent(new QuestCancelledMessageEvent(onQuestCancelled));
         _loc2_.addHabboConnectionMessageEvent(new AchievementsScoreEvent(onAchievementsScore));
         _loc2_.addHabboConnectionMessageEvent(new CloseConnectionMessageEvent(onRoomExit));
         _loc2_.addHabboConnectionMessageEvent(new IsFirstLoginOfDayEvent(onIsFirstLoginOfDay));
      }
      
      public function get disposed() : Boolean
      {
         return var_1134;
      }
      
      private function onQuestCompleted(param1:IMessageEvent) : void
      {
         var _loc2_:QuestCompletedMessageEventParser = (param1 as QuestCompletedMessageEvent).getParser();
         class_21.log("Quest Completed: " + _loc2_.questData.campaignCode + " quest: " + _loc2_.questData.id);
         _questEngine.questController.onQuestCompleted(_loc2_.questData,_loc2_.showDialog);
         if(_questEngine.isSeasonalQuest(_loc2_.questData))
         {
            _questEngine.events.dispatchEvent(new QuestCompletedEvent("qce_seasonal",_loc2_.questData));
         }
      }
      
      private function onQuestCancelled(param1:IMessageEvent) : void
      {
         var _loc2_:QuestCancelledMessageEventParser = QuestCancelledMessageEvent(param1).getParser();
         class_21.log("Quest Cancelled: " + _loc2_.quest.id);
         _questEngine.questController.onQuestCancelled(_loc2_.quest.campaignChainCode);
         if(_loc2_.expired)
         {
            _questEngine.windowManager.alert("${quests.expired.title}","${quests.expired.body}",0,null);
         }
      }
      
      private function onQuests(param1:IMessageEvent) : void
      {
         var _loc2_:QuestsMessageEventParser = (param1 as QuestsMessageEvent).getParser();
         class_21.log("Got Quests: " + _loc2_.quests + ", " + _loc2_.openWindow);
         _questEngine.events.dispatchEvent(new QuestsListEvent("qu_quests",_loc2_.quests,_loc2_.openWindow));
      }
      
      private function onSeasonalQuests(param1:IMessageEvent) : void
      {
         var _loc2_:SeasonalQuestsMessageEventParser = (param1 as SeasonalQuestsMessageEvent).getParser();
         class_21.log("Got seasonal Quests: " + _loc2_.quests);
         _questEngine.events.dispatchEvent(new QuestsListEvent("qe_quests_seasonal",_loc2_.quests,true));
      }
      
      private function onQuest(param1:IMessageEvent) : void
      {
         var _loc2_:QuestMessageEventParser = (param1 as QuestMessageEvent).getParser();
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
      
      private function onRoomEnter(param1:RoomEntryInfoMessageEvent) : void
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
         var _loc2_:AchievementsEvent = param1 as AchievementsEvent;
         var _loc3_:AchievementsEventParser = _loc2_.getParser() as AchievementsEventParser;
         _questEngine.achievementController.onAchievements(_loc3_.achievements,_loc3_.defaultCategory);
      }
      
      private function onAchievementResolutions(param1:AchievementResolutionsMessageEvent) : void
      {
         var _loc2_:AchievementResolutionsMessageEventParser = param1.getParser();
         _questEngine.achievementsResolutionController.onResolutionAchievements(_loc2_.stuffId,_loc2_.achievements,_loc2_.endTime);
      }
      
      private function onAchievementResolutionProgress(param1:AchievementResolutionProgressMessageEvent) : void
      {
         var _loc2_:AchievementResolutionProgressMessageEventParser = param1.getParser();
         _questEngine.achievementsResolutionController.onResolutionProgress(_loc2_.stuffId,_loc2_.achievementId,_loc2_.requiredLevelBadgeCode,_loc2_.userProgress,_loc2_.totalProgress,_loc2_.endTime);
      }
      
      private function onAchievementResolutionCompleted(param1:AchievementResolutionCompletedMessageEvent) : void
      {
         var _loc2_:AchievementResolutionCompletedMessageEventParser = param1.getParser();
         _questEngine.achievementsResolutionController.onResolutionCompleted(_loc2_.badgeCode,_loc2_.stuffCode);
      }
      
      private function onAchievement(param1:IMessageEvent) : void
      {
         var _loc2_:AchievementEvent = param1 as AchievementEvent;
         var _loc3_:AchievementEventParser = _loc2_.getParser() as AchievementEventParser;
         _questEngine.achievementController.onAchievement(_loc3_.achievement);
         _questEngine.achievementsResolutionController.onAchievement(_loc3_.achievement);
      }
      
      private function onAchievementsScore(param1:IMessageEvent) : void
      {
         var _loc2_:AchievementsScoreEvent = param1 as AchievementsScoreEvent;
         var _loc3_:AchievementsScoreEventParser = _loc2_.getParser() as AchievementsScoreEventParser;
         _questEngine.localization.registerParameter("achievements.categories.score","score",_loc3_.score.toString());
      }
      
      private function onLevelUp(param1:IMessageEvent) : void
      {
         var _loc2_:HabboAchievementNotificationMessageEvent = param1 as HabboAchievementNotificationMessageEvent;
         var _loc3_:HabboAchievementNotificationMessageEventParser = _loc2_.getParser();
         var _loc4_:String = _questEngine.localization.getBadgeBaseName(_loc3_.data.badgeCode);
         _questEngine.send(new EventLogMessageComposer("Achievements",_loc4_,"Leveled","",_loc3_.data.level));
         _questEngine.achievementsResolutionController.onLevelUp(_loc3_.data);
      }
      
      private function onIsFirstLoginOfDay(param1:IMessageEvent) : void
      {
         var _loc2_:IsFirstLoginOfDayEventParser = (param1 as IsFirstLoginOfDayEvent).getParser();
         _questEngine.setIsFirstLoginOfDay(_loc2_.isFirstLoginOfDay);
      }
      
      private function onCompetitionEntrySubmitResult(param1:CompetitionEntrySubmitResultMessageEvent) : void
      {
         _questEngine.roomCompetitionController.onCompetitionEntrySubmitResult(param1);
      }
      
      private function onCompetitionVotingInfo(param1:CompetitionVotingInfoMessageEvent) : void
      {
         _questEngine.roomCompetitionController.onCompetitionVotingInfo(param1);
      }
      
      private function onSubscriptionUserInfoEvent(param1:ScrSendUserInfoEvent) : void
      {
         if(param1.getParser().isVIP && param1.getParser().responseType == 2)
         {
            _questEngine.roomCompetitionController.sendRoomCompetitionInit();
         }
      }
      
      private function onActivityPoints(param1:IMessageEvent) : void
      {
         var _loc3_:Dictionary = ActivityPointsMessageEvent(param1).points;
         for each(var _loc4_ in class_2085.values())
         {
            _questEngine.questController.onActivityPoints(_loc4_,0);
         }
         for(var _loc2_ in _loc3_)
         {
            _questEngine.questController.onActivityPoints(int(_loc2_),_loc3_[_loc2_]);
         }
      }
      
      private function onActivityPointsNotification(param1:HabboActivityPointNotificationMessageEvent) : void
      {
         _questEngine.questController.onActivityPoints(param1.type,param1.amount);
      }
   }
}

