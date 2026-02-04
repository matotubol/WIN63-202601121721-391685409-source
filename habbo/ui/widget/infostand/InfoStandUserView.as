package com.sulake.habbo.ui.widget.infostand
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.utils.class_55;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.components.ITextLinkWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_1993;
   import com.sulake.core.window.components.class_2010;
   import com.sulake.core.window.components.class_2251;
   import com.sulake.core.window.events.WindowKeyboardEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.friendlist.class_2242;
   import com.sulake.habbo.tracking.HabboTracking;
   import com.sulake.habbo.ui.widget.events.RoomWidgetUserInfoUpdateEvent;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetChangeMottoMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetGetBadgeDetailsMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetOpenProfileMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetRoomTagSearchMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetUserActionMessage;
   import com.sulake.habbo.window.widgets.class_2478;
   import com.sulake.habbo.window.widgets.class_3087;
   import flash.display.BitmapData;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.getTimer;
   import package_3.class_3604;
   import package_9.class_1879;
   
   public class InfoStandUserView
   {
      
      protected static const LINK_COLOR_ACTIONS_DEFAULT:uint = 16777215;
      
      protected static const LINK_COLOR_ACTIONS_HOVER:uint = 9552639;
      
      protected var var_16:InfoStandWidget;
      
      protected var _window:IItemListWindow;
      
      protected var var_108:IItemListWindow;
      
      protected var var_4455:IItemListWindow;
      
      private var var_31:class_1993;
      
      private var var_1511:TagListRenderer;
      
      private var _badgeDetails:class_1993;
      
      private var var_4687:int;
      
      protected var var_753:IRegionWindow;
      
      private const ITEM_SPACER:int = 5;
      
      private const MOTTO_TEXT_OFFSET:int = 3;
      
      private const MOTTO_EDITED_COLOR:int = 11184810;
      
      private const MOTTO_UNCHANGED_COLOR:int = 16777215;
      
      private const const_1091:int = 2000;
      
      private const MAX_MOTTO_HEIGHT:int = 50;
      
      private const MIN_MOTTO_HEIGHT:int = 23;
      
      private const TOOLTIP_DELAY:int = 100;
      
      public function InfoStandUserView(param1:InfoStandWidget, param2:String)
      {
         super();
         var_16 = param1;
         createWindow(param2);
         var_1511 = new TagListRenderer(param1,onTagSelected);
      }
      
      public function dispose() : void
      {
         if(var_753)
         {
            var_753.dispose();
            var_753 = null;
         }
         var_16 = null;
         _window.dispose();
         _window = null;
         var_1511.dispose();
         var_1511 = null;
         disposeBadgeDetails();
      }
      
      public function get window() : IItemListWindow
      {
         return _window;
      }
      
      protected function updateWindow() : void
      {
         if(var_108 == null || var_31 == null)
         {
            return;
         }
         var_108.height = var_108.scrollableRegion.height;
         var_31.height = var_108.height + 20;
         _window.width = var_31.width;
         _window.height = _window.scrollableRegion.height;
         var_16.refreshContainer();
      }
      
      protected function createWindow(param1:String) : void
      {
         _window = var_16.getXmlWindow("user_view") as IItemListWindow;
         if(_window == null)
         {
            throw new Error("Failed to construct window from XML!");
         }
         var_31 = _window.getListItemByName("info_border") as class_1993;
         if(var_31 != null)
         {
            var_108 = var_31.findChildByName("infostand_element_list") as IItemListWindow;
            var_4455 = var_31.findChildByName("relationship_status_container") as IItemListWindow;
            var_4455.visible = var_16.config.getBoolean("relationship.status.enabled");
            var_31.findChildByName("heart_randomusername").procedure = onRelationshipUserNameLinkClicked;
            var_31.findChildByName("smile_randomusername").procedure = onRelationshipUserNameLinkClicked;
            var_31.findChildByName("bobba_randomusername").procedure = onRelationshipUserNameLinkClicked;
         }
         _window.name = param1;
         var _loc5_:class_2251 = var_31.findChildByName("home_icon") as class_2251;
         if(_loc5_ != null)
         {
            _loc5_.bitmap = new BitmapData(_loc5_.width,_loc5_.height,true,0);
            var _loc8_:BitmapDataAsset = var_16.assets.getAssetByName("icon_home") as BitmapDataAsset;
            var _loc7_:BitmapData = _loc8_.content as BitmapData;
            _loc5_.bitmap = new BitmapData(_loc5_.width,_loc5_.height,true,0);
            _loc5_.bitmap.copyPixels(null,null.rect,new Point(0,0));
            _loc5_.addEventListener("WME_CLICK",onButtonClicked);
         }
         var_16.mainContainer.addChild(_window);
         var _loc4_:class_1741 = var_31.findChildByTag("close");
         if(_loc4_ != null)
         {
            _loc4_.addEventListener("WME_CLICK",onClose);
         }
         var _loc6_:int = 0;
         while(true)
         {
            var _loc3_:class_1741 = var_31.findChildByName("badge_" + 0);
            _loc6_++;
         }
      }
      
      private function selectGroupBadge(param1:WindowMouseEvent) : void
      {
         if(var_16.userData.groupId < 0)
         {
            return;
         }
         var _loc2_:* = var_16.userData.type == "RWUIUE_OWN_USER";
         var _loc3_:RoomWidgetGetBadgeDetailsMessage = new RoomWidgetGetBadgeDetailsMessage(_loc2_,var_16.userData.groupId);
         var_16.messageListener.processWidgetMessage(_loc3_);
      }
      
      private function showGroupBadgeInfo(param1:WindowMouseEvent) : void
      {
         if(var_16.userData.groupId < 0)
         {
            return;
         }
         createBadgeDetails();
         if(param1.window == null)
         {
            return;
         }
         _badgeDetails.findChildByName("name").caption = var_16.userData.groupName;
         var _loc2_:Rectangle = new Rectangle();
         param1.window.getGlobalRectangle(_loc2_);
         _badgeDetails.x = _loc2_.left - _badgeDetails.width;
         _badgeDetails.y = _loc2_.top + (_loc2_.height - _badgeDetails.height) / 2;
      }
      
      private function hideGroupBadgeInfo(param1:WindowMouseEvent) : void
      {
         disposeBadgeDetails();
      }
      
      private function showBadgeInfo(param1:WindowMouseEvent) : void
      {
         var _loc5_:ITextWindow = null;
         if(param1.window == null)
         {
            return;
         }
         var _loc6_:int = int(param1.window.name.replace("badge_",""));
         if(_loc6_ < 0)
         {
            return;
         }
         var _loc2_:Array = var_16.userData.badges;
         if(_loc2_ == null)
         {
            return;
         }
         if(_loc6_ >= _loc2_.length)
         {
            return;
         }
         var _loc3_:String = var_16.userData.badges[_loc6_];
         if(_loc3_ == null)
         {
            return;
         }
         createBadgeDetails();
         _loc5_ = _badgeDetails.getChildByName("name") as ITextWindow;
         if(_loc5_ != null)
         {
            _loc5_.text = var_16.localizations.getBadgeName(_loc3_);
         }
         _loc5_ = _badgeDetails.getChildByName("description") as ITextWindow;
         if(_loc5_ != null)
         {
            _loc5_.text = var_16.localizations.getBadgeDesc(_loc3_);
            _badgeDetails.height = _loc5_.text == "" ? 40 : 99;
         }
         var _loc4_:Rectangle = new Rectangle();
         param1.window.getGlobalRectangle(_loc4_);
         _badgeDetails.x = _loc4_.left - _badgeDetails.width;
         _badgeDetails.y = _loc4_.top + (_loc4_.height - _badgeDetails.height) / 2;
      }
      
      private function hideBadgeInfo(param1:WindowMouseEvent) : void
      {
         disposeBadgeDetails();
      }
      
      private function createBadgeDetails() : void
      {
         if(_badgeDetails != null)
         {
            return;
         }
         var _loc1_:XmlAsset = var_16.assets.getAssetByName("badge_details") as XmlAsset;
         if(_loc1_ == null)
         {
            return;
         }
         _badgeDetails = var_16.windowManager.buildFromXML(_loc1_.content as XML) as class_1993;
         if(_badgeDetails == null)
         {
            throw new Error("Failed to construct window from XML!");
         }
      }
      
      private function disposeBadgeDetails() : void
      {
         if(_badgeDetails != null)
         {
            _badgeDetails.dispose();
            _badgeDetails = null;
         }
      }
      
      private function onClose(param1:WindowMouseEvent) : void
      {
         var_16.close();
      }
      
      public function set name(param1:String) : void
      {
         if(var_753 == null)
         {
            var_753 = var_108.getListItemByName("profile_link") as IRegionWindow;
            if(var_753 == null)
            {
               return;
            }
            var_753.procedure = onProfileLink;
            var_753.visible = true;
         }
         var _loc2_:ITextWindow = var_753.findChildByName("name_text") as ITextWindow;
         if(_loc2_ == null)
         {
            return;
         }
         _loc2_.text = param1;
         _loc2_.visible = true;
      }
      
      public function set realName(param1:String) : void
      {
         var _loc2_:ITextWindow = var_108.getListItemByName("realname_text") as ITextWindow;
         if(_loc2_ == null)
         {
            return;
         }
         if(param1.length == 0)
         {
            _loc2_.text = "";
         }
         else
         {
            var_16.localizations.registerParameter("infostand.text.realname","realname",param1);
            _loc2_.text = var_16.localizations.getLocalization("infostand.text.realname");
         }
         _loc2_.height = _loc2_.textHeight + 5;
         _loc2_.visible = param1.length > 0;
      }
      
      public function setFigure(param1:String) : void
      {
         var _loc2_:class_2478 = class_2010(var_31.findChildByName("avatar_image")).widget as class_2478;
         _loc2_.figure = param1;
      }
      
      public function setMotto(param1:String, param2:Boolean) : void
      {
         var _loc7_:class_1812 = var_108.getListItemByName("motto_container") as class_1812;
         if(!_loc7_)
         {
            return;
         }
         var _loc3_:class_1741 = _loc7_.findChildByName("changemotto.image");
         var _loc6_:ITextWindow = _loc7_.findChildByName("motto_text") as ITextWindow;
         var _loc5_:class_1812 = var_108.getListItemByName("motto_spacer") as class_1812;
         if(_loc6_ == null || _loc5_ == null)
         {
            return;
         }
         if(param1 == null)
         {
            param1 = "";
         }
         if(param2)
         {
            _loc3_.visible = true;
            if(param1 == "")
            {
               param1 = var_16.localizations.getLocalization("infostand.motto.change");
               _loc6_.textColor = 11184810;
            }
            else
            {
               _loc6_.textColor = 16777215;
            }
            _loc6_.enable();
         }
         else
         {
            _loc3_.visible = false;
            _loc6_.textColor = 16777215;
            _loc6_.disable();
         }
         if(!var_16.config.getBoolean("infostand.motto.change.enabled"))
         {
            _loc6_.disable();
         }
         _loc6_.text = param1;
         _loc6_.height = Math.min(_loc6_.textHeight + 5,50);
         _loc6_.height = Math.max(_loc6_.height,23);
         _loc7_.height = _loc6_.height + 3;
         if(param2)
         {
            _loc6_.addEventListener("WKE_KEY_UP",onMottoKeyboard);
            _loc6_.addEventListener("WME_CLICK",onMottoClicked);
         }
         else
         {
            _loc6_.removeEventListener("WKE_KEY_UP",onMottoClicked);
         }
         var _loc4_:Boolean = _loc6_.text && _loc6_.text.toLowerCase().indexOf("crikey") >= 0;
         if(var_31)
         {
            var_31.findChildByName("sticker_croco").visible = _loc4_;
            var_31.findChildByName("avatar_image").visible = !_loc4_;
         }
         updateWindow();
      }
      
      public function set achievementScore(param1:int) : void
      {
         if(!var_16.handler.isActivityDisplayEnabled)
         {
            return;
         }
         var _loc2_:ITextWindow = var_108.getListItemByName("score_value") as ITextWindow;
         if(_loc2_ == null)
         {
            return;
         }
         _loc2_.text = String(param1);
      }
      
      public function set carryItem(param1:int) : void
      {
         var _loc2_:String = null;
         var _loc6_:ITextWindow = var_108.getListItemByName("handitem_txt") as ITextWindow;
         var _loc3_:class_1812 = var_108.getListItemByName("handitem_spacer") as class_1812;
         if(_loc6_ == null || _loc3_ == null)
         {
            return;
         }
         if(param1 > 0 && param1 < 999999)
         {
            _loc2_ = var_16.localizations.getLocalization("handitem" + param1,"handitem" + param1);
            var_16.localizations.registerParameter("infostand.text.handitem","item",_loc2_);
         }
         _loc6_.height = _loc6_.textHeight + 5;
         var _loc4_:Boolean = Boolean(_loc6_.visible);
         var _loc5_:Boolean = param1 > 0 && param1 < 999999;
         _loc6_.visible = _loc5_;
         _loc3_.visible = _loc5_;
         if(_loc5_ != _loc4_)
         {
            var_108.arrangeListItems();
         }
         updateWindow();
      }
      
      public function set xp(param1:int) : void
      {
         var _loc5_:ITextWindow = var_108.getListItemByName("xp_text") as ITextWindow;
         var _loc2_:class_1812 = var_108.getListItemByName("xp_spacer") as class_1812;
         if(_loc5_ == null || _loc2_ == null)
         {
            return;
         }
         var_16.localizations.registerParameter("infostand.text.xp","xp",param1.toString());
         _loc5_.height = _loc5_.textHeight + 5;
         var _loc3_:Boolean = Boolean(_loc5_.visible);
         var _loc4_:* = param1 > 0;
         _loc5_.visible = _loc4_;
         _loc2_.visible = _loc4_;
         if(_loc4_ != _loc3_)
         {
            var_108.arrangeListItems();
         }
         updateWindow();
      }
      
      public function setBadge(param1:int, param2:String) : void
      {
         var _loc3_:class_3087 = class_2010(var_31.findChildByName("badge_" + param1)).widget as class_3087;
         _loc3_.badgeId = param2;
      }
      
      public function clearBadges() : void
      {
         var _loc2_:int = 0;
         var _loc1_:class_3087 = null;
         _loc2_ = 0;
         while(_loc2_ < 5)
         {
            _loc1_ = class_2010(var_31.findChildByName("badge_" + _loc2_)).widget as class_3087;
            _loc1_.badgeId = "";
            _loc2_++;
         }
      }
      
      public function clearGroupBadge() : void
      {
         var _loc1_:class_3087 = class_2010(var_31.findChildByName("badge_group")).widget as class_3087;
         _loc1_.badgeId = "";
      }
      
      public function setGroupBadge(param1:String) : void
      {
         var _loc2_:class_3087 = class_2010(var_31.findChildByName("badge_group")).widget as class_3087;
         _loc2_.badgeId = param1;
      }
      
      private function onTagSelected(param1:WindowMouseEvent) : void
      {
         var _loc2_:ITextWindow = param1.target as ITextWindow;
         if(_loc2_ == null)
         {
            return;
         }
         var_16.messageListener.processWidgetMessage(new RoomWidgetRoomTagSearchMessage(_loc2_.text));
      }
      
      public function update(param1:RoomWidgetUserInfoUpdateEvent) : void
      {
         clearBadges();
         clearGroupBadge();
         setGroupBadge(param1.groupBadgeId);
         updateInfo(param1);
      }
      
      public function setRelationshipStatuses(param1:class_55) : void
      {
         var _loc5_:String = null;
         var _loc2_:class_1741 = null;
         var _loc3_:class_3604 = null;
         if(!var_31 || !var_16)
         {
            return;
         }
         for each(var _loc4_ in class_2242.displayableStatuses)
         {
            _loc5_ = class_2242.statusAsString(_loc4_);
            _loc2_ = var_31.findChildByName("relationship_" + _loc5_);
            _loc3_ = param1.getValue(_loc4_);
            if(_loc3_)
            {
               _loc2_.visible = _loc3_.friendCount > 0;
               var _loc7_:String = _loc5_ + "_randomusername";
               var _loc6_:class_1741 = var_31.findChildByName(null);
               if(_loc6_)
               {
                  null.caption = _loc3_.randomFriendName;
                  null.id = _loc3_.randomFriendId;
               }
               var_31.findChildByName(_loc5_ + "_others").visible = _loc3_.friendCount > 1;
               var_16.localizations.registerParameter("infostand.relstatus." + _loc5_ + ".others","amount",(_loc3_.friendCount - 1).toString());
            }
            else
            {
               _loc2_.visible = false;
            }
         }
      }
      
      protected function updateInfo(param1:RoomWidgetUserInfoUpdateEvent) : void
      {
         name = param1.name;
         setMotto(param1.motto,param1.type == "RWUIUE_OWN_USER");
         achievementScore = param1.achievementScore;
         carryItem = param1.carryItem;
         xp = param1.xp;
         setFigure(param1.figure);
      }
      
      protected function onMottoKeyboard(param1:WindowKeyboardEvent) : void
      {
         var _loc5_:RoomWidgetChangeMottoMessage = null;
         var _loc2_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:class_1812 = var_108.getListItemByName("motto_container") as class_1812;
         if(!_loc7_)
         {
            return;
         }
         var _loc4_:ITextFieldWindow = _loc7_.findChildByName("motto_text") as ITextFieldWindow;
         var _loc3_:String = _loc4_.text;
         if(param1.keyCode == 13)
         {
            _loc2_ = getTimer();
            if(_loc2_ - var_4687 > 2000 && _loc3_ != var_16.localizations.getLocalization("infostand.motto.change"))
            {
               _loc6_ = var_16.userData.userId;
               _loc5_ = new RoomWidgetChangeMottoMessage(_loc3_);
               var_16.messageListener.processWidgetMessage(_loc5_);
               var_4687 = _loc2_;
               _loc4_.textColor = 16777215;
               _loc4_.unfocus();
            }
         }
         else
         {
            _loc4_.textColor = 11184810;
         }
         _loc4_.height = Math.min(_loc4_.textHeight + 5,50);
         _loc4_.height = Math.max(_loc4_.height,23);
         _loc7_.height = _loc4_.height + 3;
      }
      
      protected function onMottoClicked(param1:WindowMouseEvent) : void
      {
         var _loc3_:class_1812 = var_108.getListItemByName("motto_container") as class_1812;
         if(!_loc3_)
         {
            return;
         }
         var _loc2_:ITextWindow = _loc3_.findChildByName("motto_text") as ITextWindow;
         if(_loc2_.text == var_16.localizations.getLocalization("infostand.motto.change"))
         {
            _loc2_.text = "";
         }
         _loc2_.textColor = 11184810;
      }
      
      protected function onButtonClicked(param1:WindowMouseEvent) : void
      {
         var _loc4_:String = null;
         var _loc2_:class_1741 = param1.target as class_1741;
         var _loc5_:* = _loc2_.name;
         if("home_icon" === _loc5_)
         {
            _loc4_ = "RWUAM_OPEN_HOME_PAGE";
         }
         if(_loc4_ != null)
         {
            var _loc3_:RoomWidgetMessage = new RoomWidgetUserActionMessage(_loc4_,var_16.userData.userId);
            HabboTracking.getInstance().trackEventLog("InfoStand","click",_loc4_);
         }
         updateWindow();
      }
      
      protected function onProfileLink(param1:class_1758, param2:class_1741) : void
      {
         var _loc3_:ITextWindow = null;
         if(param1.type == "WME_CLICK")
         {
            var_16.messageListener.processWidgetMessage(new RoomWidgetOpenProfileMessage("RWOPEM_OPEN_USER_PROFILE",var_16.userData.userId,"infoStand_userView"));
         }
         if(param2.name == "profile_link")
         {
            if(param1.type == "WME_OVER")
            {
               _loc3_ = var_753.findChildByName("name_text") as ITextWindow;
               _loc3_.textColor = 9552639;
            }
            if(param1.type == "WME_OUT")
            {
               _loc3_ = var_753.findChildByName("name_text") as ITextWindow;
               _loc3_.textColor = 16777215;
            }
         }
      }
      
      private function onRelationshipUserNameLinkClicked(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type == "WME_CLICK" && param2 is ITextLinkWindow)
         {
            var_16.handler.container.connection.send(new class_1879(param2.id));
         }
      }
   }
}

