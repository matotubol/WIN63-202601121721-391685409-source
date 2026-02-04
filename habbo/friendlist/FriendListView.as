package com.sulake.habbo.friendlist
{
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_2250;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.events.class_1758;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   
   public class FriendListView
   {
      
      private static const MIN_LEFT_MARGIN:int = 110;
      
      private static const const_332:int = 1;
      
      private static const DEFAULT_LOCATION:Point = new Point(110,50);
      
      private var _friendList:HabboFriendList;
      
      private var var_3798:FriendListTabsView;
      
      private var var_30:class_2250;
      
      private var var_4329:class_1812;
      
      private var _footer:class_1812;
      
      private var var_2864:ITextWindow;
      
      private var var_1319:int = -1;
      
      private var _lastWindowWidth:int = -1;
      
      private var _ignoreResizeEvents:Boolean;
      
      public function FriendListView(param1:HabboFriendList)
      {
         super();
         _friendList = param1;
         var_3798 = new FriendListTabsView(_friendList);
      }
      
      public function openFriendList() : void
      {
         if(var_30 == null)
         {
            prepare();
            var_30.position = DEFAULT_LOCATION;
         }
         else
         {
            var_30.visible = true;
            var_30.activate();
         }
      }
      
      public function showInfo(param1:class_1758, param2:String) : void
      {
         var _loc3_:WindowMouseEvent = param1 as WindowMouseEvent;
         if(_loc3_ == null)
         {
            return;
         }
         if(_loc3_.type == "WME_OUT")
         {
            var_2864.text = "";
         }
         else if(_loc3_.type == "WME_OVER")
         {
            var_2864.text = param2;
         }
      }
      
      public function refresh(param1:String) : void
      {
         if(this.var_30 == null)
         {
            return;
         }
         var_3798.refresh(param1);
         refreshWindowSize();
      }
      
      public function close() : void
      {
         if(this.var_30 != null)
         {
            this.var_30.visible = false;
         }
      }
      
      public function isOpen() : Boolean
      {
         return var_30 && var_30.visible;
      }
      
      private function prepare() : void
      {
         var_30 = class_2250(_friendList.getXmlWindow("main_window"));
         var_30.findChildByTag("close").procedure = onWindowClose;
         var_4329 = class_1812(var_30.content.findChildByName("main_content"));
         _footer = class_1812(var_30.content.findChildByName("footer"));
         var_3798.prepare(var_4329);
         var_30.procedure = onWindow;
         var_30.content.setParamFlag(3072,false);
         var_30.content.setParamFlag(0,true);
         var_30.header.setParamFlag(192,false);
         var_30.header.setParamFlag(0,true);
         var_30.content.setParamFlag(192,false);
         var_30.content.setParamFlag(0,true);
         var _loc1_:Boolean = _friendList.getBoolean("friendship.category.management.enabled");
         if(_loc1_ && _friendList.getInteger("spaweb",0) != 1)
         {
            var_30.findChildByName("open_edit_ctgs_but").procedure = onEditCategoriesButtonClick;
         }
         else
         {
            var_30.findChildByName("open_edit_ctgs_but").visible = false;
         }
         var_2864 = ITextWindow(var_30.findChildByName("info_text"));
         var_2864.text = "";
         _friendList.refreshButton(var_30,"open_edit_ctgs",true,null,0);
         refresh("prepare");
         var_30.height = 350;
         var_30.width = 230;
      }
      
      private function onWindowClose(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         class_21.log("Close window");
         var_30.visible = false;
         _friendList.trackFriendListEvent("HABBO_FRIENDLIST_TRACKING_EVENT_CLOSED");
         _friendList.categories.view.refreshed();
      }
      
      private function onWindow(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type == "WE_RELOCATE" || param1.type == "WE_RESIZED")
         {
            _friendList.categories.view.refreshed();
         }
         if(param1.type != "WE_RESIZED" || param2 != var_30)
         {
            return;
         }
         if(this._ignoreResizeEvents)
         {
            return;
         }
         var _loc3_:int = var_1319 == -1 ? 0 : var_30.height - var_1319;
         var _loc4_:int = _lastWindowWidth == -1 ? 0 : var_30.width - _lastWindowWidth;
         _friendList.tabs.tabContentHeight = Math.max(100,_friendList.tabs.tabContentHeight + _loc3_);
         _friendList.tabs.windowWidth = Math.max(147,_friendList.tabs.windowWidth + _loc4_);
         refresh("resize: " + _loc3_);
      }
      
      private function refreshWindowSize() : void
      {
         this._ignoreResizeEvents = true;
         _footer.visible = false;
         _footer.y = Util.getLowestPoint(var_30.content);
         _footer.width = _friendList.tabs.windowWidth;
         _footer.visible = true;
         var_30.content.height = Util.getLowestPoint(var_30.content);
         var_30.content.width = _friendList.tabs.windowWidth - 10;
         var_30.header.width = _friendList.tabs.windowWidth - 10;
         var_30.height = var_30.content.height + 30;
         var_30.width = _friendList.tabs.windowWidth;
         this._ignoreResizeEvents = false;
         var_30.scaler.setParamFlag(12288,false);
         var_30.scaler.setParamFlag(12288,this._friendList.tabs.findSelectedTab() != null);
         var_30.scaler.setParamFlag(192,false);
         var_30.scaler.setParamFlag(3072,false);
         var_30.scaler.x = var_30.width - var_30.scaler.width;
         var_30.scaler.y = var_30.height - var_30.scaler.height;
         var_1319 = var_30.height;
         _lastWindowWidth = var_30.width;
         class_21.log("RESIZED: " + _friendList.tabs.windowWidth);
      }
      
      private function onEditCategoriesButtonClick(param1:class_1758, param2:class_1741) : void
      {
         _friendList.view.showInfo(param1,"${friendlist.tip.preferences}");
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         class_21.log("Edit categories clicked");
         var _loc3_:WindowMouseEvent = param1 as WindowMouseEvent;
         _friendList.openHabboWebPage("link.format.friendlist.pref",new Dictionary(),_loc3_.stageX,_loc3_.stageY);
      }
      
      public function get mainWindow() : class_1812
      {
         return var_30;
      }
      
      public function alignBottomLeftTo(param1:Point) : void
      {
         var _loc2_:Point = param1.clone();
         _loc2_.y -= var_30.height;
         var _loc3_:int = int(_friendList.windowManager.getWindowContext(1).getDesktopWindow().width);
         _loc2_.x = Math.min(_loc3_ - var_30.width,_loc2_.x);
         _loc2_.x = Math.max(110,_loc2_.x);
         var_30.position = _loc2_;
      }
   }
}

