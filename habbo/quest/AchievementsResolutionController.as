package com.sulake.habbo.quest
{
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IItemGridWindow;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.class_2010;
   import com.sulake.core.window.components.class_2250;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.core.window.utils.class_2001;
   import com.sulake.habbo.window.widgets.class_2728;
   import com.sulake.habbo.window.widgets.class_3087;
   import package_103.class_2361;
   import package_103.class_3070;
   import package_163.class_3292;
   import package_163.class_3303;
   import package_26.class_2847;
   
   public class AchievementsResolutionController implements class_13
   {
      
      private static const const_202:String = "header_button_close";
      
      private static const const_248:String = "save_button";
      
      private static const const_144:String = "cancel_button";
      
      private static const const_147:String = "ok_button";
      
      private static const ELEM_DISABLED_INFO:String = "disabled.reason";
      
      private var _questEngine:HabboQuestEngine;
      
      private var _window:class_2250;
      
      private var _progressView:AchievementResolutionProgressView;
      
      private var _completedView:AchievementResolutionCompletedView;
      
      private var _stuffId:int;
      
      private var var_1423:Vector.<class_3292>;
      
      private var _selectedAchievementId:int = -1;
      
      private var _endTime:int = -1;
      
      public function AchievementsResolutionController(param1:HabboQuestEngine)
      {
         super();
         _questEngine = param1;
      }
      
      public function dispose() : void
      {
         _questEngine = null;
         if(_window)
         {
            var _loc1_:IItemGridWindow = _window.findChildByName("achievements") as IItemGridWindow;
            if(_progressView)
            {
               _progressView.dispose();
               _progressView = null;
            }
            if(_completedView)
            {
               _completedView.dispose();
               _completedView = null;
            }
            _window.dispose();
            _window = null;
         }
      }
      
      public function get disposed() : Boolean
      {
         return _questEngine == null;
      }
      
      public function onResolutionAchievements(param1:int, param2:Vector.<class_3292>, param3:int) : void
      {
         _stuffId = param1;
         var_1423 = param2;
         _endTime = param3;
         if(param2.length == 0)
         {
            return;
         }
         refresh();
         _window.visible = true;
         _selectedAchievementId = var_1423[0].achievementId;
         populateAchievementGrid();
         selectAchievement(_selectedAchievementId);
      }
      
      public function onResolutionProgress(param1:int, param2:int, param3:String, param4:int, param5:int, param6:int) : void
      {
         if(!_progressView)
         {
            _progressView = new AchievementResolutionProgressView(this);
         }
         _progressView.show(param1,param2,param3,param4,param5,param6);
      }
      
      public function onResolutionCompleted(param1:String, param2:String) : void
      {
         if(!_completedView)
         {
            _completedView = new AchievementResolutionCompletedView(this);
         }
         _completedView.show(param2,param1);
      }
      
      public function onLevelUp(param1:class_2847) : void
      {
         if(_progressView && _progressView.visible && param1.type == _progressView.achievementId)
         {
            _questEngine.send(new class_3070(_progressView.stuffId,0));
         }
      }
      
      public function onAchievement(param1:class_3303) : void
      {
         if(_progressView && _progressView.visible && param1.achievementId == _progressView.achievementId)
         {
            _questEngine.send(new class_3070(_progressView.stuffId,0));
         }
      }
      
      public function resetResolution(param1:int) : void
      {
         var title:String;
         var summary:String;
         var stuffId:int = param1;
         if(_progressView && _progressView.visible && stuffId == _progressView.stuffId)
         {
            title = "${resolution.reset.confirmation.title}";
            summary = "${resolution.reset.confirmation.text}";
            _questEngine.windowManager.confirm(title,summary,0,function(param1:class_2001, param2:class_1758):void
            {
               param1.dispose();
               if(param2.type == "WE_OK")
               {
                  _questEngine.send(new class_2361(stuffId));
                  _questEngine.send(new class_3070(_progressView.stuffId,0));
               }
            });
         }
      }
      
      private function refresh() : void
      {
         if(_window == null)
         {
            prepareWindow();
         }
         var _loc1_:class_2010 = class_2010(_window.findChildByName("countdown_widget"));
         var _loc2_:class_2728 = class_2728(_loc1_.widget);
         _loc2_.seconds = _endTime;
         _loc2_.running = true;
      }
      
      private function prepareWindow() : void
      {
         if(this._window != null)
         {
            return;
         }
         _window = class_2250(_questEngine.getXmlWindow("AchievementsResolutions"));
         _window.findChildByTag("close").procedure = onWindowClose;
         _window.center();
         _window.visible = true;
         addClickListener("header_button_close");
         addClickListener("save_button");
         addClickListener("cancel_button");
      }
      
      private function onWindowClose(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type == "WME_CLICK")
         {
            close();
         }
      }
      
      private function addClickListener(param1:String) : void
      {
         var _loc2_:class_1741 = _window.findChildByName(param1);
         if(_loc2_ != null)
         {
            _loc2_.addEventListener("WME_CLICK",onMouseClick);
         }
      }
      
      private function onMouseClick(param1:WindowMouseEvent) : void
      {
         var title:String;
         var summary:String;
         var event:WindowMouseEvent = param1;
         switch(event.target.name)
         {
            case "header_button_close":
            case "cancel_button":
               close();
               break;
            case "save_button":
               title = "${resolution.confirmation.title}";
               summary = "${resolution.confirmation.text}";
               close();
               _questEngine.windowManager.confirm(title,summary,0,function(param1:class_2001, param2:class_1758):void
               {
                  param1.dispose();
                  if(param2.type == "WE_OK")
                  {
                     _questEngine.send(new class_3070(_stuffId,_selectedAchievementId));
                  }
                  else
                  {
                     _window.visible = true;
                  }
               });
               break;
            case "ok_button":
         }
      }
      
      public function isVisible() : Boolean
      {
         return _window && _window.visible;
      }
      
      public function close() : void
      {
         if(_window)
         {
            _window.visible = false;
         }
      }
      
      private function populateAchievementGrid() : void
      {
         var _loc3_:class_1812 = null;
         var _loc2_:IItemGridWindow = _window.findChildByName("achievements") as IItemGridWindow;
         _loc2_.destroyGridItems();
         var _loc4_:class_1741 = _questEngine.getXmlWindow("AchievementSimple");
         for each(var _loc1_ in var_1423)
         {
            _loc3_ = _loc4_.clone() as class_1812;
            _loc3_.id = _loc1_.achievementId;
            refreshBadgeImage(_loc3_,_loc1_);
            _loc3_.findChildByName("bg_region").procedure = onSelectAchievementProc;
            _loc3_.findChildByName("bg_selected_bitmap").visible = false;
            _loc2_.addGridItem(_loc3_);
         }
      }
      
      private function hiliteGridItem(param1:int, param2:Boolean) : void
      {
         var _loc4_:IItemGridWindow = _window.findChildByName("achievements") as IItemGridWindow;
         var _loc3_:class_1812 = _loc4_.getGridItemByID(param1) as class_1812;
         if(_loc3_)
         {
            _loc3_.findChildByName("bg_selected_bitmap").visible = param2;
         }
      }
      
      private function selectAchievement(param1:int) : void
      {
         if(_selectedAchievementId != -1)
         {
            hiliteGridItem(_selectedAchievementId,false);
         }
         var _loc2_:class_3292 = findAchievement(param1);
         if(_loc2_ == null)
         {
            return;
         }
         _selectedAchievementId = param1;
         hiliteGridItem(_selectedAchievementId,true);
         _window.findChildByName("achievement.name").caption = _questEngine.localization.getBadgeName(_loc2_.badgeId);
         _window.findChildByName("achievement.description").caption = _questEngine.localization.getBadgeDesc(_loc2_.badgeId);
         _window.findChildByName("achievement.level").caption = _loc2_.level.toString();
         _questEngine.localization.registerParameter("resolution.achievement.target.value","level",_loc2_.requiredLevel.toString());
         refreshBadgeImageLarge(_loc2_);
         _loc2_.enabled ? enable() : disable(_loc2_.state);
      }
      
      private function disable(param1:int) : void
      {
         _window.setVisibleChildren(false,["save_button"]);
         _window.setVisibleChildren(true,["disabled.reason"]);
         _window.findChildByName("disabled.reason").caption = "${resolution.disabled." + param1 + "}";
      }
      
      public function enable() : void
      {
         _window.setVisibleChildren(true,["save_button"]);
         _window.setVisibleChildren(false,["disabled.reason"]);
      }
      
      private function onSelectAchievementProc(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         selectAchievement(param2.parent.id);
      }
      
      private function refreshBadgeImage(param1:class_1812, param2:class_3292) : void
      {
         var _loc4_:class_2010 = param1.findChildByName("achievement_pic_bitmap") as class_2010;
         var _loc3_:class_3087 = _loc4_.widget as class_3087;
         if(param2 == null)
         {
            _loc4_.visible = false;
            return;
         }
         IStaticBitmapWrapperWindow(class_1812(_loc4_.rootWindow).findChildByName("bitmap")).assetUri = "common_loading_icon";
         _loc3_.badgeId = param2.badgeId;
         _loc3_.greyscale = !param2.enabled;
         _loc4_.visible = true;
      }
      
      private function refreshBadgeImageLarge(param1:class_3292) : void
      {
         var _loc3_:class_2010 = _window.findChildByName("achievement_badge") as class_2010;
         var _loc2_:class_3087 = _loc3_.widget as class_3087;
         IStaticBitmapWrapperWindow(class_1812(_loc3_.rootWindow).findChildByName("bitmap")).assetUri = "common_loading_icon";
         _loc2_.badgeId = param1.badgeId;
         _loc2_.greyscale = !param1.enabled;
         _loc3_.visible = true;
      }
      
      private function findAchievement(param1:int) : class_3292
      {
         for each(var _loc2_ in var_1423)
         {
            if(_loc2_.achievementId == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function get questEngine() : HabboQuestEngine
      {
         return _questEngine;
      }
   }
}

