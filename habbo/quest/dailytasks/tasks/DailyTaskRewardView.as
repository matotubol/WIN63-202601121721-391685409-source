package com.sulake.habbo.quest.dailytasks.tasks
{
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_1993;
   import com.sulake.core.window.components.class_2010;
   import com.sulake.habbo.quest.dailytasks.DailyTasksController;
   import com.sulake.habbo.window.widgets.class_2343;
   import package_139.class_3743;
   
   public class DailyTaskRewardView implements class_13
   {
      
      private var var_1940:class_3743;
      
      private var var_55:DailyTasksController;
      
      private var _window:class_1812;
      
      private var _disposed:Boolean;
      
      public function DailyTaskRewardView(param1:class_3743, param2:DailyTasksController)
      {
         super();
         var_1940 = param1;
         var_55 = param2;
         _window = param2.view.rewardTemplate.clone() as class_1812;
         initializeUI();
      }
      
      private function initializeUI() : void
      {
         rewardAmountBorder.visible = var_1940.amount > 1;
         rewardAmountText.caption = "x" + String(reward.amount);
         (rewardDisplayWidget.widget as class_2343).productInfo = new RewardDisplayWrapper(var_1940);
         if(!rewardAmountBorder.visible)
         {
            rewardDisplayWidget.y = rewardDisplayWidget.parent.height / 2 - rewardDisplayWidget.height / 2;
         }
      }
      
      public function get reward() : class_3743
      {
         return var_1940;
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _window.dispose();
         _window = null;
         var_55 = null;
         var_1940 = null;
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get window() : class_1812
      {
         return _window;
      }
      
      public function get rewardDisplayWidget() : class_2010
      {
         return _window.findChildByName("reward_display_widget") as class_2010;
      }
      
      public function get rewardAmountBorder() : class_1993
      {
         return _window.findChildByName("reward_amount_border") as class_1993;
      }
      
      public function get rewardAmountText() : ITextWindow
      {
         return _window.findChildByName("reward_amount_text") as ITextWindow;
      }
   }
}

