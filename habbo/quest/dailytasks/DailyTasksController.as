package com.sulake.habbo.quest.dailytasks
{
   import com.sulake.core.assets.class_40;
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.runtime.ComponentDependency;
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.runtime.class_15;
   import com.sulake.core.runtime.class_17;
   import com.sulake.core.runtime.class_31;
   import com.sulake.core.runtime.events.ILinkEventTracker;
   import com.sulake.habbo.communication.class_57;
   import com.sulake.habbo.localization.class_27;
   import com.sulake.habbo.quest.HabboQuestEngine;
   import com.sulake.habbo.quest.events.UnseenDailyTasksCountUpdateEvent;
   import com.sulake.habbo.window.class_38;
   import com.sulake.iid.IIDHabboCommunicationManager;
   import com.sulake.iid.IIDHabboLocalizationManager;
   import com.sulake.iid.IIDHabboWindowManager;
   import flash.utils.getTimer;
   import package_139.DailyTasksActiveListMessageEventParser;
   import package_139.DailyTasksTaskUpdateMessageEventParser;
   import package_139.DailyTasksTasksAddedMessageEventParser;
   import package_139.class_3417;
   import package_171.DailyTasksTasksAddedMessageEvent;
   import package_171.DailyTasksActiveListMessageEvent;
   import package_171.DailyTasksTaskUpdateMessageEvent;
   import package_78.GetDailyTasksComposer;
   import package_78.ClaimDailyTaskComposer;
   
   public class DailyTasksController extends class_17 implements ILinkEventTracker, class_2179, class_13, class_31
   {
      
      public static const REQUEST_TASKS_TIMEOUT_MS:int = 10000;
      
      private var _communicationManager:class_57;
      
      private var _localizationManager:class_27;
      
      private var _windowManager:class_38;
      
      private var _questEngine:HabboQuestEngine;
      
      private var var_18:DailyTasksView;
      
      private var _messageEvents:Vector.<IMessageEvent>;
      
      private var var_1705:Vector.<class_3417>;
      
      private var var_5341:Vector.<class_3417>;
      
      private var _lastRequestTime:int = 0;
      
      private var var_1134:Boolean = false;
      
      public function DailyTasksController(param1:HabboQuestEngine, param2:class_15, param3:uint = 0, param4:class_40 = null)
      {
         super(param2,param3,param4);
         _questEngine = param1;
         var_1705 = new Vector.<class_3417>();
         _messageEvents = new Vector.<IMessageEvent>();
         _messageEvents.push(new DailyTasksActiveListMessageEvent(onActiveDailyTasks));
         _messageEvents.push(new DailyTasksTasksAddedMessageEvent(onTasksAdded));
         _messageEvents.push(new DailyTasksTaskUpdateMessageEvent(onTaskUpdated));
         for each(var _loc5_ in _messageEvents)
         {
            addMessageEvent(_loc5_);
         }
      }
      
      override protected function get dependencies() : Vector.<ComponentDependency>
      {
         return super.dependencies.concat(new <ComponentDependency>[new ComponentDependency(new IIDHabboCommunicationManager(),function(param1:class_57):void
         {
            _communicationManager = param1;
         },true),new ComponentDependency(new IIDHabboWindowManager(),function(param1:class_38):void
         {
            _windowManager = param1;
         }),new ComponentDependency(new IIDHabboLocalizationManager(),function(param1:class_27):void
         {
            _localizationManager = param1;
         })]);
      }
      
      override protected function initComponent() : void
      {
         context.addLinkEventTracker(this);
      }
      
      public function get linkPattern() : String
      {
         return "dailytasks/";
      }
      
      public function linkReceived(param1:String) : void
      {
         if(!isEnabled)
         {
            return;
         }
         var _loc2_:Array = param1.split("/");
         if(_loc2_.length < 2)
         {
            return;
         }
         if(_loc2_[1] == "open")
         {
            showView();
         }
      }
      
      public function toggleView() : void
      {
         if(isShowing())
         {
            hideView();
         }
         else
         {
            showView();
         }
      }
      
      private function showView() : void
      {
         if(!isEnabled)
         {
            return;
         }
         if(!viewExists())
         {
            var_18 = new DailyTasksView(this,_windowManager);
            var_18.initialize();
         }
         var_18.show();
      }
      
      private function hideView() : void
      {
         if(!viewExists())
         {
            return;
         }
         var_18.hide();
      }
      
      private function isShowing() : Boolean
      {
         return viewExists() && var_18.isShowing();
      }
      
      private function viewExists() : Boolean
      {
         return var_18 != null && !var_18.disposed;
      }
      
      public function get isEnabled() : Boolean
      {
         return getBoolean("dailytasks.enabled");
      }
      
      private function clearTasks() : void
      {
         var_1705 = new Vector.<class_3417>();
         if(viewExists())
         {
            var_18.tasksCleared();
         }
      }
      
      private function addTask(param1:class_3417) : void
      {
         if(getTaskById(param1.taskId) != null)
         {
            return;
         }
         if(param1.secondsLeft < 0 && param1.status == class_3417.var_3480)
         {
            var_5341.push(param1);
         }
         var_1705.push(param1);
         if(viewExists())
         {
            var_18.taskAdded(param1);
         }
      }
      
      private function updateUnseenTasks() : void
      {
         var _loc2_:int = 0;
         for each(var _loc1_ in var_1705)
         {
            if(_loc1_.status == class_3417.var_3480)
            {
               _loc2_ += 1;
            }
         }
         _questEngine.events.dispatchEvent(new UnseenDailyTasksCountUpdateEvent(_loc2_));
      }
      
      private function updateWindowDimensions() : void
      {
         if(viewExists())
         {
            var_18.taskAmountChanged();
         }
      }
      
      private function onActiveDailyTasks(param1:DailyTasksActiveListMessageEvent) : void
      {
         var _loc2_:* = null;
         var _loc3_:DailyTasksActiveListMessageEventParser = param1.getParser() as DailyTasksActiveListMessageEventParser;
         clearTasks();
         for each(_loc2_ in _loc3_.tasks)
         {
            if(!_loc2_.isBonus)
            {
               addTask(_loc2_);
            }
         }
         for each(_loc2_ in _loc3_.tasks)
         {
            if(_loc2_.isBonus)
            {
               addTask(_loc2_);
            }
         }
         updateWindowDimensions();
         updateUnseenTasks();
      }
      
      private function onTasksAdded(param1:DailyTasksTasksAddedMessageEvent) : void
      {
         var _loc3_:DailyTasksTasksAddedMessageEventParser = param1.getParser() as DailyTasksTasksAddedMessageEventParser;
         for each(var _loc2_ in _loc3_.tasks)
         {
            addTask(_loc2_);
         }
         if(_loc3_.tasks.length > 0 && _loc3_.tasks[0].isBonus)
         {
            _questEngine.notifications.addItem(_localizationManager.getLocalization("dailytasks.bonus_available"),"info","icon_daily_tasks_png","dailytasks/open");
         }
         updateWindowDimensions();
         updateUnseenTasks();
      }
      
      private function onTaskUpdated(param1:DailyTasksTaskUpdateMessageEvent) : void
      {
         var _loc4_:int = 0;
         var _loc3_:DailyTasksTaskUpdateMessageEventParser = param1.getParser() as DailyTasksTaskUpdateMessageEventParser;
         var _loc2_:class_3417 = getTaskById(_loc3_.taskId);
         if(_loc2_ == null)
         {
            requestTasks();
         }
         else
         {
            _loc4_ = _loc2_.status;
            _loc2_.repeats = _loc3_.repeats;
            _loc2_.status = _loc3_.status;
            if(viewExists())
            {
               var_18.taskUpdated(_loc2_.taskId);
            }
            if(_loc4_ != _loc2_.status)
            {
               if(_loc2_.status == class_3417.var_3480)
               {
                  _questEngine.notifications.addItem(_localizationManager.getLocalization("dailytasks.completed.caption"),"info","icon_daily_tasks_png","dailytasks/open");
               }
               else if(_loc2_.status == class_3417.var_5228)
               {
                  _questEngine.notifications.addItem(_localizationManager.getLocalization("dailytasks.claimed.caption"),"info","icon_daily_tasks_png","dailytasks/open");
               }
            }
         }
         updateUnseenTasks();
      }
      
      public function getTaskById(param1:Number) : class_3417
      {
         for each(var _loc2_ in var_1705)
         {
            if(_loc2_.taskId == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function get tasks() : Vector.<class_3417>
      {
         return var_1705;
      }
      
      public function requestTasks() : void
      {
         if(getTimer() <= _lastRequestTime + 10000)
         {
            return;
         }
         _lastRequestTime = getTimer();
         send(new GetDailyTasksComposer());
      }
      
      public function claimTask(param1:Number) : void
      {
         send(new ClaimDailyTaskComposer(param1));
      }
      
      public function update(param1:uint) : void
      {
         if(viewExists())
         {
            var_18.update(param1);
         }
      }
      
      public function send(param1:IMessageComposer) : void
      {
         _communicationManager.connection.send(param1);
      }
      
      public function addMessageEvent(param1:IMessageEvent) : void
      {
         if(!_communicationManager)
         {
            return;
         }
         _communicationManager.addHabboConnectionMessageEvent(param1);
      }
      
      public function removeMessageEvent(param1:IMessageEvent) : void
      {
         if(!_communicationManager)
         {
            return;
         }
         _communicationManager.removeHabboConnectionMessageEvent(param1);
      }
      
      public function get localizationManager() : class_27
      {
         return _localizationManager;
      }
      
      public function get windowManager() : class_38
      {
         return _windowManager;
      }
      
      public function get questEngine() : HabboQuestEngine
      {
         return _questEngine;
      }
      
      override public function dispose() : void
      {
         if(var_1134)
         {
            return;
         }
         var_1134 = true;
         if(var_18)
         {
            var_18.dispose();
            var_18 = null;
         }
         for each(var _loc1_ in _messageEvents)
         {
            removeMessageEvent(_loc1_);
         }
         _messageEvents = null;
         _communicationManager = null;
         _windowManager = null;
         _localizationManager = null;
         super.dispose();
      }
      
      override public function get disposed() : Boolean
      {
         return var_1134;
      }
      
      public function get view() : DailyTasksView
      {
         return var_18;
      }
   }
}

