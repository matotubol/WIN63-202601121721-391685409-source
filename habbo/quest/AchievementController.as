package com.sulake.habbo.quest
{
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.runtime.class_31;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.class_2010;
   import com.sulake.core.window.components.class_2250;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.session.events.BadgeImageReadyEvent;
   import com.sulake.habbo.window.widgets.class_3087;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import flash.utils.Timer;
   import com.sulake.habbo.communication.messages.incoming.inventory.achievements.class_3303;
   import com.sulake.habbo.communication.messages.outgoing.inventory.achievements.GetAchievementsComposer;
   import com.sulake.habbo.communication.messages.outgoing.tracking.EventLogMessageComposer;
   
   public class AchievementController implements class_13, class_31
   {
      
      private static const CATEGORIES_COLUMN_COUNT:int = 3;
      
      private static const CATEGORY_SPACING_X:int = 8;
      
      private static const CATEGORY_SPACING_Y:int = 5;
      
      private static const CATEGORY_SPACING_TOP:int = 6;
      
      private static const CATEGORY_ROWS_MAX:int = 3;
      
      private static const ACHIEVEMENT_ROWS_MIN:int = 2;
      
      private static const ACHIEVEMENT_ROWS_MAX:int = 4;
      
      private static const ACHIEVEMENT_COLUMNS:int = 6;
      
      private static const IN_LEVEL_PROGRESS_BAR_WIDTH:int = 180;
      
      private static const TOTAL_PROGRESS_BAR_WIDTH:int = 246;
      
      private static const const_1186:uint = 12910463;
      
      private static const const_201:int = 45;
      
      private static const const_806:int = 20;
      
      private static const ACHIEVEMENT_TOP_SPACING:int = 3;
      
      private static const IN_LEVEL_PROGRESS_BAR_LOC:Point = new Point(115,93);
      
      private static const TOTAL_PROGRESS_BAR_LOC:Point = new Point(72,1);
      
      private var _questEngine:HabboQuestEngine;
      
      private var _window:class_2250;
      
      private var var_835:class_1812;
      
      private var var_1662:class_1812;
      
      private var var_663:class_1812;
      
      private var var_1565:class_1812;
      
      private var var_2039:class_1812;
      
      private var var_143:AchievementCategories;
      
      private var var_191:AchievementCategory;
      
      private var var_92:class_3303;
      
      private var var_954:Timer;
      
      private var var_2867:Dictionary = new Dictionary();
      
      private var var_1090:ProgressBar;
      
      private var var_1324:ProgressBar;
      
      private var _pendingCategorySelect:String = null;
      
      private var var_2229:class_3303;
      
      private var var_1415:Timer;
      
      private var var_1265:Dictionary = new Dictionary();
      
      private var var_2822:Boolean;
      
      private var var_734:Dictionary = new Dictionary();
      
      public function AchievementController(param1:HabboQuestEngine)
      {
         super();
         _questEngine = param1;
         var_954 = new Timer(100,1);
         var_954.addEventListener("timer",doBadgeRefresh);
         var_1415 = new Timer(2000,1);
         var_1415.addEventListener("timer",switchIntoPendingLevel);
         var_1265[16] = 1;
         var_1265[28] = 6;
         var_1265[38] = 4;
         var_1265[39] = 3;
         var_1265[40] = 1;
      }
      
      public static function moveAllChildrenToColumn(param1:class_1812, param2:int, param3:int) : void
      {
         var _loc4_:int = 0;
         var _loc5_:class_1741 = null;
         while(_loc4_ < param1.numChildren)
         {
            _loc5_ = param1.getChildAt(_loc4_);
            if(_loc5_ != null && _loc5_.visible && _loc5_.height > 0)
            {
               _loc5_.y = param2;
               param2 += _loc5_.height + param3;
            }
            _loc4_++;
         }
      }
      
      public static function getLowestPoint(param1:class_1812) : int
      {
         var _loc2_:int = 0;
         var _loc4_:class_1741 = null;
         _loc2_ = 0;
         while(_loc2_ < param1.numChildren)
         {
            _loc4_ = param1.getChildAt(_loc2_);
            if(_loc4_.visible)
            {
               var _loc3_:int = Math.max(0,_loc4_.y + _loc4_.height);
            }
            _loc2_++;
         }
         return 0;
      }
      
      public function dispose() : void
      {
         _questEngine = null;
         var_2867 = null;
         if(_window)
         {
            _window.dispose();
            _window = null;
         }
         if(var_954)
         {
            var_954.removeEventListener("timer",doBadgeRefresh);
            var_954.reset();
            var_954 = null;
         }
         if(var_1415)
         {
            var_1415.removeEventListener("timer",switchIntoPendingLevel);
            var_1415.reset();
            var_1415 = null;
         }
         if(var_1090)
         {
            var_1090.dispose();
            var_1090 = null;
         }
         if(var_1324)
         {
            var_1324.dispose();
            var_1324 = null;
         }
         var_835 = null;
         var_663 = null;
         var_663 = null;
         var_1565 = null;
         var_2039 = null;
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
         var_734 = new Dictionary();
         broadcastUnseenAchievementsCount();
         if(_window)
         {
            _window.visible = false;
         }
      }
      
      private function broadcastUnseenAchievementsCount() : void
      {
         var _loc2_:int = 0;
         for each(var _loc1_ in var_734)
         {
            if(!isSkippedForUnseenBroadcast(_loc1_.badgeId))
            {
               _loc2_++;
            }
         }
      }
      
      public function onRoomExit() : void
      {
         this.close();
      }
      
      public function onToolbarClick() : void
      {
         if(isVisible())
         {
            close();
         }
         else
         {
            show();
         }
      }
      
      public function ensureAchievementsInitialized() : void
      {
         if(var_143 == null)
         {
            _questEngine.send(new GetAchievementsComposer());
         }
      }
      
      public function show() : void
      {
         if(var_143 == null)
         {
            _questEngine.send(new GetAchievementsComposer());
            var_2822 = true;
         }
         else
         {
            refresh();
            this._window.visible = true;
            this._window.activate();
         }
      }
      
      public function onAchievements(param1:Array, param2:String) : void
      {
         if(var_143 == null)
         {
            var_143 = new AchievementCategories(param1,_questEngine);
         }
         if(!var_2822)
         {
            return;
         }
         var_2822 = false;
         refresh();
         this._window.visible = true;
         this._window.activate();
         var _loc3_:String = _pendingCategorySelect == null ? param2 : _pendingCategorySelect;
         var _loc4_:AchievementCategory = var_143.getCategoryByCode(_loc3_);
         if(_loc4_ != null)
         {
            pickCategory(_loc4_);
            _pendingCategorySelect = null;
         }
      }
      
      public function onAchievement(param1:class_3303) : void
      {
         var _loc2_:Boolean = false;
         if(var_143 != null)
         {
            _loc2_ = var_92 && var_92.achievementId == param1.achievementId;
            if(!_loc2_ && !(param1.achievementId in var_734))
            {
               var_734[param1.achievementId] = param1;
               broadcastUnseenAchievementsCount();
            }
            if(_loc2_ && param1.level > var_92.level)
            {
               var_92.setMaxProgress();
               var_2229 = param1;
               var_1415.start();
            }
            else
            {
               var_143.update(param1);
               if(_loc2_)
               {
                  var_92 = param1;
               }
            }
            if(_window && _window.visible)
            {
               refresh();
            }
         }
      }
      
      private function getCategoryUnseenCount(param1:String) : int
      {
         var _loc3_:int = 0;
         for each(var _loc2_ in var_734)
         {
            if(_loc2_.category == param1)
            {
               _loc3_++;
            }
         }
         return _loc3_;
      }
      
      private function refresh() : void
      {
         prepareWindow();
         refreshCategoryList();
         refreshCategoryListFooter();
         refreshAchievementsHeader();
         refreshAchievementList();
         refreshAchievementDetails();
         moveAllChildrenToColumn(_window.content,0,4);
         _window.height = getLowestPoint(_window.content) + 45;
      }
      
      private function refreshCategoryList() : void
      {
         var _loc3_:int = 0;
         var _loc1_:Boolean = false;
         if(var_191 != null)
         {
            var_835.visible = false;
            return;
         }
         var_835.visible = true;
         var _loc2_:Vector.<AchievementCategory> = var_143.categoryList;
         _loc3_ = 0;
         while(true)
         {
            if(_loc3_ < _loc2_.length)
            {
               var _loc4_:AchievementCategory = _loc2_[_loc3_];
               if(_loc4_.visibleInList())
               {
                  refreshCategoryEntry(_loc3_,null);
               }
            }
            else
            {
               _loc1_ = refreshCategoryEntry(_loc3_,null);
               if(_loc1_)
               {
                  break;
               }
            }
            _loc3_++;
         }
         var_835.height = getLowestPoint(var_835);
      }
      
      private function refreshCategoryListFooter() : void
      {
         if(var_191 != null)
         {
            var_2039.visible = false;
            return;
         }
         var_2039.visible = true;
         var_1324.refresh(var_143.getProgress(),var_143.getMaxProgress(),0,0);
      }
      
      private function refreshAchievementList() : void
      {
         var _loc5_:int = 0;
         var _loc3_:Boolean = false;
         var _loc2_:class_1741 = _window.findChildByName("achievements_list");
         if(var_191 == null)
         {
            _loc2_.visible = false;
            return;
         }
         _loc2_.visible = true;
         class_21.log(var_191.code + " has " + var_191.achievements.length + " achievements");
         var _loc4_:Vector.<class_3303> = var_191.achievements;
         while(var_1662.numChildren > 0)
         {
            var_1662.removeChildAt(0);
         }
         _loc5_ = 0;
         while(true)
         {
            if(_loc5_ < _loc4_.length)
            {
               refreshAchievementEntry(_loc5_,_loc4_[_loc5_]);
            }
            else
            {
               _loc3_ = refreshAchievementEntry(_loc5_,null);
               if(_loc3_)
               {
                  break;
               }
            }
            _loc5_++;
         }
         var_1662.height = getLowestPoint(var_1662);
         _loc2_.height = var_1662.height + 1;
         _window.findChildByName("achievements_scrollarea").height = _loc2_.height;
         var _loc1_:class_1741 = _window.findChildByName("achievements_scrollbar");
         _loc1_.visible = achievementsNeedScrolling;
         _loc1_.height = _loc2_.height;
      }
      
      private function refreshAchievementsHeader() : void
      {
         if(var_191 == null)
         {
            var_1565.visible = false;
            return;
         }
         var_1565.visible = true;
         var_1565.findChildByName("category_name_txt").caption = _questEngine.getAchievementCategoryName(var_191.code);
         _questEngine.localization.registerParameter("achievements.details.categoryprogress","progress",var_191.getProgress().toString());
         _questEngine.localization.registerParameter("achievements.details.categoryprogress","limit",var_191.getMaxProgress().toString());
         _questEngine.setupAchievementCategoryImage(var_1565,var_191,false);
      }
      
      private function refreshAchievementDetails() : void
      {
         if(var_92 == null)
         {
            var_663.visible = false;
            return;
         }
         var_663.visible = true;
         var _loc2_:String = getAchievedBadgeId(var_92);
         var_663.findChildByName("achievement_name_txt").caption = _questEngine.localization.getBadgeName(_loc2_);
         var _loc1_:String = _questEngine.localization.getBadgeDesc(_loc2_);
         var_663.findChildByName("achievement_desc_txt").caption = _loc1_ == null ? "" : _loc1_;
         _questEngine.localization.registerParameter("achievements.details.level","level",var_92.finalLevel ? var_92.level.toString() : (var_92.level - 1).toString());
         _questEngine.localization.registerParameter("achievements.details.level","limit",var_92.levelCount.toString());
         _questEngine.refreshReward(!var_92.finalLevel,var_663,var_92.levelRewardPointType,var_92.levelRewardPoints);
         refreshBadgeImageLarge(var_663,var_92);
         var_1090.refresh(var_92.currentPoints,var_92.scoreLimit,var_92.achievementId * 10000 + var_92.level,var_92.scoreAtStartOfLevel);
         var_1090.visible = var_92.displayMethod != 1 && !var_92.finalLevel;
      }
      
      private function prepareWindow() : void
      {
         if(this._window != null)
         {
            return;
         }
         _window = class_2250(_questEngine.getXmlWindow("Achievements"));
         _window.findChildByTag("close").procedure = onWindowClose;
         _window.findChildByName("back_button").procedure = onBack;
         _window.center();
         _window.y = 20;
         var_835 = class_1812(_window.findChildByName("categories_cont"));
         var_1565 = class_1812(_window.findChildByName("achievements_header_cont"));
         var_1662 = class_1812(_window.findChildByName("achievements_cont"));
         var_663 = class_1812(_window.findChildByName("achievement_cont"));
         var_2039 = class_1812(_window.findChildByName("categories_footer_cont"));
         var_1090 = new ProgressBar(_questEngine,var_663,180,"achievements.details.progress",true,IN_LEVEL_PROGRESS_BAR_LOC);
         var_1324 = new ProgressBar(_questEngine,var_2039,246,"achievements.categories.totalprogress",true,TOTAL_PROGRESS_BAR_LOC);
      }
      
      private function refreshCategoryEntry(param1:int, param2:AchievementCategory) : Boolean
      {
         var _loc5_:int = 0;
         var _loc3_:class_1812 = class_1812(var_835.getChildByName(param1.toString()));
         var _loc4_:int = Math.floor(param1 / 3);
         var _loc6_:* = _loc4_ < 3;
         if(_loc3_ == null)
         {
            if(param2 == null && !_loc6_)
            {
               return true;
            }
            _loc3_ = class_1812(_questEngine.getXmlWindow("AchievementCategory"));
            _loc3_.name = param1.toString();
            var_835.addChild(_loc3_);
            _loc3_.findChildByName("category_region").procedure = onSelectCategory;
            _loc3_.x = (_loc3_.width + 8) * (param1 % 3);
            _loc3_.y = (_loc3_.height + 5) * Math.floor(param1 / 3) + 6;
         }
         _loc3_.findChildByName("category_region").id = param1;
         _loc3_.findChildByName("category_region").visible = param2 != null;
         _loc3_.findChildByName("category_bg_inact").visible = param2 == null;
         _loc3_.findChildByName("category_bg_act").visible = param2 != null;
         _loc3_.findChildByName("category_bg_act_hover").visible = false;
         _loc3_.findChildByName("header_txt").visible = param2 != null;
         _loc3_.findChildByName("completion_txt").visible = param2 != null;
         _loc3_.findChildByName("category_pic_bitmap").visible = param2 != null;
         _loc3_.findChildByName("unseen_count_border").visible = false;
         if(param2)
         {
            _loc3_.findChildByName("header_txt").caption = _questEngine.getAchievementCategoryName(param2.code);
            _loc3_.findChildByName("completion_txt").caption = param2.getProgress() + "/" + param2.getMaxProgress();
            _questEngine.setupAchievementCategoryImage(_loc3_,param2,true);
            _loc5_ = getCategoryUnseenCount(param2.code);
            if(_loc5_ > 0)
            {
               _loc3_.findChildByName("unseen_count_border").visible = true;
               _loc3_.findChildByName("unseen_count").caption = _loc5_.toString();
            }
            _loc3_.visible = true;
         }
         else
         {
            _loc3_.visible = _loc6_;
         }
         return false;
      }
      
      private function refreshAchievementEntry(param1:int, param2:class_3303) : Boolean
      {
         var _loc5_:int = param1 / achievementsColumnCount;
         var _loc8_:* = _loc5_ < 2;
         if(param2 == null && !_loc8_)
         {
            return true;
         }
         var _loc3_:class_1812 = _questEngine.getXmlWindow("Achievement") as class_1812;
         var_1662.addChild(_loc3_);
         _loc3_.x = (_loc3_.width + (achievementsNeedScrolling ? 5 : 0)) * (param1 % achievementsColumnCount);
         class_21.log("Refreshing " + param1 + " where count is " + var_191.achievements.length + ", row=" + _loc5_ + ", column=" + param1 % achievementsColumnCount);
         _loc3_.y = _loc3_.height * _loc5_ + 3;
         _loc3_.findChildByName("bg_region").procedure = onSelectAchievement;
         var _loc6_:class_1741 = _loc3_.findChildByName("bg_region");
         _loc6_.id = param1;
         _loc6_.visible = param2 != null;
         var _loc4_:class_1741 = _loc3_.findChildByName("bg_unselected_bitmap");
         var _loc7_:class_1741 = _loc3_.findChildByName("bg_selected_bitmap");
         this.refreshBadgeImage(_loc3_,param2);
         _loc4_.color = param2 != null && param2.achievementId in var_734 ? 12910463 : 16777215;
         if(param2)
         {
            _loc4_.visible = param2 != var_92;
            _loc7_.visible = param2 == var_92;
            _loc3_.visible = true;
         }
         else if(_loc8_)
         {
            _loc7_.visible = false;
            _loc4_.visible = true;
            _loc3_.visible = true;
         }
         else
         {
            _loc3_.visible = false;
         }
         return false;
      }
      
      private function onWindowClose(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type == "WME_CLICK")
         {
            close();
         }
      }
      
      private function onSelectCategory(param1:class_1758, param2:class_1741) : void
      {
         var _loc3_:int = param2.id;
         class_21.log("Category index: " + _loc3_);
         if(param1.type == "WME_CLICK")
         {
            pickCategory(var_143.categoryList[_loc3_]);
         }
         else if(param1.type == "WME_OUT")
         {
            refreshMouseOver(-999);
         }
         else if(param1.type == "WME_OVER")
         {
            refreshMouseOver(_loc3_);
         }
      }
      
      private function pickCategory(param1:AchievementCategory) : void
      {
         var_191 = param1;
         var_92 = var_191.achievements[0];
         class_21.log("Category: " + var_191.code);
         this.refresh();
         _questEngine.send(new EventLogMessageComposer("Achievements",var_191.code,"Category selected"));
      }
      
      public function selectCategoryInternalLink(param1:String) : void
      {
         var _loc2_:AchievementCategory = var_143 != null ? var_143.getCategoryByCode(param1) : null;
         if(_loc2_ != null)
         {
            pickCategory(_loc2_);
         }
         else
         {
            _pendingCategorySelect = param1;
         }
      }
      
      private function refreshMouseOver(param1:int) : void
      {
         var _loc4_:int = 0;
         var _loc2_:* = false;
         var _loc3_:class_1812 = null;
         var _loc5_:class_1741 = null;
         _loc4_ = 0;
         while(_loc4_ < var_835.numChildren)
         {
            _loc2_ = _loc4_ == param1;
            _loc3_ = class_1812(var_835.getChildAt(_loc4_));
            _loc3_.findChildByName("category_bg_act").visible = !_loc2_ && _loc4_ < var_143.categoryList.length;
            _loc3_.findChildByName("category_bg_act_hover").visible = _loc2_;
            _loc5_ = _loc3_.findChildByName("hover_container");
            _loc5_.x = _loc2_ ? 0 : 1;
            _loc5_.y = _loc2_ ? 0 : 1;
            _loc4_++;
         }
      }
      
      private function onSelectAchievement(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         var _loc3_:int = param2.id;
         var_92 = var_191.achievements[_loc3_];
         this.refresh();
         _questEngine.send(new EventLogMessageComposer("Achievements",var_92.achievementId.toString(),"Achievement selected"));
      }
      
      private function onBack(param1:class_1758, param2:class_1741) : void
      {
         var _loc4_:Array = null;
         var _loc3_:* = null;
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         if(var_191 != null)
         {
            _loc4_ = [];
            for each(_loc3_ in var_734)
            {
               if(_loc3_.category != var_191.code)
               {
                  _loc4_.push(_loc3_);
               }
            }
            var_734 = new Dictionary();
            for each(_loc3_ in _loc4_)
            {
               var_734[_loc3_.achievementId] = _loc3_;
            }
            broadcastUnseenAchievementsCount();
         }
         var_191 = null;
         var_92 = null;
         this.refresh();
      }
      
      private function refreshBadgeImage(param1:class_1812, param2:class_3303) : void
      {
         var _loc4_:class_2010 = param1.findChildByName("achievement_pic_bitmap") as class_2010;
         var _loc3_:class_3087 = _loc4_.widget as class_3087;
         if(param2 == null)
         {
            _loc4_.visible = false;
            return;
         }
         IStaticBitmapWrapperWindow(class_1812(_loc4_.rootWindow).findChildByName("bitmap")).assetUri = "common_loading_icon";
         _loc3_.badgeId = getAchievedBadgeId(param2);
         _loc3_.greyscale = !param2.firstLevelAchieved;
         _loc4_.visible = true;
      }
      
      private function refreshBadgeImageLarge(param1:class_1812, param2:class_3303) : void
      {
         var _loc4_:class_2010 = param1.findChildByName("achievement_pic_bitmap") as class_2010;
         var _loc3_:class_3087 = _loc4_.widget as class_3087;
         IStaticBitmapWrapperWindow(class_1812(_loc4_.rootWindow).findChildByName("bitmap")).assetUri = "common_loading_icon";
         _loc3_.badgeId = getAchievedBadgeId(param2);
         _loc3_.greyscale = !param2.firstLevelAchieved;
         _loc4_.visible = true;
      }
      
      private function doBadgeRefresh(param1:TimerEvent) : void
      {
         this.var_954.reset();
         this.refresh();
      }
      
      private function switchIntoPendingLevel(param1:TimerEvent) : void
      {
         var_92 = var_2229;
         var_143.update(var_2229);
         var_2229 = null;
         this.refresh();
      }
      
      public function onBadgeImageReady(param1:BadgeImageReadyEvent) : void
      {
         if(_window == null)
         {
            return;
         }
         this.var_2867[param1.badgeId] = param1.badgeImage;
         if(!this.var_954.running)
         {
            this.var_954.start();
         }
      }
      
      public function update(param1:uint) : void
      {
         if(var_1090 != null)
         {
            var_1090.updateView(param1);
         }
         if(var_1324 != null)
         {
            var_1324.updateView(param1);
         }
      }
      
      private function getAchievedBadgeId(param1:class_3303) : String
      {
         if(param1.levelCount == 1)
         {
            return param1.badgeId;
         }
         return param1.finalLevel ? param1.badgeId : _questEngine.localization.getPreviousLevelBadgeId(param1.badgeId);
      }
      
      private function getPositionFix(param1:int) : int
      {
         return var_1265[param1] ? var_1265[param1] : 0;
      }
      
      private function get achievementsColumnCount() : int
      {
         if(achievementsNeedScrolling)
         {
            return 6 - 1;
         }
         return 6;
      }
      
      private function get achievementsNeedScrolling() : Boolean
      {
         return var_191 != null && var_191.achievements.length > 4 * 6;
      }
      
      private function isSkippedForUnseenBroadcast(param1:String) : Boolean
      {
         var _loc3_:Boolean = false;
         var _loc4_:Array = _questEngine.getProperty("toolbar.unseen_notification.skipped_badge_ids").split(",");
         for each(var _loc2_ in _loc4_)
         {
            if(param1.search(_loc2_) != -1)
            {
               _loc3_ = true;
               break;
            }
         }
         return _loc3_;
      }
      
      public function getAchievementLevel(param1:String, param2:String) : int
      {
         if(var_143 != null)
         {
            var _loc4_:AchievementCategory = var_143.getCategoryByCode(param1);
            if(_loc4_ != null)
            {
               for each(var _loc3_ in null.achievements)
               {
                  if(_loc3_.badgeId.indexOf(param2) == 0)
                  {
                     return _loc3_.finalLevel ? _loc3_.level : Math.max(0,_loc3_.level - 1);
                  }
               }
            }
         }
         return 0;
      }
   }
}

