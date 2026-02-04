package com.sulake.habbo.quest.dailytasks
{
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.runtime.class_31;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IScrollableListWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_1775;
   import com.sulake.core.window.components.class_1993;
   import com.sulake.core.window.components.class_2052;
   import com.sulake.core.window.components.class_2250;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.catalog.IHabboCatalog;
   import com.sulake.habbo.quest.dailytasks.tasks.DailyTaskView;
   import com.sulake.habbo.utils.FriendlyTime;
   import com.sulake.habbo.window.class_38;
   import flash.utils.getTimer;
   import package_139.class_3417;
   
   public class DailyTasksView implements class_13, class_31
   {
      
      public static const const_275:int = 500;
      
      public static const DESKTOP_WINDOW_LAYER:uint = 1;
      
      private var _windowManager:class_38;
      
      private var var_55:DailyTasksController;
      
      private var _window:class_2250;
      
      private var var_2202:class_1993;
      
      private var var_2429:class_1812;
      
      private var var_811:Vector.<DailyTaskView>;
      
      private var _lastTitleUpdateTime:int = 0;
      
      private var var_1058:UnclaimedTasksView;
      
      private var var_1134:Boolean = false;
      
      public function DailyTasksView(param1:DailyTasksController, param2:class_38)
      {
         super();
         var_55 = param1;
         _windowManager = param2;
         var_811 = new Vector.<DailyTaskView>();
         _window = param2.buildFromXML(XML(var_55.assets.getAssetByName("daily_tasks_xml").content),1) as class_2250;
         closeButton.addEventListener("WME_CLICK",onWindowClose);
         unclaimedButton.addEventListener("WME_CLICK",onUnclaimedTasksOpen);
         getHCButton.addEventListener("WME_CLICK",onGetHcClicked);
         var_2202 = tasksList.removeListItemAt(0) as class_1993;
         var_2429 = (var_2202.findChildByName("rewards_list") as IItemListWindow).removeListItemAt(0) as class_1812;
         var_1058 = new UnclaimedTasksView(var_55,param2);
      }
      
      public function initialize() : void
      {
         for each(var _loc1_ in var_55.tasks)
         {
            taskAdded(_loc1_);
         }
         taskAmountChanged();
      }
      
      public function show() : void
      {
         var _loc1_:class_2052 = null;
         if(_windowManager != null && _window != null && _window.parent == null)
         {
            _loc1_ = _windowManager.getDesktop(1);
            if(_loc1_ != null)
            {
               _loc1_.addChild(_window);
            }
         }
      }
      
      public function isShowing() : Boolean
      {
         return _windowManager != null && _window != null && _window.parent != null;
      }
      
      private function onWindowClose(param1:class_1758) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         hide();
      }
      
      private function onUnclaimedTasksOpen(param1:WindowMouseEvent) : void
      {
         var_1058.show();
      }
      
      private function onGetHcClicked(param1:WindowMouseEvent) : void
      {
         var _loc2_:IHabboCatalog = var_55.questEngine.catalog;
         if(_loc2_)
         {
            _loc2_.openCatalogPage("hc_membership","NORMAL");
         }
      }
      
      public function hide() : void
      {
         var _loc1_:class_2052 = null;
         if(isShowing())
         {
            _loc1_ = _windowManager.getDesktop(1);
            if(_loc1_ != null)
            {
               _loc1_.removeChild(_window);
            }
         }
      }
      
      public function taskAmountChanged() : void
      {
         var _loc1_:* = var_1058.taskViews.length > 0;
         extraCont.visible = _loc1_;
         var _loc2_:int = _loc1_ ? extraCont.height + mainContainer.spacing : 0;
         tasksList.y = _loc2_;
         tasksList.height = Math.min(Math.max(var_811.length,1),4) * (taskTemplate.height + tasksList.spacing) - tasksList.spacing;
         hcInfoBar.y = _loc2_ + tasksList.height + mainContainer.spacing;
         _window.height = 33 + _loc2_ + tasksList.height + mainContainer.spacing + hcInfoBar.height + mainContainer.spacing;
         _window.width = tasksList.isScrollBarVisible ? _window.limits.maxWidth : int(_window.limits.minWidth);
         extraCont.width = _window.width;
         hcInfoBar.width = _window.width;
         setHcDoubleDuckets();
      }
      
      private function setHcDoubleDuckets() : void
      {
         var _loc1_:Boolean = var_55.questEngine.sessionDataManager.hasClub;
         if(_loc1_)
         {
            hcDoubleDucketsInfoText.text = var_55.localizationManager.getLocalization("hc.has.double_duckets.info","You get double duckets as you are an HC member!");
         }
         else
         {
            hcDoubleDucketsInfoText.text = var_55.localizationManager.getLocalization("hc.get.double_duckets.info","Get HC membership to gain double duckets!");
         }
         getHCButton.visible = !_loc1_;
      }
      
      public function tasksCleared() : void
      {
         tasksList.removeListItems();
         for each(var _loc1_ in var_811)
         {
            _loc1_.dispose();
         }
         var_811 = new Vector.<DailyTaskView>();
         var_1058.tasksCleared();
      }
      
      public function taskAdded(param1:class_3417) : void
      {
         if(param1.isExpired)
         {
            var_1058.taskAdded(param1);
            return;
         }
         var _loc2_:DailyTaskView = new DailyTaskView(param1,var_55);
         var_811.push(_loc2_);
         tasksList.addListItem(_loc2_.window);
      }
      
      public function taskUpdated(param1:int) : void
      {
         var _loc2_:DailyTaskView = getTaskViewById(param1);
         if(_loc2_ == null)
         {
            var_1058.taskUpdated(param1);
            return;
         }
         _loc2_.updateStatusAndRepeatsUI();
      }
      
      public function getTaskViewById(param1:int) : DailyTaskView
      {
         for each(var _loc2_ in var_811)
         {
            if(_loc2_.dailyTask.taskId == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function update(param1:uint) : void
      {
         for each(var _loc3_ in var_811)
         {
            _loc3_.update(param1);
         }
         var _loc5_:int = 0;
         for each(var _loc2_ in var_55.tasks)
         {
            if(_loc2_.secondsLeft > _loc5_)
            {
               _loc5_ = _loc2_.secondsLeft;
            }
         }
         var _loc4_:* = getTimer() > _lastTitleUpdateTime + 500;
         if(isShowing() && _loc4_)
         {
            if(_loc5_ > 0)
            {
               _window.caption = var_55.localizationManager.getLocalization("dailytasks.title") + " - " + var_55.localizationManager.getLocalizationWithParams("dailytasks.refreshes","Refresh in %time","time",FriendlyTime.getFriendlyTime(var_55.localizationManager,_loc5_));
            }
            else
            {
               _window.caption = var_55.localizationManager.getLocalization("dailytasks.title");
            }
            _lastTitleUpdateTime = getTimer();
         }
         if(var_55.tasks.length == 0 || _loc5_ < -5)
         {
            var_55.requestTasks();
         }
      }
      
      public function dispose() : void
      {
         if(var_1134)
         {
            return;
         }
         var_1058.dispose();
         var_1058 = null;
         for each(var _loc1_ in var_811)
         {
            _loc1_.dispose();
         }
         var_811 = null;
         var_2202 = null;
         var_2429 = null;
         hide();
         closeButton.removeEventListener("WME_CLICK",onWindowClose);
         unclaimedButton.removeEventListener("WME_CLICK",onUnclaimedTasksOpen);
         getHCButton.removeEventListener("WME_CLICK",onGetHcClicked);
         _window.dispose();
         _window = null;
         var_1134 = true;
      }
      
      public function get disposed() : Boolean
      {
         return var_1134;
      }
      
      public function get taskTemplate() : class_1993
      {
         return var_2202;
      }
      
      public function get rewardTemplate() : class_1812
      {
         return var_2429;
      }
      
      private function get closeButton() : class_1741
      {
         return _window.findChildByName("header_button_close");
      }
      
      private function get unclaimedButton() : class_1775
      {
         return _window.findChildByName("unclaimed_btn") as class_1775;
      }
      
      private function get tasksList() : IScrollableListWindow
      {
         return _window.findChildByName("tasks_list") as IScrollableListWindow;
      }
      
      private function get mainContainer() : IItemListWindow
      {
         return _window.findChildByName("main_cont") as IItemListWindow;
      }
      
      private function get extraCont() : class_1812
      {
         return _window.findChildByName("extra_cont") as class_1812;
      }
      
      private function get hcInfoBar() : class_1812
      {
         return _window.findChildByName("hc_info_cont") as class_1812;
      }
      
      private function get hcDoubleDucketsInfoText() : ITextWindow
      {
         return _window.findChildByName("hc_info_text") as ITextWindow;
      }
      
      private function get getHCButton() : class_1775
      {
         return _window.findChildByName("get_hc_btn") as class_1775;
      }
   }
}

