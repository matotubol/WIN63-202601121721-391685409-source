package com.sulake.habbo.quest.seasonalcalendar
{
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.components.class_2250;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.quest.HabboQuestEngine;
   import com.sulake.habbo.quest.QuestTracker;
   import com.sulake.habbo.quest.events.QuestCompletedEvent;
   import com.sulake.habbo.quest.events.QuestsListEvent;
   import com.sulake.habbo.utils.WindowToggle;
   import package_62.class_2098;
   
   public class MainWindow implements class_13
   {
      
      private var _questEngine:HabboQuestEngine;
      
      private var _window:class_2250;
      
      private var var_680:WindowToggle;
      
      private var _calendar:Calendar;
      
      private var var_1233:CatalogPromo;
      
      private var var_1684:RareTeaser;
      
      private var var_4903:Boolean = false;
      
      private var var_2318:int;
      
      public function MainWindow(param1:HabboQuestEngine)
      {
         super();
         _questEngine = param1;
         _calendar = new Calendar(_questEngine,this);
         var_1233 = new CatalogPromo(_questEngine,this);
         var_1684 = new RareTeaser(_questEngine);
         _questEngine.events.addEventListener("qe_quests_seasonal",onSeasonalQuests);
         _questEngine.events.addEventListener("qce_seasonal",onSeasonalQuestCompleted);
      }
      
      public function dispose() : void
      {
         if(_questEngine)
         {
            _questEngine.events.removeEventListener("qe_quests_seasonal",onSeasonalQuests);
            _questEngine.events.removeEventListener("qce_seasonal",onSeasonalQuestCompleted);
            _questEngine = null;
         }
         if(_window)
         {
            _window.dispose();
            _window = null;
         }
         if(var_680)
         {
            var_680.dispose();
            var_680 = null;
         }
         if(_calendar)
         {
            _calendar.close();
            _calendar.dispose();
            _calendar = null;
         }
         if(var_1233)
         {
            var_1233.dispose();
            var_1233 = null;
         }
         if(var_1684)
         {
            var_1684.dispose();
            var_1684 = null;
         }
      }
      
      public function get disposed() : Boolean
      {
         return _questEngine == null;
      }
      
      public function isVisible() : Boolean
      {
         return _window && _window.visible;
      }
      
      public function close() : void
      {
         if(_calendar)
         {
            _calendar.close();
         }
         if(_window)
         {
            _window.visible = false;
         }
      }
      
      public function onRoomExit() : void
      {
         this.close();
      }
      
      public function onToolbarClick() : void
      {
         if(!_window)
         {
            _questEngine.requestSeasonalQuests();
            return;
         }
         if(!var_680 || var_680.disposed)
         {
            var_680 = new WindowToggle(_window,_window.desktop,_questEngine.requestSeasonalQuests,close);
         }
         var_680.toggle();
      }
      
      public function getCalendarImageGalleryHost() : String
      {
         var _loc1_:String = _questEngine.getSeasonalCampaignCodePrefix();
         return _questEngine.configuration.getProperty("image.library.url") + _loc1_ + "_quest_calendar/";
      }
      
      public function onQuests(param1:Array, param2:Boolean) : void
      {
         if(!this.isVisible() && !param2)
         {
            return;
         }
         var_2318 = resolveCurrentDay(param1);
         _calendar.onQuests(param1);
         refresh();
         if(param2)
         {
            this._window.visible = true;
            this._window.activate();
         }
      }
      
      private function onSeasonalQuests(param1:QuestsListEvent) : void
      {
         this.onQuests(param1.quests,true);
      }
      
      private function onSeasonalQuestCompleted(param1:QuestCompletedEvent) : void
      {
         var _loc2_:QuestTracker = _questEngine.questController.getTracker(param1.questData.campaignChainCode);
         if(_loc2_ != null)
         {
            _loc2_.forceWindowCloseAfterAnimationsFinished();
         }
         _questEngine.requestSeasonalQuests();
      }
      
      public function onActivityPoints(param1:int, param2:int) : void
      {
         var_1233.onActivityPoints(param1,param2);
      }
      
      private function resolveCurrentDay(param1:Array) : int
      {
         for each(var _loc3_ in param1)
         {
            if(_questEngine.isSeasonalQuest(_loc3_))
            {
               var _loc2_:int = Math.max(0,_loc3_.sortOrder);
            }
         }
         return 0;
      }
      
      private function refresh() : void
      {
         prepareWindow();
         _calendar.refresh();
         var_1233.refresh();
         var_1684.refresh();
      }
      
      private function prepareWindow() : void
      {
         if(this._window != null)
         {
            return;
         }
         _window = class_2250(_questEngine.getXmlWindow("SeasonalCalendar"));
         var _loc1_:String = "quests." + _questEngine.getSeasonalCampaignCodePrefix() + ".title";
         _window.caption = _questEngine.localization.getLocalizationWithParams(_loc1_,_loc1_);
         _window.findChildByTag("close").procedure = onWindowClose;
         _calendar.prepare(_window);
         var_1233.prepare(_window);
         var_1684.prepare(_window);
         _window.center();
      }
      
      private function onWindowClose(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type == "WME_CLICK")
         {
            close();
         }
      }
      
      public function get currentDay() : int
      {
         return var_2318;
      }
      
      public function get catalogPromo() : CatalogPromo
      {
         return var_1233;
      }
      
      public function update(param1:uint) : void
      {
         if(_questEngine.configuration != null && _questEngine.isFirstLoginOfDay && !var_4903 && _questEngine.isSeasonalCalendarEnabled())
         {
            _questEngine.requestSeasonalQuests();
            var_4903 = true;
         }
      }
   }
}

