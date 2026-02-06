package com.sulake.habbo.friendbar.groupforums
{
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.IScrollableListWindow;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.communication.messages.parser.groupforums.class_3434;
   import com.sulake.habbo.communication.messages.parser.groupforums.class_3591;
   
   public class ThreadListView
   {
      
      private var var_55:GroupForumController;
      
      private var var_172:GroupForumView;
      
      private var var_121:IScrollableListWindow;
      
      private var var_3400:class_1812;
      
      private var var_95:class_3591;
      
      private var var_830:ThreadsListData;
      
      public function ThreadListView(param1:GroupForumView, param2:IScrollableListWindow, param3:class_3591, param4:ThreadsListData)
      {
         super();
         var_172 = param1;
         var_55 = var_172.controller;
         var_121 = param2;
         var_3400 = var_55.windowManager.buildFromXML(XML(new HabboFriendBarCom.groupforum_thread_list_item_xml())) as class_1812;
         var_95 = param3;
         var_830 = param4;
      }
      
      private static function getThreadColor(param1:int, param2:int) : uint
      {
         switch(param1)
         {
            case 10:
               return 4289374890;
            case 20:
               return 4294946981;
            case 0:
            case 1:
            default:
               return (param2 + 1) % 2 ? 4293852927 : 4289914618;
         }
      }
      
      public function update() : void
      {
         var _loc2_:int = 0;
         var _loc1_:class_1812 = null;
         var _loc3_:class_3434 = null;
         var_121.invalidate();
         _loc2_ = 0;
         while(_loc2_ < var_830.size)
         {
            _loc3_ = var_830.threads[_loc2_];
            _loc1_ = var_3400.clone() as class_1812;
            _loc1_.name = "thread_" + _loc3_.threadId;
            updateListItem(_loc1_,_loc3_,_loc2_);
            var_121.addListItem(_loc1_);
            _loc2_++;
         }
         updateItemWidths();
      }
      
      private function updateListItem(param1:class_1812, param2:class_3434, param3:int) : void
      {
         var _loc13_:class_1741 = null;
         var _loc7_:class_1812 = param1 as class_1812;
         var _loc11_:int = param2.state;
         var _loc8_:Boolean = var_95.canModerate;
         var _loc4_:Boolean = var_95.isStaff;
         var _loc6_:Boolean = param2.isSticky;
         var _loc9_:Boolean = param2.isLocked;
         var _loc5_:int = param2.nMessages - var_55.getThreadLastReadMessageIndex(param2.threadId) - 1;
         _loc13_ = _loc7_.findChildByName("texts_container");
         if(_loc13_ != null)
         {
            _loc13_.id = param2.threadId;
            _loc13_.color = getThreadColor(_loc11_,param3);
         }
         var _loc12_:ITextWindow = _loc7_.findChildByName("header") as ITextWindow;
         if(_loc12_ != null)
         {
            _loc12_.bold = _loc5_ > 0;
            var _loc10_:String = param2.header;
            if(param2.header == "")
            {
               _loc10_ = "(No Subject)";
            }
            if(_loc11_ > 1 && !_loc8_ && !_loc4_)
            {
               _loc10_ = getModerationMessage(param2);
            }
            _loc12_.text = null;
         }
         _loc13_ = _loc7_.findChildByName("header_region");
         if(_loc13_ != null)
         {
            _loc13_.id = param2.threadId;
            _loc13_.removeEventListener("WME_CLICK",onGoToFirstUnread);
            _loc13_.addEventListener("WME_CLICK",onGoToFirstUnread);
         }
         _loc13_ = _loc7_.findChildByName("details");
         if(_loc13_ != null)
         {
            _loc13_.caption = var_55.localizationManager.getLocalizationWithParams("groupforum.view.thread_details","","thread_author_id",param2.threadAuthorId,"thread_author_name",param2.threadAuthorName,"last_author_id",param2.lastMessageAuthorId,"last_author_name",param2.lastMessageAuthorName,"creation_time",var_172.getAsDaysHoursMinutes(param2.creationTimeAsSecondsAgo),"update_time",var_172.getAsDaysHoursMinutes(param2.lastMessageTimeAsSecondsAgo));
         }
         _loc13_ = _loc7_.findChildByName("unread_texts_container");
         if(_loc13_ != null)
         {
            _loc13_.id = param2.threadId;
            _loc13_.color = getThreadColor(_loc11_,param3);
         }
         _loc13_ = _loc7_.findChildByName("unread_region");
         if(_loc13_ != null)
         {
            _loc13_.id = param2.threadId;
            _loc13_.removeEventListener("WME_CLICK",onGoToFirstUnread);
            _loc13_.addEventListener("WME_CLICK",onGoToFirstUnread);
         }
         _loc12_ = _loc7_.findChildByName("messages1") as ITextWindow;
         if(_loc12_ != null)
         {
            _loc12_.bold = _loc5_ > 0;
            _loc12_.text = var_55.localizationManager.getLocalizationWithParams("groupforum.view.thread_details1","","total_messages",param2.nMessages,"new_messages",_loc5_);
         }
         _loc12_ = _loc7_.findChildByName("messages2") as ITextWindow;
         if(_loc12_ != null)
         {
            _loc12_.bold = _loc5_ > 0;
            _loc12_.text = var_55.localizationManager.getLocalizationWithParams("groupforum.view.thread_details2","","total_messages",param2.nMessages,"new_messages",_loc5_);
         }
         _loc13_ = _loc7_.findChildByName("button_container");
         if(_loc13_ != null)
         {
            _loc13_.id = param2.threadId;
            _loc13_.color = getThreadColor(_loc11_,param3);
            handleButtonVisibility(_loc13_ as class_1812,param2,_loc11_);
            _loc13_.color = getThreadColor(_loc11_,param3);
         }
         _loc13_ = _loc7_.findChildByName("left_button_container");
         if(_loc13_ != null)
         {
            _loc13_.id = param2.threadId;
            _loc13_.color = getThreadColor(_loc11_,param3);
            handleLeftButtonsVisibility(_loc13_ as class_1812,param2,_loc9_,_loc6_);
            _loc13_.color = getThreadColor(_loc11_,param3);
         }
      }
      
      public function updateItemWidths() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < var_121.numListItems)
         {
            var_121.getListItemAt(_loc1_).width = var_121.scrollableWindow.width - 2;
            _loc1_++;
         }
      }
      
      private function handleButtonVisibility(param1:class_1812, param2:class_3434, param3:int) : void
      {
         var _loc9_:IRegionWindow = null;
         var _loc7_:IStaticBitmapWrapperWindow = null;
         var _loc6_:Boolean = var_95.canModerate;
         var _loc5_:Boolean = var_95.isStaff;
         var _loc4_:Boolean = var_95.canReport;
         var _loc8_:IItemListWindow = param1.findChildByName("mod_buttons") as IItemListWindow;
         _loc9_ = _loc8_.getListItemAt(0) as IRegionWindow;
         if(_loc9_ != null)
         {
            _loc9_.removeEventListener("WME_CLICK",onDelete);
            _loc9_.removeEventListener("WME_CLICK",onUndelete);
            if(_loc6_ || _loc5_)
            {
               _loc9_.id = param2.threadId;
               _loc7_ = _loc9_.getChildByName("icon") as IStaticBitmapWrapperWindow;
               switch(param3)
               {
                  case 0:
                  case 1:
                     _loc9_.addEventListener("WME_CLICK",onDelete);
                     _loc7_.assetUri = "forum_forum_hide";
                     break;
                  case 10:
                     _loc9_.addEventListener("WME_CLICK",onUndelete);
                     _loc7_.assetUri = "forum_forum_unhide";
                     break;
                  case 20:
                     if(_loc5_)
                     {
                        _loc9_.addEventListener("WME_CLICK",onUndelete);
                        _loc7_.assetUri = "forum_forum_unhide";
                        break;
                     }
                     _loc9_.visible = false;
               }
            }
            else
            {
               _loc9_.visible = false;
            }
         }
         _loc9_ = _loc8_.getListItemAt(1) as IRegionWindow;
         if(_loc9_ != null)
         {
            _loc9_.removeEventListener("WME_CLICK",onReport);
            if(_loc6_ || _loc5_ || _loc4_)
            {
               _loc9_.id = param2.threadId;
               _loc9_.addEventListener("WME_CLICK",onReport);
            }
            else
            {
               _loc9_.visible = false;
            }
         }
      }
      
      private function handleLeftButtonsVisibility(param1:class_1812, param2:class_3434, param3:Boolean, param4:Boolean) : void
      {
         var _loc8_:IStaticBitmapWrapperWindow = null;
         var _loc6_:IStaticBitmapWrapperWindow = null;
         var _loc10_:Boolean = var_95.canModerate;
         var _loc9_:Boolean = var_95.isStaff;
         var _loc11_:IItemListWindow = param1.findChildByName("info_buttons") as IItemListWindow;
         var _loc7_:IRegionWindow = _loc11_.getListItemByName("thread_lock") as IRegionWindow;
         if(_loc7_ != null)
         {
            _loc7_.removeEventListener("WME_CLICK",onToggleLock);
            _loc8_ = _loc7_.getChildByName("icon") as IStaticBitmapWrapperWindow;
            if(_loc10_ || _loc9_)
            {
               _loc7_.id = param2.threadId;
               _loc7_.addEventListener("WME_CLICK",onToggleLock);
               if(param3)
               {
                  _loc8_.assetUri = "forum_forum_locked";
               }
               else
               {
                  _loc8_.assetUri = "forum_forum_unlocked";
               }
               _loc7_.visible = true;
            }
            else
            {
               if(param3)
               {
                  _loc8_.assetUri = "forum_forum_locked";
               }
               _loc7_.visible = param3;
               _loc7_.disable();
            }
         }
         var _loc5_:IRegionWindow = _loc11_.getListItemByName("thread_pin") as IRegionWindow;
         if(_loc5_ != null)
         {
            _loc5_.removeEventListener("WME_CLICK",onToggleSticky);
            _loc6_ = _loc5_.getChildByName("icon") as IStaticBitmapWrapperWindow;
            if(_loc10_ || _loc9_)
            {
               _loc5_.id = param2.threadId;
               _loc5_.addEventListener("WME_CLICK",onToggleSticky);
               if(param4)
               {
                  _loc6_.assetUri = "forum_forum_pinned";
               }
               else
               {
                  _loc6_.assetUri = "forum_forum_unpinned";
               }
               _loc5_.visible = true;
            }
            else
            {
               if(param4)
               {
                  _loc6_.assetUri = "forum_forum_pinned";
               }
               _loc5_.visible = param4;
               _loc5_.disable();
            }
         }
      }
      
      private function getModerationMessage(param1:class_3434) : String
      {
         switch(param1.state)
         {
            case 10:
               var _loc2_:String = var_55.localizationManager.getLocalizationWithParams("groupforum.view.thread_hidden_by_admin","","admin_name",param1.adminName);
               break;
            case 20:
               _loc2_ = var_55.localizationManager.getLocalizationWithParams("groupforum.view.thread_hidden_by_staff","","admin_name",param1.adminName);
               break;
            case 0:
            case 1:
         }
         return null;
      }
      
      public function updateElement(param1:class_3434) : void
      {
         var _loc3_:int = param1.threadId;
         var _loc2_:class_1812 = var_121.getListItemByName("thread_" + _loc3_) as class_1812;
         var _loc4_:int = int(var_121.getListItemIndex(_loc2_));
         if(_loc2_ != null)
         {
            updateListItem(_loc2_,param1,_loc4_);
         }
      }
      
      private function onToggleLock(param1:WindowMouseEvent) : void
      {
         var _loc2_:int = param1.target.id;
         var _loc3_:class_3434 = var_830.threadsById[_loc2_];
         if(_loc3_ == null)
         {
            return;
         }
         var_55.lockThread(var_95,_loc2_,!_loc3_.isLocked,_loc3_.isSticky);
      }
      
      private function onToggleSticky(param1:WindowMouseEvent) : void
      {
         var _loc2_:int = param1.target.id;
         var _loc3_:class_3434 = var_830.threadsById[_loc2_];
         if(_loc3_ == null)
         {
            return;
         }
         var_55.stickThread(var_95,_loc2_,_loc3_.isLocked,!_loc3_.isSticky);
      }
      
      private function onReport(param1:WindowMouseEvent) : void
      {
         var_55.reportThread(var_95,param1.target.id);
      }
      
      private function onDelete(param1:WindowMouseEvent) : void
      {
         var_55.deleteThread(var_95,param1.target.id);
      }
      
      private function onUndelete(param1:WindowMouseEvent) : void
      {
         var_55.unDeleteThread(var_95,param1.target.id);
      }
      
      private function onGoToFirstUnread(param1:WindowMouseEvent) : void
      {
         var _loc2_:int = param1.target.id;
         var _loc4_:class_3434 = var_830.threadsById[_loc2_];
         if(_loc4_)
         {
            var _loc3_:int = Math.min(var_55.getThreadLastReadMessageIndex(_loc2_) + 1,_loc4_.nMessages - 1);
            var_55.goToMessageIndex(var_95.groupId,_loc2_,0);
         }
      }
   }
}

