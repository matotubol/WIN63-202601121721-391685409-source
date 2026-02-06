package com.sulake.habbo.friendbar.groupforums
{
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.ILabelWindow;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.IScrollableListWindow;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_2010;
   import com.sulake.core.window.components.class_2143;
   import com.sulake.core.window.components.class_2250;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.utils.FriendlyTime;
   import com.sulake.habbo.window.widgets.class_3087;
   import com.sulake.habbo.communication.messages.parser.groupforums.class_2670;
   import com.sulake.habbo.communication.messages.parser.groupforums.class_3434;
   import com.sulake.habbo.communication.messages.parser.groupforums.class_3590;
   import com.sulake.habbo.communication.messages.parser.groupforums.class_3591;
   
   public class GroupForumView
   {
      
      private static const const_451:int = 100;
      
      private var var_55:GroupForumController;
      
      private var var_911:ForumsListView;
      
      private var var_698:ThreadListView;
      
      private var var_603:MessageListView;
      
      private var _window:class_2250;
      
      private var var_1870:IScrollableListWindow;
      
      private var var_3809:class_1741;
      
      private var var_3787:class_1741;
      
      private var var_3772:class_1741;
      
      private var var_3724:class_1741;
      
      private var _txtElement:class_1741;
      
      private var var_1690:class_2143;
      
      private var var_800:class_2143;
      
      private var var_4174:class_1741;
      
      private var var_3017:class_1741;
      
      private var var_3485:ITextWindow;
      
      private var var_410:ForumsListData;
      
      private var var_95:class_3591;
      
      private var var_830:ThreadsListData;
      
      private var var_1459:MessagesListData;
      
      private var var_292:int = 1;
      
      private var var_845:int = 1;
      
      private var var_3774:int;
      
      public function GroupForumView(param1:GroupForumController)
      {
         super();
         var_55 = param1;
         var_3774 = 20;
      }
      
      private static function enable(param1:class_1741, param2:Boolean) : void
      {
         if(param2)
         {
            param1.enable();
         }
         else
         {
            param1.disable();
         }
      }
      
      internal static function initTopAreaForForum(param1:class_2250, param2:class_3590) : IRegionWindow
      {
         var _loc4_:class_1812 = param1.findChildByName("top_part") as class_1812;
         var _loc6_:class_2010 = class_2010(_loc4_.findChildByName("group_icon"));
         _loc6_.visible = true;
         var _loc3_:class_3087 = _loc6_.widget as class_3087;
         _loc3_.badgeId = param2.icon;
         _loc3_.groupId = param2.groupId;
         _loc3_.type = "group";
         var _loc8_:IStaticBitmapWrapperWindow = _loc4_.findChildByName("header_icon") as IStaticBitmapWrapperWindow;
         if(_loc8_ != null)
         {
            _loc8_.visible = false;
         }
         var _loc7_:ITextWindow = _loc4_.findChildByName("top_header_text") as ITextWindow;
         _loc7_.text = param2.name;
         var _loc5_:ITextWindow = _loc4_.findChildByName("top_text") as ITextWindow;
         _loc5_.text = param2.description;
         return _loc4_.findChildByName("top_click_area") as IRegionWindow;
      }
      
      public function dispose() : void
      {
         if(var_55)
         {
            var_55.closeMainView();
         }
         if(_window != null)
         {
            _window.removeEventListener("click",onClickButton);
            _window.dispose();
            _window = null;
            var_55 = null;
         }
      }
      
      private function initCommonControls() : void
      {
         var _loc2_:class_1741 = _window.findChildByName("settings_button");
         if(var_95 != null && var_95.canChangeSettings)
         {
            _loc2_.removeEventListener("WME_CLICK",onSettingsButtonClick);
            _loc2_.addEventListener("WME_CLICK",onSettingsButtonClick);
            _loc2_.visible = true;
         }
         else
         {
            _loc2_.visible = false;
         }
         var _loc1_:ILabelWindow = var_1690.findChildByName("back_button_label") as ILabelWindow;
         if(var_698 != null)
         {
            var_1690.visible = true;
            _loc1_.text = var_55.localizationManager.getLocalization("groupforum.view.mark_read");
         }
         else if(var_603 != null)
         {
            var_1690.visible = true;
            _loc1_.text = var_55.localizationManager.getLocalization("groupforum.view.back");
         }
         else if(var_911 != null)
         {
            var_1690.visible = true;
            _loc1_.text = var_55.localizationManager.getLocalization("groupforum.view.mark_read");
         }
         else
         {
            var_1690.visible = false;
         }
         var _loc3_:ILabelWindow = var_800.findChildByName("post_button_label") as ILabelWindow;
         if(var_698 != null)
         {
            var_800.visible = true;
            _loc3_.text = var_55.localizationManager.getLocalization("groupforum.view.start_thread");
         }
         else if(var_603 != null)
         {
            var_800.visible = true;
            _loc3_.text = var_55.localizationManager.getLocalization("groupforum.view.reply");
         }
         else
         {
            var_800.visible = false;
         }
         var _loc4_:int = var_292 + 1;
         _txtElement.caption = _loc4_ + " / " + var_845;
         _window.scaler.enable();
         _window.scaler.visible = true;
         enable(var_3772,var_292 > 0);
         enable(var_3809,var_292 > 0);
         enable(var_3787,var_292 < var_845 - 1);
         enable(var_3724,var_292 < var_845 - 1);
         updateUnreadForumsCount(var_55.unreadForumsCount);
      }
      
      private function resetWindow() : void
      {
         if(_window != null)
         {
            var_1870.destroyListItems();
            var_911 = null;
            var_698 = null;
            var_603 = null;
         }
         else
         {
            _window = var_55.windowManager.buildFromXML(XML(new HabboFriendBarCom.groupforum_main_view_xml())) as class_2250;
            var_1870 = _window.findChildByName("scrollable_message_list") as IScrollableListWindow;
            var_1870.scrollableWindow.addEventListener("WE_RESIZED",onResized,100);
            _window.center();
            _window.y = 100;
            _txtElement = _window.findChildByName("page_info");
            var_3809 = _window.findChildByName("show_previous");
            var_3809.addEventListener("WME_CLICK",onClickButton);
            var_3787 = _window.findChildByName("show_next");
            var_3787.addEventListener("WME_CLICK",onClickButton);
            var_3724 = _window.findChildByName("show_last");
            var_3724.addEventListener("WME_CLICK",onClickButton);
            var_3772 = _window.findChildByName("show_first");
            var_3772.addEventListener("WME_CLICK",onClickButton);
            var_1690 = class_2143(_window.findChildByName("back_button"));
            var_1690.addEventListener("WME_CLICK",onClickButton);
            var_800 = class_2143(_window.findChildByName("post_button"));
            var_800.addEventListener("WME_CLICK",onClickButton);
            var_4174 = _window.findChildByTag("close");
            var_4174.addEventListener("WME_CLICK",onClickButton);
            var_3017 = _window.findChildByName("list_header");
            var_3485 = ITextWindow(IItemListWindow(_window.findChildByName("shortcuts")).getListItemByName("my"));
         }
      }
      
      private function setStatusTextError(param1:String, param2:String) : void
      {
         var _loc3_:ITextWindow = ITextWindow(_window.findChildByName("status"));
         if(param2 == null || param2.length == 0)
         {
            _loc3_.caption = "";
         }
         else
         {
            param1 = var_55.localizationManager.getLocalization("groupforum.view.error.operation_" + param1);
            _loc3_.text = var_55.localizationManager.getLocalizationWithParams("groupforum.view.error." + param2,"","operation",param1);
         }
      }
      
      private function onSettingsButtonClick(param1:WindowMouseEvent) : void
      {
         openForumSettingsView();
      }
      
      private function onTopAreaClick(param1:WindowMouseEvent) : void
      {
         if(var_95 != null)
         {
            var_55.context.createLinkEvent("group/" + var_95.groupId);
         }
      }
      
      public function openForumsList(param1:ForumsListData) : void
      {
         resetWindow();
         var_410 = param1;
         var_95 = null;
         var_830 = null;
         var_1459 = null;
         var_845 = calculateNumOfPagesAvailable(var_410.totalAmount);
         var_292 = Math.ceil(var_410.startIndex / 20);
         var_911 = new ForumsListView(this,var_1870,var_410.forums);
         var_911.update();
         var_3017.caption = var_55.localizationManager.getLocalization("groupforum.view.forums_list." + var_410.listCode);
         var _loc3_:class_1812 = _window.findChildByName("top_part") as class_1812;
         var _loc6_:class_2010 = class_2010(_loc3_.findChildByName("group_icon"));
         _loc6_.visible = false;
         var _loc8_:IStaticBitmapWrapperWindow = _loc3_.findChildByName("header_icon") as IStaticBitmapWrapperWindow;
         _loc8_.visible = true;
         _loc8_.assetUri = "forum_forum_list" + var_410.listCode;
         var _loc7_:ITextWindow = _loc3_.findChildByName("top_header_text") as ITextWindow;
         _loc7_.text = var_55.localizationManager.getLocalization("groupforum.view.forums_header." + var_410.listCode);
         var _loc4_:ITextWindow = _loc3_.findChildByName("top_text") as ITextWindow;
         _loc4_.text = var_55.localizationManager.getLocalization("groupforum.view.forums_description." + var_410.listCode);
         var _loc2_:IRegionWindow = _loc3_.findChildByName("top_click_area") as IRegionWindow;
         _loc2_.removeEventListener("WME_CLICK",onTopAreaClick);
         _loc2_.disable();
         initCommonControls();
         var _loc5_:ITextWindow = ITextWindow(_window.findChildByName("status"));
         _loc5_.text = var_55.localizationManager.getLocalization("groupforum.view.forums_list.status");
      }
      
      public function get isForumsListOpened() : Boolean
      {
         return var_911 != null;
      }
      
      public function openThreadList(param1:ForumsListData, param2:class_3591, param3:ThreadsListData) : void
      {
         resetWindow();
         var_410 = param1;
         var_95 = param2;
         var_830 = param3;
         var_1459 = null;
         var_845 = calculateNumOfPagesAvailable(var_830.totalThreads);
         var_292 = Math.ceil(var_830.startIndex / 20);
         var_698 = new ThreadListView(this,var_1870,var_95,var_830);
         var_698.update();
         var_3017.caption = var_55.localizationManager.getLocalization("groupforum.view.all_threads");
         if(var_95.canPostThread)
         {
            var_800.enable();
            setStatusTextError("post_thread",null);
         }
         else
         {
            var_800.disable();
            setStatusTextError("post_thread",var_95.postThreadPermissionError);
         }
         var _loc4_:IRegionWindow = GroupForumView.initTopAreaForForum(_window,var_95);
         _loc4_.removeEventListener("WME_CLICK",onTopAreaClick);
         _loc4_.addEventListener("WME_CLICK",onTopAreaClick);
         _loc4_.enable();
         initCommonControls();
      }
      
      public function updateThread(param1:class_3434) : void
      {
         if(var_698 != null)
         {
            var_698.updateElement(param1);
         }
      }
      
      public function updateMessage(param1:class_2670) : void
      {
         if(var_603 != null)
         {
            var_603.updateElement(param1);
         }
      }
      
      public function openMessagesList(param1:ForumsListData, param2:class_3591, param3:ThreadsListData, param4:MessagesListData) : void
      {
         resetWindow();
         var_410 = param1;
         var_95 = param2;
         var_830 = param3;
         var_1459 = param4;
         var _loc7_:int = param4.threadId;
         var _loc5_:class_3434 = var_830.threadsById[_loc7_];
         var_845 = calculateNumOfPagesAvailable(param4.totalMessages);
         var _loc8_:int = param4.startIndex;
         var_292 = Math.ceil(_loc8_ / 20);
         var_3017.caption = _loc5_.header;
         var_603 = new MessageListView(this,var_1870,var_95,_loc5_,param4);
         var_603.update();
         if(var_55.getGoToMessageIndex() > 0 && var_55.getGoToThreadId() == _loc7_)
         {
            var_603.scrollToSpecificElement(var_55.getGoToMessageIndex(),true);
            var_55.resetGoTo();
         }
         if(var_95.canPostMessage)
         {
            if(var_95.canModerate || !_loc5_.isLocked)
            {
               var_800.enable();
               setStatusTextError("post_message",null);
            }
            else
            {
               var_800.disable();
               setStatusTextError("post_in_locked",var_95.moderatePermissionError);
            }
         }
         else
         {
            var_800.disable();
            setStatusTextError("post_message",var_95.postMessagePermissionError);
         }
         var _loc6_:IRegionWindow = GroupForumView.initTopAreaForForum(_window,var_95);
         _loc6_.removeEventListener("WME_CLICK",onTopAreaClick);
         _loc6_.addEventListener("WME_CLICK",onTopAreaClick);
         _loc6_.enable();
         initCommonControls();
      }
      
      public function get controller() : GroupForumController
      {
         return var_55;
      }
      
      private function calculateNumOfPagesAvailable(param1:int) : int
      {
         return Math.ceil(param1 / var_3774);
      }
      
      private function getPreviousPageData() : void
      {
         var _loc1_:int = var_292 - 1;
         if(_loc1_ >= 0)
         {
            requestNewPageData(_loc1_);
         }
      }
      
      private function getNextPageData() : void
      {
         var _loc1_:int = var_292 + 1;
         if(_loc1_ <= var_845)
         {
            requestNewPageData(_loc1_);
         }
      }
      
      private function getFirstPageData() : void
      {
         if(var_292 == 0)
         {
            return;
         }
         requestNewPageData(0);
      }
      
      private function getLastPageData() : void
      {
         if(var_292 >= var_845)
         {
            return;
         }
         requestNewPageData(var_845 - 1);
      }
      
      private function requestNewPageData(param1:int) : void
      {
         var _loc2_:int = param1 * var_3774;
         if(var_911 != null)
         {
            var_55.openForumsList(var_410.listCode,_loc2_);
         }
         else if(var_698 != null)
         {
            var_55.requestThreadList(var_95.groupId,_loc2_);
         }
         else if(var_603 != null)
         {
            var_55.requestThreadMessageList(var_95.groupId,var_1459.threadId,_loc2_);
         }
         var_292 = param1;
      }
      
      public function getAsDaysHoursMinutes(param1:int) : String
      {
         return FriendlyTime.getFriendlyTime(var_55.localizationManager,param1,".ago",1);
      }
      
      private function onResized(param1:class_1758 = null) : void
      {
         if(var_911 != null)
         {
            var_911.updateItemWidths();
         }
         if(var_698 != null)
         {
            var_698.updateItemWidths();
         }
         if(var_603 != null)
         {
            var_603.updateItemSizes();
         }
      }
      
      private function onClickButton(param1:WindowMouseEvent) : void
      {
         switch(param1.target.name)
         {
            case "back_button":
               if(var_603 != null)
               {
                  var_55.requestThreadList(var_95.groupId,var_830.startIndex);
                  break;
               }
               if(var_698 != null)
               {
                  var_55.markForumAsRead(true);
                  if(var_410 != null)
                  {
                     var_55.openForumsList(var_410.listCode,var_410.startIndex);
                     break;
                  }
                  dispose();
                  break;
               }
               if(var_911 != null)
               {
                  var_55.markForumsAsRead();
                  dispose();
               }
               break;
            case "show_previous":
               getPreviousPageData();
               break;
            case "show_next":
               getNextPageData();
               break;
            case "show_last":
               getLastPageData();
               break;
            case "show_first":
               getFirstPageData();
               break;
            case "header_button_close":
               _window.visible = false;
               dispose();
               break;
            case "post_button":
               openComposeMessageView(var_1459 != null ? var_830.threadsById[var_1459.threadId] : null);
         }
      }
      
      public function openComposeMessageView(param1:class_3434, param2:class_2670 = null) : void
      {
         if(var_55.composeMessageView != null)
         {
            var_55.composeMessageView.focus(var_95,param1,param2);
         }
         else
         {
            var_55.composeMessageView = new ComposeMessageView(this,_window.x + _window.width,_window.y,var_95,param1,param2);
         }
      }
      
      public function openForumSettingsView() : void
      {
         if(var_55.forumSettingsView != null)
         {
            var_55.forumSettingsView.focus(var_95);
         }
         else
         {
            var_55.forumSettingsView = new ForumSettingsView(this,_window.x + _window.width,_window.y,var_95);
         }
      }
      
      public function updateUnreadForumsCount(param1:int) : void
      {
         if(param1 > 0)
         {
            var_3485.htmlText = var_55.localizationManager.getLocalizationWithParams("groupforum.view.shortcuts.my.unread","","unread_count",param1);
         }
         else
         {
            var_3485.htmlText = var_55.localizationManager.getLocalization("groupforum.view.shortcuts.my","");
         }
      }
   }
}

