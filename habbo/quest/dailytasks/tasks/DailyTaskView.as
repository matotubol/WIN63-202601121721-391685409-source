package com.sulake.habbo.quest.dailytasks.tasks
{
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.runtime.class_31;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_1775;
   import com.sulake.core.window.components.class_1993;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.quest.ProgressBar;
   import com.sulake.habbo.quest.dailytasks.DailyTasksController;
   import flash.geom.Point;
   import package_139.class_3417;
   import package_139.class_3743;
   
   public class DailyTaskView implements class_13, class_31
   {
      
      private static var var_5305:String = "${image.library.dailytasks.url}";
      
      private static var BACKGROUND_GREEN:uint = 13033652;
      
      private static var var_5297:uint = 4960837;
      
      private static var REWARD_GREEN:uint = 10931858;
      
      private static var BACKGROUND_ORANGE:uint = 15916471;
      
      private static var TITLE_ORANGE:uint = 15511865;
      
      private static var REWARD_ORANGE:uint = 15714445;
      
      private static var BACKGROUND_YELLOW:uint = 15725493;
      
      private static var var_5315:uint = 14208611;
      
      private static var REWARD_YELLOW:uint = 14804370;
      
      private var var_248:class_3417;
      
      private var var_55:DailyTasksController;
      
      private var _window:class_1993;
      
      private var var_2596:Vector.<DailyTaskRewardView>;
      
      private var _disposed:Boolean;
      
      private var var_1271:ProgressBar;
      
      private var var_3067:Boolean = false;
      
      public function DailyTaskView(param1:class_3417, param2:DailyTasksController)
      {
         super();
         var_248 = param1;
         var_55 = param2;
         _window = param2.view.taskTemplate.clone() as class_1993;
         var_1271 = new ProgressBar(var_55.questEngine,progressBarContainer,progressBarContainer.width - 8,"quests.tracker.progress",true,new Point(0,0),true);
         var_2596 = new Vector.<DailyTaskRewardView>();
         for each(var _loc3_ in var_248.rewards)
         {
            var _loc4_:DailyTaskRewardView = new DailyTaskRewardView(_loc3_,var_55);
            var_2596.push(null);
            rewardsList.addListItem(null.window);
         }
         claimButton.addEventListener("WME_CLICK",onClaimClicked);
         initializeUI();
      }
      
      private function initializeUI() : void
      {
         taskTitleTxt.text = localize(var_248.nameLocalizationKey);
         taskDescTxt.text = localize(var_248.descriptionLocalizationKey);
         infoHoverRegion.toolTipCaption = localize(var_248.hintLocalizationKey);
         if(var_248.isBonus)
         {
            _window.color = BACKGROUND_YELLOW;
            rewardTitleBorder.color = REWARD_YELLOW;
            taskNameBorder.color = var_5315;
         }
         taskImageStaticBitmap.assetUri = imageUrl;
         updateStatusAndRepeatsUI();
      }
      
      public function updateStatusAndRepeatsUI(param1:Boolean = true) : void
      {
         if(var_248.status == class_3417.var_3480 && Boolean(progressBarContainer.visible) && param1)
         {
            var_1271.refresh(var_248.requiredRepeats,var_248.requiredRepeats,var_248.taskId,0);
            var_3067 = true;
            return;
         }
         if(var_248.status == class_3417.var_5180)
         {
            if(!dailyTask.isBonus)
            {
               _window.color = BACKGROUND_ORANGE;
               rewardTitleBorder.color = REWARD_ORANGE;
               taskNameBorder.color = TITLE_ORANGE;
            }
            completionContainer.visible = false;
            claimButtonContainer.visible = false;
            progressBarContainer.visible = true;
            var_1271.refresh(var_248.repeats,var_248.requiredRepeats,var_248.taskId,0);
         }
         else
         {
            if(!dailyTask.isBonus)
            {
               _window.color = BACKGROUND_GREEN;
               rewardTitleBorder.color = REWARD_GREEN;
               taskNameBorder.color = var_5297;
            }
            completionContainer.visible = true;
            claimButtonContainer.visible = true;
            if(var_248.status == class_3417.var_5228)
            {
               claimButton.disable();
               claimButtonText.text = localize("dailytasks.claimed");
            }
            else
            {
               claimButton.enable();
               claimButtonText.text = localize("dailytasks.claim");
            }
            progressBarContainer.visible = false;
         }
      }
      
      private function onClaimClicked(param1:WindowMouseEvent) : void
      {
         claimButton.disable();
         var_55.claimTask(var_248.taskId);
      }
      
      private function get imageUrl() : String
      {
         return var_5305 + var_248.taskCode + dailyTask.imageVersion + ".png";
      }
      
      public function get dailyTask() : class_3417
      {
         return var_248;
      }
      
      private function localize(param1:String) : String
      {
         return var_55.localizationManager.getLocalization(param1,param1);
      }
      
      public function update(param1:uint) : void
      {
         if(progressBarContainer.visible)
         {
            var_1271.updateView(param1);
         }
         if(var_3067 && !var_1271.isUpdating)
         {
            var_3067 = false;
            updateStatusAndRepeatsUI(false);
         }
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         claimButton.removeEventListener("WME_CLICK",onClaimClicked);
         for each(var _loc1_ in var_2596)
         {
            _loc1_.dispose();
         }
         var_2596 = null;
         var_1271.dispose();
         var_1271 = null;
         _window.dispose();
         _window = null;
         var_55 = null;
         var_248 = null;
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get window() : class_1993
      {
         return _window;
      }
      
      public function get taskNameBorder() : class_1993
      {
         return _window.findChildByName("task_name_cont") as class_1993;
      }
      
      public function get rewardTitleBorder() : class_1993
      {
         return _window.findChildByName("reward_title_border") as class_1993;
      }
      
      public function get taskTitleTxt() : ITextWindow
      {
         return _window.findChildByName("task_title_txt") as ITextWindow;
      }
      
      public function get taskDescTxt() : ITextWindow
      {
         return _window.findChildByName("task_desc_txt") as ITextWindow;
      }
      
      public function get infoHoverRegion() : IRegionWindow
      {
         return _window.findChildByName("info_hover_region") as IRegionWindow;
      }
      
      public function get taskImageStaticBitmap() : IStaticBitmapWrapperWindow
      {
         return _window.findChildByName("task_static_bitmap") as IStaticBitmapWrapperWindow;
      }
      
      public function get completionContainer() : class_1812
      {
         return _window.findChildByName("completion_cont") as class_1812;
      }
      
      public function get rewardsList() : IItemListWindow
      {
         return _window.findChildByName("rewards_list") as IItemListWindow;
      }
      
      public function get claimButtonContainer() : class_1812
      {
         return _window.findChildByName("claim_button_container") as class_1812;
      }
      
      public function get claimButtonText() : ITextWindow
      {
         return _window.findChildByName("claim_txt") as ITextWindow;
      }
      
      public function get claimButton() : class_1775
      {
         return _window.findChildByName("claim_button") as class_1775;
      }
      
      public function get progressBarContainer() : class_1812
      {
         return _window.findChildByName("progress_bar_wrapper") as class_1812;
      }
   }
}

