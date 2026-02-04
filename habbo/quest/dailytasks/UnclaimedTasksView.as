package com.sulake.habbo.quest.dailytasks
{
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IScrollableListWindow;
   import com.sulake.core.window.components.class_2052;
   import com.sulake.core.window.components.class_2250;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.quest.dailytasks.tasks.DailyTaskView;
   import com.sulake.habbo.window.class_38;
   import package_139.class_3417;
   
   public class UnclaimedTasksView implements class_13
   {
      
      private var _disposed:Boolean = false;
      
      private var _windowManager:class_38;
      
      private var var_55:DailyTasksController;
      
      private var _window:class_2250;
      
      private var var_811:Vector.<DailyTaskView>;
      
      public function UnclaimedTasksView(param1:DailyTasksController, param2:class_38)
      {
         super();
         var_55 = param1;
         _windowManager = param2;
         _window = _windowManager.buildFromXML(XML(param1.assets.getAssetByName("dailytasks_unclaimed_xml").content)) as class_2250;
         var_811 = new Vector.<DailyTaskView>();
         closeButton.addEventListener("WME_CLICK",onWindowClose);
         show();
         hide();
         tasksList.autoHideScrollBar = false;
      }
      
      public function tasksCleared() : void
      {
         tasksList.removeListItems();
         for each(var _loc1_ in var_811)
         {
            _loc1_.dispose();
         }
         var_811 = new Vector.<DailyTaskView>();
      }
      
      public function taskAdded(param1:class_3417) : void
      {
         var _loc2_:DailyTaskView = new DailyTaskView(param1,var_55);
         var_811.push(_loc2_);
         tasksList.addListItem(_loc2_.window);
      }
      
      public function taskUpdated(param1:int) : void
      {
         var _loc2_:DailyTaskView = getTaskViewById(param1);
         if(_loc2_ == null)
         {
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
      
      public function show() : void
      {
         var _loc1_:class_2052 = null;
         _window.x = Math.max(_window.x,0);
         _window.y = Math.max(_window.y,0);
         if(_windowManager != null && _window != null && _window.parent == null)
         {
            _loc1_ = _windowManager.getDesktop(1);
            if(_loc1_ != null)
            {
               _loc1_.addChild(_window);
            }
         }
         _window.activate();
      }
      
      public function hide() : void
      {
         var _loc1_:class_2052 = null;
         if(_windowManager != null && _window != null && _window.parent != null)
         {
            _loc1_ = _windowManager.getDesktop(1);
            if(_loc1_ != null)
            {
               _loc1_.removeChild(_window);
            }
         }
      }
      
      private function onWindowClose(param1:class_1758) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         hide();
      }
      
      public function get taskViews() : Vector.<DailyTaskView>
      {
         return var_811;
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         for each(var _loc1_ in var_811)
         {
            _loc1_.dispose();
         }
         var_811 = null;
         hide();
         closeButton.removeEventListener("WME_CLICK",onWindowClose);
         _window.dispose();
         _window = null;
         _windowManager = null;
         var_55 = null;
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      private function get closeButton() : class_1741
      {
         return _window.findChildByName("header_button_close");
      }
      
      private function get tasksList() : IScrollableListWindow
      {
         return _window.findChildByName("tasks_list") as IScrollableListWindow;
      }
      
      private function get mainContainer() : IItemListWindow
      {
         return _window.findChildByName("main_cont") as IItemListWindow;
      }
   }
}

