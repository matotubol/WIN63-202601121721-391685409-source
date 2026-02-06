package com.sulake.habbo.game.snowwar.leaderboard
{
   import com.sulake.core.assets.IAsset;
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.utils.class_55;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.ITextLinkWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_2251;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.avatar.class_1827;
   import com.sulake.habbo.avatar.class_259;
   import com.sulake.habbo.game.snowwar.SnowWarEngine;
   import com.sulake.habbo.game.snowwar.utils.WindowUtils;
   import com.sulake.habbo.localization.class_27;
   import flash.display.BitmapData;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import com.sulake.habbo.communication.messages.parser.game.score.class_3963;
   
   public class LeaderboardViewController implements class_13, class_259
   {
      
      private static const STATE_FRIENDS_ALLTIME:int = 0;
      
      private static const STATE_ALLTIME:int = 1;
      
      private static const STATE_WEEKLY:int = 2;
      
      private static const STATE_FRIENDS_WEEKLY:int = 3;
      
      private static const STATE_GROUP_WEEKLY:int = 4;
      
      private static const STATE_GROUP_ALLTIME:int = 5;
      
      private var var_49:SnowWarEngine;
      
      private var _localization:class_27;
      
      private var _window:class_1812;
      
      private var _disposed:Boolean;
      
      private var var_61:int;
      
      private var var_121:IItemListWindow;
      
      private var _listBorder:class_1741;
      
      private var var_3383:ITextLinkWindow;
      
      private var var_3332:ITextLinkWindow;
      
      private var var_3276:ITextLinkWindow;
      
      private var var_2569:class_2251;
      
      private var var_1556:ITextWindow;
      
      private var var_2483:class_2251;
      
      private var var_2386:ITextWindow;
      
      private var var_1396:IRegionWindow;
      
      private var var_1974:IRegionWindow;
      
      private var _nextWeek:IRegionWindow;
      
      private var _previousWeek:IRegionWindow;
      
      private var var_1408:String;
      
      private var _minutesUntilWeeklyReset:int;
      
      private var var_1118:Timer;
      
      private var _avatarPlaceholders:class_55;
      
      private var var_833:LeaderboardTable;
      
      private var var_1128:TotalLeaderboardTable;
      
      private var var_985:TotalGroupLeaderboardTable;
      
      private var var_333:WeeklyTotalLeaderboardTable;
      
      private var var_307:WeeklyGroupLeaderboardTable;
      
      private var var_362:WeeklyFriendLeaderboardTable;
      
      private var var_4139:Boolean;
      
      private var _selectedGame:int = 0;
      
      public function LeaderboardViewController(param1:SnowWarEngine)
      {
         super();
         var_49 = param1;
         _localization = param1.localization;
         _avatarPlaceholders = new class_55();
         var_4139 = var_49.config.getBoolean("games.highscores.scrolling.enabled");
         var_833 = new LeaderboardTable(var_49);
         var_1128 = new TotalLeaderboardTable(var_49);
         var_985 = new TotalGroupLeaderboardTable(var_49);
         var_333 = new WeeklyTotalLeaderboardTable(var_49);
         var_307 = new WeeklyGroupLeaderboardTable(var_49);
         var_362 = new WeeklyFriendLeaderboardTable(var_49);
         sendGetFriendsAllTimeData();
      }
      
      public function set selectedGame(param1:int) : void
      {
         _selectedGame = param1;
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         var_49 = null;
         var_121 = null;
         _listBorder = null;
         var_3383 = null;
         var_3332 = null;
         var_3276 = null;
         var_2569 = null;
         var_1556 = null;
         var_2483 = null;
         var_2386 = null;
         var_1396 = null;
         var_1974 = null;
         _nextWeek = null;
         _previousWeek = null;
         var_1408 = null;
         _avatarPlaceholders.dispose();
         if(_window)
         {
            _window.dispose();
            _window = null;
         }
         if(var_833)
         {
            var_833.dispose();
            var_833 = null;
         }
         if(var_1128)
         {
            var_1128.dispose();
            var_1128 = null;
         }
         if(var_985)
         {
            var_985.dispose();
            var_985 = null;
         }
         if(var_333)
         {
            var_333.dispose();
            var_333 = null;
         }
         if(var_307)
         {
            var_307.dispose();
            var_307 = null;
         }
         if(var_362)
         {
            var_362.dispose();
            var_362 = null;
         }
         disposeWeeklyResetTimer();
         _disposed = true;
      }
      
      private function disposeWeeklyResetTimer() : void
      {
         if(var_1118 != null)
         {
            var_1118.removeEventListener("timer",onTick);
            var_1118.stop();
            var_1118 = null;
         }
      }
      
      private function startWeeklyResetTimer(param1:int) : void
      {
         var_1118 = new Timer(60000,param1);
         var_1118.addEventListener("timer",onTick);
         var_1118.start();
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      private function enableAllTimeButton() : void
      {
         var_1556.textColor = 0;
         var_2386.textColor = 16777215;
         WindowUtils.setElementImage(var_2569,getBitmap("left_blue"));
         WindowUtils.setElementImage(var_2483,getBitmap("right_black"));
      }
      
      private function enableThisWeekButton() : void
      {
         var_1556.textColor = 16777215;
         var_2386.textColor = 0;
         WindowUtils.setElementImage(var_2569,getBitmap("left_black"));
         WindowUtils.setElementImage(var_2483,getBitmap("right_blue"));
      }
      
      public function showFriendsAllTime() : void
      {
         var_61 = 0;
         sendGetFriendsAllTimeData();
         visible = true;
         _window.caption = "${snowwar.leaderboard.friends}";
         enableAllTimeButton();
         updateWeekSelection();
         populateList();
      }
      
      public function showAllTime() : void
      {
         var_61 = 1;
         sendGetAllTimeData();
         visible = true;
         _window.caption = "${snowwar.leaderboard.all}";
         enableAllTimeButton();
         updateWeekSelection();
         populateList();
      }
      
      public function showGroupAllTime() : void
      {
         var_61 = 5;
         sendGetAllTimeGroupData();
         visible = true;
         _window.caption = "${snowwar.leaderboard.all}";
         enableAllTimeButton();
         updateWeekSelection();
         populateList();
      }
      
      public function showWeekly() : void
      {
         var_61 = 2;
         var_333.offset = 0;
         sendGetWeeklyData(0);
         visible = true;
         _window.caption = "${snowwar.leaderboard.all}";
         enableThisWeekButton();
         updateWeekSelection();
         populateList();
      }
      
      public function showGroupWeekly() : void
      {
         var_61 = 4;
         var_307.offset = 0;
         sendGetGroupWeeklyData(0);
         visible = true;
         _window.caption = "${snowwar.leaderboard.all}";
         enableThisWeekButton();
         updateWeekSelection();
         populateList();
      }
      
      public function showFriendsWeekly() : void
      {
         var_61 = 3;
         var_362.offset = 0;
         sendGetFriendsWeeklyData(0);
         visible = true;
         _window.caption = "${snowwar.leaderboard.friends}";
         enableThisWeekButton();
         updateWeekSelection();
         populateList();
      }
      
      public function addAllTimeData(param1:Array, param2:int) : void
      {
         var_1128.addEntries(param1,param2);
         if(var_61 == 1 && visible)
         {
            populateList();
         }
         updateWeekSelection();
      }
      
      public function addAllTimeGroupData(param1:Array, param2:int, param3:int) : void
      {
         var_985.addGroupEntries(param1,param2,param3);
         if(var_61 == 5 && visible)
         {
            populateList();
         }
         updateWeekSelection();
      }
      
      public function addWeeklyData(param1:int, param2:int, param3:Array, param4:int, param5:int, param6:int) : void
      {
         disposeWeeklyResetTimer();
         _minutesUntilWeeklyReset = param6;
         var_1408 = param1 + "/" + param2;
         var_333.maxOffset = param5;
         var_333.addEntries(param3,param4);
         if(var_61 == 2 && visible)
         {
            populateList();
         }
         updateWeekSelection();
      }
      
      public function addWeeklyGroupData(param1:int, param2:int, param3:Array, param4:int, param5:int, param6:int, param7:int) : void
      {
         disposeWeeklyResetTimer();
         _minutesUntilWeeklyReset = param6;
         var_1408 = param1 + "/" + param2;
         var_307.maxOffset = param5;
         var_307.addGroupEntries(param3,param4,param7);
         if(var_61 == 4 && visible)
         {
            populateList();
         }
         updateWeekSelection();
      }
      
      public function addFriendAllTimeData(param1:Array, param2:int) : void
      {
         var_833.addEntries(param1,param2);
         if(var_61 == 0 && visible)
         {
            populateList();
         }
         updateWeekSelection();
      }
      
      public function addFriendWeeklyData(param1:int, param2:int, param3:Array, param4:int, param5:int, param6:int) : void
      {
         disposeWeeklyResetTimer();
         _minutesUntilWeeklyReset = param6;
         var_1408 = param1 + "/" + param2;
         var_362.maxOffset = param5;
         var_362.addEntries(param3,param4);
         if(var_61 == 3 && visible)
         {
            populateList();
         }
         updateWeekSelection();
      }
      
      public function hide() : void
      {
         visible = false;
      }
      
      public function avatarImageReady(param1:String) : void
      {
         if(_disposed)
         {
            return;
         }
         var _loc2_:class_2251 = _avatarPlaceholders.remove(param1);
         if(_loc2_ && !_loc2_.disposed)
         {
            setAvatarImage(_loc2_,param1);
         }
      }
      
      private function sendGetFriendsAllTimeData() : void
      {
         var_833.revertToDefaultView(_selectedGame);
      }
      
      private function sendGetAllTimeData() : void
      {
         var_1128.revertToDefaultView(_selectedGame);
      }
      
      private function sendGetAllTimeGroupData() : void
      {
         var_985.revertToDefaultView(_selectedGame);
      }
      
      private function sendGetWeeklyData(param1:int) : void
      {
         var_333.offset = param1;
         var_333.revertToDefaultView(_selectedGame);
      }
      
      private function sendGetGroupWeeklyData(param1:int) : void
      {
         var_307.offset = param1;
         var_307.revertToDefaultView(_selectedGame);
      }
      
      private function sendGetFriendsWeeklyData(param1:int) : void
      {
         var_362.offset = param1;
         var_362.revertToDefaultView(_selectedGame);
      }
      
      private function get visible() : Boolean
      {
         return _window && _window.visible;
      }
      
      private function set visible(param1:Boolean) : void
      {
         if(param1 && !_window)
         {
            createMainWindow();
         }
         if(param1)
         {
            _window.visible = true;
            _window.activate();
         }
         else if(_window)
         {
            _window.visible = false;
         }
      }
      
      private function createMainWindow() : void
      {
         if(!_window)
         {
            _window = WindowUtils.createWindow("snowwar_leaderboard",1) as class_1812;
            _window.center();
            _window.findChildByTag("close").addEventListener("WME_CLICK",onClose);
            var_121 = _window.findChildByName("list") as IItemListWindow;
            _listBorder = _window.findChildByName("listBorder");
            var_3383 = _window.findChildByName("changeView") as ITextLinkWindow;
            var_3383.addEventListener("WME_CLICK",onChangeView);
            var_3332 = _window.findChildByName("changeGroupView") as ITextLinkWindow;
            var_3332.addEventListener("WME_CLICK",onChangeGroupView);
            var_3276 = _window.findChildByName("changeFriendsView") as ITextLinkWindow;
            var_3276.addEventListener("WME_CLICK",onChangeFriendsView);
            var _loc2_:class_1741 = _window.findChildByName("all_time_region");
            null.addEventListener("WME_DOWN",onAllTimeButtonDown);
            var _loc1_:class_1741 = _window.findChildByName("this_week_region");
            null.addEventListener("WME_DOWN",onThisWeekButtonDown);
            var_2483 = _window.findChildByName("all_time_image") as class_2251;
            var_2569 = _window.findChildByName("this_week_image") as class_2251;
            var_2386 = _window.findChildByName("all_time_text") as ITextWindow;
            var_1556 = _window.findChildByName("this_week_text") as ITextWindow;
            var_1396 = _window.findChildByName("scrollUp") as IRegionWindow;
            addScrollButtonEventListeners(var_1396);
            WindowUtils.setElementImage(var_1396.getChildAt(0),getBitmap("scroll_up_normal"));
            var_1974 = _window.findChildByName("scrollDown") as IRegionWindow;
            addScrollButtonEventListeners(var_1974);
            WindowUtils.setElementImage(var_1974.getChildAt(0),getBitmap("scroll_down_normal"));
            _nextWeek = _window.findChildByName("nextWeek") as IRegionWindow;
            _nextWeek.addEventListener("WME_CLICK",onNextWeekButton);
            _nextWeek.visible = false;
            _previousWeek = _window.findChildByName("previousWeek") as IRegionWindow;
            _previousWeek.addEventListener("WME_CLICK",onPreviousWeekButton);
            _previousWeek.visible = false;
            updateScrollButtons();
            updateWeekSelection();
         }
      }
      
      private function addScrollButtonEventListeners(param1:class_1741) : void
      {
         param1.addEventListener("WME_CLICK",onScrollButton);
         param1.addEventListener("WME_OVER",onScrollButton);
         param1.addEventListener("WME_OUT",onScrollButton);
         param1.addEventListener("WME_DOWN",onScrollButton);
         param1.addEventListener("WME_UP",onScrollButton);
      }
      
      private function onClose(param1:WindowMouseEvent) : void
      {
         hide();
      }
      
      private function onChangeView(param1:WindowMouseEvent) : void
      {
         switch(var_61 - 1)
         {
            case 0:
               showAllTime();
               break;
            case 1:
               showWeekly();
               break;
            default:
               var_61 = 2;
               showWeekly();
         }
      }
      
      private function onChangeFriendsView(param1:WindowMouseEvent) : void
      {
         switch(var_61)
         {
            case 0:
               showFriendsAllTime();
               break;
            case 3:
               showFriendsWeekly();
               break;
            default:
               var_61 = 3;
               showFriendsWeekly();
         }
      }
      
      private function onChangeGroupView(param1:WindowMouseEvent) : void
      {
         switch(var_61 - 4)
         {
            case 0:
               showGroupWeekly();
               break;
            case 1:
               showGroupAllTime();
               break;
            default:
               var_61 = 4;
               showGroupWeekly();
         }
      }
      
      private function onAllTimeButtonDown(param1:WindowMouseEvent) : void
      {
         switch(var_61 - 2)
         {
            case 0:
               showAllTime();
               break;
            case 1:
               showFriendsAllTime();
               break;
            case 2:
               showGroupAllTime();
         }
      }
      
      private function onThisWeekButtonDown(param1:WindowMouseEvent) : void
      {
         switch(var_61)
         {
            case 0:
               showFriendsWeekly();
               break;
            case 1:
               showWeekly();
               break;
            case 5:
               showGroupWeekly();
         }
      }
      
      private function getCurrentLeaderboard() : LeaderboardTable
      {
         var _loc1_:LeaderboardTable = null;
         switch(var_61)
         {
            case 0:
               _loc1_ = var_833;
               break;
            case 1:
               _loc1_ = var_1128;
               break;
            case 2:
               _loc1_ = var_333;
               break;
            case 3:
               _loc1_ = var_362;
               break;
            case 4:
               _loc1_ = var_307;
               break;
            case 5:
               _loc1_ = var_985;
               break;
            default:
               HabboGamesCom.log("Invalid state " + var_61);
         }
         return _loc1_;
      }
      
      private function onScrollUp() : void
      {
         var _loc1_:LeaderboardTable = getCurrentLeaderboard();
         if(_loc1_ && _loc1_.scrollUp())
         {
            populateList();
         }
      }
      
      private function onScrollDown() : void
      {
         var _loc1_:LeaderboardTable = getCurrentLeaderboard();
         if(_loc1_ && _loc1_.scrollDown())
         {
            populateList();
         }
      }
      
      private function onScrollButton(param1:WindowMouseEvent) : void
      {
         var _loc5_:String = param1.window == var_1396 ? "up" : "down";
         switch(param1.type)
         {
            case "WME_CLICK":
               param1.window == var_1396 ? onScrollUp() : onScrollDown();
               return;
            case "WME_OUT":
               var _loc4_:String = "normal";
               break;
            case "WME_OVER":
               _loc4_ = "hilite";
               break;
            case "WME_DOWN":
               _loc4_ = "click";
               break;
            case "WME_UP":
               _loc4_ = "normal";
         }
         var _loc3_:String = "scroll_" + _loc5_ + "_" + null;
         var _loc2_:class_1812 = param1.window as class_1812;
         WindowUtils.setElementImage(_loc2_.getChildAt(0),getBitmap(_loc3_));
      }
      
      private function onNextWeekButton(param1:WindowMouseEvent) : void
      {
         if(_nextWeek.visible)
         {
            switch(var_61 - 2)
            {
               case 0:
                  sendGetWeeklyData(var_333.offset - 1);
                  break;
               case 1:
                  sendGetFriendsWeeklyData(var_362.offset - 1);
                  break;
               case 2:
                  sendGetGroupWeeklyData(var_307.offset - 1);
            }
         }
      }
      
      private function onPreviousWeekButton(param1:WindowMouseEvent) : void
      {
         if(_previousWeek.visible)
         {
            switch(var_61 - 2)
            {
               case 0:
                  sendGetWeeklyData(var_333.offset + 1);
                  break;
               case 1:
                  sendGetFriendsWeeklyData(var_362.offset + 1);
                  break;
               case 2:
                  sendGetGroupWeeklyData(var_307 + 1);
            }
         }
      }
      
      private function updateWeekSelection() : void
      {
         switch(var_61 - 2)
         {
            case 0:
               _nextWeek.visible = var_333.offset > 0;
               _previousWeek.visible = var_333.offset < var_333.maxOffset;
               break;
            case 1:
               _nextWeek.visible = var_362.offset > 0;
               _previousWeek.visible = var_362.offset < var_362.maxOffset;
               break;
            case 2:
               _nextWeek.visible = var_307.offset > 0;
               _previousWeek.visible = var_307.offset < var_307.maxOffset;
               break;
            default:
               _nextWeek.visible = false;
               _previousWeek.visible = false;
         }
         if(_nextWeek.visible)
         {
            var_1556.caption = var_1408;
         }
         else
         {
            var_1556.caption = "${snowwar.leaderboard.this_week}";
         }
         switch(var_61 - 2)
         {
            case 0:
            case 1:
            case 2:
               if(!_nextWeek.visible)
               {
                  showTimeUntilWeeklyReset();
                  if(var_1118 == null)
                  {
                     startWeeklyResetTimer(_minutesUntilWeeklyReset);
                  }
                  break;
               }
            default:
               WindowUtils.hideElement(_window,"reset_text");
               disposeWeeklyResetTimer();
         }
      }
      
      private function showTimeUntilWeeklyReset() : void
      {
         WindowUtils.showElement(_window,"reset_text");
         var _loc3_:int = convertToDays(_minutesUntilWeeklyReset);
         var _loc1_:int = convertToHours(_minutesUntilWeeklyReset);
         var _loc2_:int = convertToMinutes(_minutesUntilWeeklyReset);
         _localization.registerParameter("snowwar.leaderboard.weekly_reset","days","" + convertToDays(_minutesUntilWeeklyReset));
         _localization.registerParameter("snowwar.leaderboard.weekly_reset","hours","" + convertToHours(_minutesUntilWeeklyReset));
         _localization.registerParameter("snowwar.leaderboard.weekly_reset","minutes","" + convertToMinutes(_minutesUntilWeeklyReset));
         WindowUtils.setCaption(_window.findChildByName("reset_text"),"${" + "snowwar.leaderboard.weekly_reset" + "}");
      }
      
      private function onTick(param1:TimerEvent) : void
      {
         if(!_nextWeek.visible && (var_61 == 2 || var_61 == 3))
         {
            if(_minutesUntilWeeklyReset > 0)
            {
               _minutesUntilWeeklyReset = _minutesUntilWeeklyReset - 1;
            }
            showTimeUntilWeeklyReset();
         }
      }
      
      private function convertToDays(param1:int) : int
      {
         return Math.floor(param1 / 60 / 24);
      }
      
      private function convertToHours(param1:int) : int
      {
         var _loc2_:int = convertToDays(param1);
         return Math.floor((param1 - _loc2_ * 24 * 60) / 60);
      }
      
      private function convertToMinutes(param1:int) : int
      {
         var _loc3_:int = convertToDays(param1);
         var _loc2_:int = convertToHours(param1);
         return param1 - _loc3_ * 24 * 60 - _loc2_ * 60;
      }
      
      private function getData() : Array
      {
         switch(var_61)
         {
            case 0:
               return var_833.getVisibleEntries();
            case 1:
               return var_1128.getVisibleEntries();
            case 2:
               return var_333.getVisibleEntries();
            case 3:
               return var_362.getVisibleEntries();
            case 4:
               return var_307.getVisibleEntries();
            case 5:
               return var_985.getVisibleEntries();
            default:
               return null;
         }
      }
      
      private function getFavouriteGroupId() : int
      {
         switch(var_61 - 4)
         {
            case 0:
               return var_307.favouriteGroupId;
            case 1:
               return var_985.favouriteGroupId;
            default:
               return -1;
         }
      }
      
      private function populateList() : void
      {
         var _loc8_:class_3963 = null;
         var _loc15_:class_1812 = null;
         var _loc6_:class_1741 = null;
         var _loc7_:int = 0;
         var _loc14_:class_1812 = null;
         var _loc3_:class_1812 = null;
         var _loc4_:Array = getData();
         var _loc10_:int = getFavouriteGroupId();
         var _loc9_:int = var_49.sessionDataManager.userId;
         if(!_loc4_ || _loc4_.length == 0)
         {
            var_121.visible = false;
            _listBorder.visible = false;
            return;
         }
         var _loc5_:int = 0;
         var_121.destroyListItems();
         var _loc12_:class_1812 = WindowUtils.createWindow("snowwar_leaderboard_entry") as class_1812;
         while(_loc5_ < _loc4_.length)
         {
            _loc8_ = _loc4_[_loc5_];
            if(_loc8_)
            {
               _loc15_ = _loc12_.clone() as class_1812;
               _loc15_.findChildByName("rank").caption = _loc8_.rank.toString();
               _loc15_.findChildByName("score").caption = _loc8_.score.toString();
               _loc15_.findChildByName("name").caption = _loc8_.name;
               var _loc11_:* = _loc8_.gender == "g";
               if(_loc11_)
               {
                  setGroupBadgeImage(_loc15_.findChildByName("avatarImage") as class_2251,_loc8_.figure);
               }
               else
               {
                  setAvatarImage(_loc15_.findChildByName("avatarImage") as class_2251,_loc8_.figure,_loc8_.gender);
               }
               var _loc13_:Boolean = var_61 == 1 || var_61 == 5;
               var _loc1_:Boolean = _loc13_ && _loc8_.userId == _loc9_;
               _loc15_.findChildByName("imageRegion").id = _loc8_.userId;
               if(_loc8_.gender == "g")
               {
                  _loc15_.findChildByName("imageRegion").addEventListener("WME_CLICK",onGroupImageRegion);
               }
               else
               {
                  _loc15_.findChildByName("imageRegion").addEventListener("WME_CLICK",onImageRegion);
               }
               var_121.addListItem(_loc15_);
            }
            _loc5_++;
         }
         if(var_61 == 1 || var_61 == 5 || var_61 == 2 || var_61 == 4)
         {
            if(_loc5_ % var_833.viewSize != 0)
            {
               _loc6_ = var_121.getListItemAt(var_121.numListItems - 1);
               _loc7_ = 0;
               while(_loc7_ < _loc5_ % var_833.viewSize - 1)
               {
                  _loc14_ = _loc12_.clone() as class_1812;
                  _loc14_.findChildByName("rank").caption = "";
                  _loc14_.findChildByName("score").caption = "";
                  _loc14_.findChildByName("name").caption = "";
                  _loc14_.findChildByName("highlight").visible = false;
                  _loc14_.findChildByName("divider").visible = false;
                  _loc3_ = var_121.getListItemAt(var_121.numListItems - 1) as class_1812;
                  if(_loc3_)
                  {
                     _loc3_.findChildByName("divider").visible = false;
                  }
                  _loc14_.removeChild(_loc14_.findChildByName("imageRegion"));
                  var_121.addListItem(_loc14_);
                  _loc7_++;
               }
               var_121.addListItem(_loc6_);
            }
         }
         _loc12_.dispose();
         _loc12_ = var_121.getListItemAt(var_121.numListItems - 1) as class_1812;
         if(_loc12_)
         {
            _loc12_.findChildByName("divider").visible = false;
         }
         var_121.visible = true;
         _listBorder.visible = true;
         updateScrollButtons();
         _window.invalidate();
      }
      
      private function setGroupBadgeImage(param1:class_2251, param2:String) : *
      {
         var _loc3_:BitmapData = var_49.sessionDataManager.getGroupBadgeImage(param2);
         if(_loc3_)
         {
            _avatarPlaceholders.remove(param2);
            _avatarPlaceholders.add(param2,param1);
            WindowUtils.setElementImage(param1,_loc3_);
            _loc3_.dispose();
         }
      }
      
      private function setAvatarImage(param1:class_2251, param2:String, param3:String = null) : void
      {
         var _loc4_:BitmapData = null;
         var _loc5_:class_1827 = var_49.avatarManager.createAvatarImage(param2,"h",param3,this);
         if(_loc5_)
         {
            _loc5_.setDirection("full",2);
            _loc4_ = _loc5_.getCroppedImage("head");
            if(_loc5_.isPlaceholder())
            {
               _avatarPlaceholders.remove(param2);
               _avatarPlaceholders.add(param2,param1);
            }
            _loc5_.dispose();
         }
         WindowUtils.setElementImage(param1,_loc4_);
         _loc4_.dispose();
      }
      
      private function onImageRegion(param1:WindowMouseEvent) : void
      {
         var_49.groupsManager.showExtendedProfile(param1.window.id);
      }
      
      private function onGroupImageRegion(param1:WindowMouseEvent) : void
      {
         var_49.groupsManager.showGroupBadgeInfo(false,param1.window.id);
      }
      
      private function updateScrollButtons() : void
      {
         var _loc1_:LeaderboardTable = getCurrentLeaderboard();
         if(_loc1_ && var_4139)
         {
            var_1396.visible = _loc1_.canScrollUp();
            var_1974.visible = _loc1_.canScrollDown();
         }
      }
      
      private function getBitmap(param1:String) : BitmapData
      {
         var _loc2_:IAsset = var_49.assets.getAssetByName(param1);
         if(_loc2_)
         {
            return _loc2_.content as BitmapData;
         }
         return null;
      }
   }
}

