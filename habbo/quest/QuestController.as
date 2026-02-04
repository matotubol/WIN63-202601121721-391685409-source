package com.sulake.habbo.quest
{
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.runtime.class_31;
   import com.sulake.core.utils.class_55;
   import com.sulake.habbo.quest.seasonalcalendar.MainWindow;
   import package_62.class_2098;
   
   public class QuestController implements class_13, class_31
   {
      
      private var _questEngine:HabboQuestEngine;
      
      private var var_918:QuestsList;
      
      private var _questDetails:QuestDetails;
      
      private var var_1143:QuestCompleted;
      
      private var var_1098:NextQuestTimer;
      
      private var var_797:MainWindow;
      
      private var _questTrackers:class_55;
      
      public function QuestController(param1:HabboQuestEngine)
      {
         super();
         _questEngine = param1;
         _questTrackers = new class_55();
         var_918 = new QuestsList(_questEngine);
         _questDetails = new QuestDetails(_questEngine);
         var_1143 = new QuestCompleted(_questEngine);
         var_1098 = new NextQuestTimer(_questEngine);
         var_797 = new MainWindow(_questEngine);
      }
      
      public function onToolbarClick() : void
      {
         if(_questEngine.isSeasonalCalendarEnabled())
         {
            var_797.onToolbarClick();
            var_918.close();
         }
         else
         {
            var_918.onToolbarClick();
         }
      }
      
      private function getOrCreateTracker(param1:String, param2:Boolean = true) : QuestTracker
      {
         var _loc3_:QuestTracker = _questTrackers.getValue(param1);
         if(_loc3_ == null && param2)
         {
            _loc3_ = new QuestTracker(_questEngine);
            _questTrackers.add(param1,_loc3_);
         }
         return _loc3_;
      }
      
      public function getTracker(param1:String) : QuestTracker
      {
         return getOrCreateTracker(param1,false);
      }
      
      private function cleanTrackers(param1:Boolean) : void
      {
         var _loc3_:QuestTracker = null;
         var _loc4_:Array = [];
         for each(var _loc2_ in _questTrackers.getKeys())
         {
            _loc3_ = _questTrackers.getValue(_loc2_);
            if(_loc3_.canBeDisposed || param1)
            {
               _loc3_.dispose();
               _loc4_.push(_loc2_);
            }
         }
         for each(_loc2_ in _loc4_)
         {
            _questTrackers.remove(_loc2_);
         }
      }
      
      public function onQuest(param1:class_2098) : void
      {
         var _loc2_:QuestTracker = getOrCreateTracker(param1.campaignChainCode);
         _loc2_.onQuest(param1);
         if(_loc2_.campaignChainCode == null)
         {
            _questTrackers.remove(param1.campaignChainCode);
         }
         _questDetails.onQuest(param1);
         var_1143.onQuest(param1);
         var_1098.onQuest(param1);
      }
      
      public function onQuestCompleted(param1:class_2098, param2:Boolean) : void
      {
         var _loc3_:QuestTracker = getOrCreateTracker(param1.campaignChainCode);
         _loc3_.onQuestCompleted(param1,param2);
         _questDetails.onQuestCompleted(param1);
         var_1143.onQuestCompleted(param1,param2);
      }
      
      public function onQuestCancelled(param1:String) : void
      {
         var _loc2_:QuestTracker = getOrCreateTracker(param1,false);
         if(_loc2_ != null)
         {
            _loc2_.onQuestCancelled();
         }
         _questDetails.onQuestCancelled(param1);
         var_1143.onQuestCancelled();
         var_1098.onQuestCancelled();
      }
      
      public function onRoomEnter() : void
      {
         var _loc1_:String = getDefaultCampaign();
         if(_loc1_ == null || _loc1_ == "")
         {
            return;
         }
         getOrCreateTracker(_loc1_).startDefaultCampaign(_loc1_);
      }
      
      public function onRoomExit() : void
      {
         var_918.onRoomExit();
         var_797.onRoomExit();
         for each(var _loc1_ in _questTrackers.getValues())
         {
            _loc1_.onRoomExit();
         }
         _questDetails.onRoomExit();
         var_1098.onRoomExit();
      }
      
      public function update(param1:uint) : void
      {
         var_1143.update(param1);
         for each(var _loc2_ in _questTrackers.getValues())
         {
            _loc2_.update(param1);
         }
         var_1098.update(param1);
         var_918.update(param1);
         _questDetails.update(param1);
         var_797.update(param1);
         cleanTrackers(false);
      }
      
      public function dispose() : void
      {
         _questEngine = null;
         if(var_918)
         {
            var_918.dispose();
            var_918 = null;
         }
         if(_questTrackers)
         {
            cleanTrackers(true);
            _questTrackers.dispose();
            _questTrackers = null;
         }
         if(_questDetails)
         {
            _questDetails.dispose();
            _questDetails = null;
         }
         if(var_1143)
         {
            var_1143.dispose();
            var_1143 = null;
         }
         if(var_1098)
         {
            var_1098.dispose();
            var_1098 = null;
         }
         if(var_797)
         {
            var_797.dispose();
            var_797 = null;
         }
      }
      
      public function get disposed() : Boolean
      {
         return _questEngine == null;
      }
      
      public function get questsList() : QuestsList
      {
         return var_918;
      }
      
      public function get questDetails() : QuestDetails
      {
         return _questDetails;
      }
      
      public function get seasonalCalendarWindow() : MainWindow
      {
         return var_797;
      }
      
      public function onActivityPoints(param1:int, param2:int) : void
      {
         if(var_797)
         {
            var_797.onActivityPoints(param1,param2);
         }
      }
      
      public function getDefaultCampaign() : String
      {
         var _loc1_:String = _questEngine.getProperty("questing.defaultCampaign");
         return _loc1_ == null ? "" : _loc1_;
      }
   }
}

