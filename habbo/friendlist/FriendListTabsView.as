package com.sulake.habbo.friendlist
{
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_2251;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.friendlist.domain.FriendListTab;
   
   public class FriendListTabsView
   {
      
      private var _friendList:HabboFriendList;
      
      private var _content:class_1812;
      
      public function FriendListTabsView(param1:HabboFriendList)
      {
         super();
         _friendList = param1;
      }
      
      public function prepare(param1:class_1812) : void
      {
         _content = param1;
         refresh("prepare");
      }
      
      public function refresh(param1:String) : void
      {
         var _loc3_:class_1812 = null;
         var _loc4_:int = 0;
         class_21.log("TABS: REFRESH: " + param1);
         _content.width = _friendList.tabs.tabContentWidth;
         _content.findChildByName("bg").width = _friendList.tabs.tabContentWidth;
         var _loc2_:int = 1;
         for each(var _loc5_ in _friendList.tabs.getTabs())
         {
            _loc3_ = _content.getChildByName("flt_" + _loc5_.id) as class_1812;
            if(!isTabVisible(_loc5_.id))
            {
               _loc3_.visible = false;
            }
            else
            {
               _loc3_.visible = true;
               _loc3_.width = _friendList.tabs.tabContentWidth;
               _loc3_.y = _loc2_;
               _loc4_ = refreshHeader(_loc5_,_loc3_);
               refreshTabContent(_loc5_,_loc3_);
               _loc3_.height = _loc4_ + (_loc5_.selected ? _friendList.tabs.tabContentHeight : 0);
               _loc2_ += _loc3_.height;
            }
         }
         _content.height = _loc2_ + 1;
         _content.findChildByName("bg").height = _content.height;
         class_21.log("TABS: REFRESH END");
      }
      
      private function isTabVisible(param1:int) : Boolean
      {
         if(param1 != 2)
         {
            return true;
         }
         return _friendList.friendRequests.requests.length > 0;
      }
      
      private function refreshTabContent(param1:FriendListTab, param2:class_1812) : void
      {
         if(param1.selected)
         {
            if(param1.view == null)
            {
               param1.view = this.getTabContent(param1) as class_1812;
            }
            refreshTabContentDims(param1.view);
            refreshScrollBarVisibility(param1.view);
            param2.addChild(param1.view);
         }
         else if(param1.view != null)
         {
            param2.removeChild(param1.view);
         }
      }
      
      private function refreshHeader(param1:FriendListTab, param2:class_1812) : int
      {
         var _loc3_:class_1812 = param2.getChildByName("header") as class_1812;
         _loc3_.width = _friendList.tabs.tabContentWidth;
         showBgImage(_loc3_,param1.newMessageArrived,"hdr_hilite");
         showBgImage(_loc3_,!param1.newMessageArrived,param1.headerPicName);
         var _loc4_:Boolean = param1.id == 1 && !param1.newMessageArrived;
         class_21.log("TAB " + param1.id + ", " + param1.name + ", " + _loc4_);
         refreshArrowIcon(_loc3_,"arrow_down_black",param1.selected && _loc4_,12);
         refreshArrowIcon(_loc3_,"arrow_right_black",!param1.selected && _loc4_,15);
         refreshArrowIcon(_loc3_,"arrow_down_white",param1.selected && !_loc4_,12);
         refreshArrowIcon(_loc3_,"arrow_right_white",!param1.selected && !_loc4_,15);
         refreshTabText(param1,_loc3_);
         return _loc3_.height;
      }
      
      private function showBgImage(param1:class_1812, param2:Boolean, param3:String) : void
      {
         class_21.log("REFRESHING BG IMAGE: " + param2 + ", " + param3);
         var _loc4_:class_2251 = param1.getChildByName(param3) as class_2251;
         if(!param2)
         {
            if(_loc4_ != null)
            {
               _loc4_.visible = false;
            }
         }
         else
         {
            if(_loc4_.bitmap == null)
            {
               _loc4_.bitmap = _friendList.getButtonImage(param3);
               _loc4_.height = _loc4_.bitmap.height;
               param1.height = _loc4_.bitmap.height;
               _loc4_.procedure = onTabClick;
            }
            _loc4_.width = _friendList.tabs.tabContentWidth;
            _loc4_.visible = true;
         }
      }
      
      private function refreshArrowIcon(param1:class_1812, param2:String, param3:Boolean, param4:int) : void
      {
         _friendList.refreshButton(param1,param2,param3,null,0);
         if(param3)
         {
            var _loc5_:ITextWindow = ITextWindow(param1.findChildByName("caption_text"));
            var _loc6_:class_1741 = class_1741(param1.findChildByName(param2));
            _loc6_.x = null.textWidth + param4;
         }
      }
      
      private function refreshTabText(param1:FriendListTab, param2:class_1812) : void
      {
         var _loc3_:ITextWindow = param2.findChildByName("caption_text") as ITextWindow;
         _loc3_.text = param1.name + " (" + param1.tabView.getEntryCount() + ")";
         _loc3_.textColor = _friendList.laf.getTabTextColor(param1.newMessageArrived,param1.id);
      }
      
      private function onTabClick(param1:class_1758, param2:class_1741) : void
      {
         _friendList.view.showInfo(param1,"${friendlist.tip.tab." + param2.id + "}");
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         class_21.log("TAB CLICKED!");
         var _loc3_:FriendListTab = _friendList.tabs.findTab(param2.id);
         for each(var _loc4_ in _friendList.tabs.getTabs())
         {
            _loc4_.tabView.tabClicked(_loc3_.id);
         }
         _friendList.tabs.toggleSelected(_loc3_);
         _friendList.view.refresh("tabClick");
         if(_loc3_.selected)
         {
            switch(_loc3_.id - 1)
            {
               case 0:
                  _friendList.trackFriendListEvent("HABBO_FRIENDLIST_TRACKING_EVENT_FRIENDS");
                  break;
               case 1:
                  _friendList.trackFriendListEvent("HABBO_FRIENDLIST_TRACKING_EVENT_REQUEST");
                  break;
               case 2:
                  _friendList.trackFriendListEvent("HABBO_FRIENDLIST_TRACKING_EVENT_SEARCH");
            }
         }
         else
         {
            _friendList.trackFriendListEvent("HABBO_FRIENDLIST_TRACKING_EVENT_MINIMZED");
         }
      }
      
      private function getTabContent(param1:FriendListTab) : class_1741
      {
         var _loc2_:class_1812 = class_1812(_friendList.getXmlWindow("tab_content"));
         _loc2_.background = true;
         _loc2_.color = _friendList.laf.getTabBgColor(param1.id);
         _loc2_.addChild(getTabContentFooter(param1));
         var _loc3_:IItemListWindow = IItemListWindow(_loc2_.findChildByName("list_content"));
         _loc3_.color = _friendList.laf.getTabBgColor(param1.id);
         param1.tabView.fillList(_loc3_);
         return _loc2_;
      }
      
      private function refreshTabContentDims(param1:class_1812) : void
      {
         var _loc3_:class_1812 = param1.getChildByName("footer") as class_1812;
         var _loc6_:class_1812 = param1.getChildByName("list") as class_1812;
         var _loc8_:class_1741 = _loc6_.getChildByName("scroller") as class_1741;
         var _loc9_:IItemListWindow = IItemListWindow(_loc6_.getChildByName("list_content"));
         var _loc7_:class_1741 = _loc6_.parent;
         var _loc4_:int = _friendList.tabs.tabContentWidth;
         var _loc5_:int = _friendList.tabs.tabContentHeight;
         _loc7_.height = Math.max(0,_loc5_);
         _loc7_.width = _loc4_;
         var _loc2_:int = Math.max(_loc5_ - _loc6_.y - _loc3_.height,0);
         _loc6_.height = _loc2_;
         _loc8_.height = _loc2_;
         _loc9_.height = _loc2_;
         _loc6_.width = _loc4_;
         _loc9_.width = _loc4_;
         _loc8_.x = _loc4_ - 27;
         _loc3_.y = _loc5_ - _loc3_.height;
         _loc3_.width = _loc4_;
      }
      
      private function refreshScrollBarVisibility(param1:class_1812) : void
      {
         var _loc6_:class_1812 = param1.getChildByName("list") as class_1812;
         var _loc7_:class_1741 = _loc6_.getChildByName("scroller") as class_1741;
         var _loc9_:IItemListWindow = IItemListWindow(_loc6_.getChildByName("list_content"));
         var _loc3_:* = _loc9_.scrollableRegion.height > _loc9_.height;
         var _loc5_:int = _friendList.tabs.tabContentWidth - 10;
         var _loc8_:int = _loc5_ - 22;
         var _loc4_:int = _loc3_ ? _loc8_ : _loc5_;
         _loc7_.visible = _loc3_;
         _loc9_.width = _loc4_;
         change(_loc9_,_loc4_);
      }
      
      private function change(param1:IItemListWindow, param2:int) : void
      {
         var _loc3_:int = 0;
         var _loc4_:class_1741 = null;
         _loc3_ = 0;
         while(_loc3_ < param1.numListItems)
         {
            _loc4_ = param1.getListItemAt(_loc3_);
            _loc4_.width = param2;
            _loc3_++;
         }
      }
      
      private function getTabContentFooter(param1:FriendListTab) : class_1741
      {
         var _loc2_:class_1812 = class_1812(this._friendList.getXmlWindow(param1.footerName));
         param1.tabView.fillFooter(_loc2_);
         return _loc2_;
      }
   }
}

