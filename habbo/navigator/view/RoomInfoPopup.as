package com.sulake.habbo.navigator.view
{
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.class_2010;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.navigator.HabboNewNavigator;
   import com.sulake.habbo.navigator.roomsettings.RoomSettingsCtrl;
   import com.sulake.habbo.navigator.transitional.LegacyNavigator;
   import com.sulake.habbo.session.enum.RoomTradingLevelEnum;
   import com.sulake.habbo.utils.FriendlyTime;
   import com.sulake.habbo.window.widgets.class_3087;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import com.sulake.habbo.communication.messages.outgoing.navigator.AddFavouriteRoomMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.navigator.UpdateHomeRoomMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.navigator.DeleteFavouriteRoomMessageComposer;
   import com.sulake.habbo.communication.messages.incoming.users.class_1846;
   import com.sulake.habbo.communication.messages.incoming.navigator.class_1945;
   
   public class RoomInfoPopup
   {
      
      private var _window:class_1812;
      
      private var _navigator:HabboNewNavigator;
      
      private var var_2264:Vector.<String> = new Vector.<String>(0);
      
      private var var_58:class_1945 = null;
      
      private var var_2787:Point = new Point(-1,-1);
      
      private var var_2892:Boolean = false;
      
      private var var_4868:Boolean;
      
      private var var_2775:Boolean = false;
      
      private var var_4456:Boolean;
      
      public function RoomInfoPopup(param1:HabboNewNavigator)
      {
         super();
         _navigator = param1;
      }
      
      public function show(param1:Boolean) : void
      {
         if(param1)
         {
            if(!_window)
            {
               createWindow();
            }
            populate();
            _window.visible = true;
            var_2892 = false;
            var_2775 = false;
         }
         else if(_window)
         {
            _window.visible = false;
         }
      }
      
      public function get visible() : Boolean
      {
         if(!_window)
         {
            return false;
         }
         return _window.visible;
      }
      
      public function showAt(param1:Boolean, param2:int, param3:int) : void
      {
         var _loc4_:* = !this.visible;
         show(param1);
         if(param1)
         {
            var _loc5_:Point = new Point(param2,param3 - _window.height / 2);
            if(var_2787 != null)
            {
               if(_loc4_ && param1 && var_58)
               {
                  _navigator.trackEventLog("browse.openroominfo","Results",var_58.roomName,var_58.flatId);
               }
            }
            position = null;
            _window.activate();
         }
      }
      
      public function setData(param1:class_1945) : void
      {
         this.var_58 = param1;
      }
      
      public function getGlobalRectangle(param1:Rectangle) : void
      {
         _window.getGlobalRectangle(param1);
      }
      
      private function set position(param1:Point) : void
      {
         _window.position = param1;
         var_2787 = param1;
      }
      
      private function get roomIsHome() : Boolean
      {
         if(var_2892)
         {
            return var_4868;
         }
         return _navigator.legacyNavigator.isRoomHome(var_58.flatId);
      }
      
      private function set roomIsHome(param1:Boolean) : void
      {
         var_2892 = true;
         var_4868 = param1;
      }
      
      private function get roomIsFavorite() : Boolean
      {
         if(var_2775)
         {
            return var_4456;
         }
         return _navigator.legacyNavigator.isRoomFavorite(var_58.flatId);
      }
      
      private function set roomIsFavorite(param1:Boolean) : void
      {
         var_2775 = true;
         var_4456 = param1;
      }
      
      private function populate() : void
      {
         var _loc7_:class_1846 = null;
         var _loc5_:String = null;
         var _loc1_:String = null;
         if(var_58 == null)
         {
            return;
         }
         var _loc4_:IItemListWindow = IItemListWindow(_window.findChildByName("main_content"));
         var _loc9_:IItemListWindow = IItemListWindow(_window.findChildByName("header_content"));
         var _loc6_:IItemListWindow = IItemListWindow(_window.findChildByName("bottom_itemlist"));
         _window.findChildByName("room_owner_region").visible = var_58.showOwner;
         _window.findChildByName("room_group_region").visible = var_58.groupBadgeCode != "";
         _window.findChildByName("room_name").caption = var_58.roomName;
         _window.findChildByName("room_desc").caption = var_58.description;
         _window.findChildByName("owner_name").caption = var_58.ownerName;
         _window.findChildByName("room_owner_region").id = var_58.ownerId;
         _window.findChildByName("room_owner_region").procedure = ownerLinkProcedure;
         _window.findChildByName("favorite_region").procedure = roomFavoriteRegionProcedure;
         _window.findChildByName("home_region").procedure = homeRoomRegionProcedure;
         _window.findChildByName("settings_region").procedure = settingsRegionProcedure;
         _window.findChildByName("settings_container").visible = var_58.ownerName == _navigator.sessionData.userName;
         if(_navigator.context.configuration.getBoolean("room.report.enabled") && var_58.ownerName != _navigator.sessionData.userName)
         {
            _window.findChildByName("report_region").id = var_58.ownerId;
            _window.findChildByName("report_region").procedure = reportRegionProcedure;
            _window.findChildByName("report_region").visible = true;
            _window.findChildByName("report_container").visible = true;
         }
         else
         {
            _window.findChildByName("report_region").visible = false;
            _window.findChildByName("report_container").visible = false;
         }
         IItemListWindow(_window.findChildByName("midBottom_itemlist")).arrangeListItems();
         IStaticBitmapWrapperWindow(_window.findChildByName("favorite_icon")).assetUri = "newnavigator_icon_fav_" + (roomIsFavorite ? "yes" : "no");
         IStaticBitmapWrapperWindow(_window.findChildByName("home_icon")).assetUri = "newnavigator_icon_home_" + (roomIsHome ? "yes" : "no");
         var _loc8_:* = var_58.groupBadgeCode != "";
         _window.findChildByName("room_group_badge").visible = _loc8_;
         _window.findChildByName("room_owner_region").visible = var_58.showOwner;
         _window.findChildByName("room_group_region").visible = _loc8_;
         _window.findChildByName("room_group_owner_container").visible = _loc8_ || var_58.showOwner;
         if(_loc8_)
         {
            class_3087(class_2010(_window.findChildByName("room_group_badge")).widget).badgeId = var_58.groupBadgeCode;
            _window.findChildByName("group_name").caption = var_58.groupName;
            _window.findChildByName("group_name").id = var_58.habboGroupId;
            _window.findChildByName("room_group_region").id = var_58.habboGroupId;
            _window.findChildByName("room_group_region").procedure = groupLinkProcedure;
            _loc7_ = _navigator.getCachedGroupDetails(var_58.habboGroupId);
            if(_loc7_)
            {
               if(_loc7_.isOwner)
               {
                  IStaticBitmapWrapperWindow(_window.findChildByName("group_mode_admin")).assetUri = "newnavigator_icon_group_owner";
               }
               else if(_loc7_.isAdmin)
               {
                  IStaticBitmapWrapperWindow(_window.findChildByName("group_mode_admin")).assetUri = "newnavigator_icon_group_admin";
               }
               else
               {
                  IStaticBitmapWrapperWindow(_window.findChildByName("group_mode_admin")).assetUri = null;
               }
               IStaticBitmapWrapperWindow(_window.findChildByName("group_mode_size")).assetUri = "${image.library.url}guilds/grouptype_icon_" + _loc7_.type + ".png";
               IStaticBitmapWrapperWindow(_window.findChildByName("group_mode_furnish")).assetUri = !_loc7_.membersCanDecorate ? null : "${image.library.url}guilds/group_decorate_icon.png";
            }
         }
         else
         {
            IStaticBitmapWrapperWindow(_window.findChildByName("group_mode_admin")).assetUri = null;
            IStaticBitmapWrapperWindow(_window.findChildByName("group_mode_size")).assetUri = null;
            IStaticBitmapWrapperWindow(_window.findChildByName("group_mode_furnish")).assetUri = null;
         }
         var _loc3_:* = var_58.roomAdExpiresInMin > 0;
         if(_loc3_)
         {
            _loc5_ = _navigator.localization.getLocalizationWithParams("navigator.eventsettings.name") + ": " + var_58.roomAdName;
            _loc1_ = _navigator.localization.getLocalizationWithParams("navigator.eventsettings.desc") + ": " + var_58.roomAdDescription + "\n";
            _loc1_ += _navigator.localization.getLocalizationWithParams("roomad.event.expiration_time") + FriendlyTime.getFriendlyTime(_navigator.localization,var_58.roomAdExpiresInMin * 60);
            _window.findChildByName("event_name").caption = _loc5_;
            _window.findChildByName("event_desc").caption = _loc1_;
         }
         _loc6_.getListItemByName("event_info").visible = _loc3_;
         _loc9_.arrangeListItems();
         var_2264 = new Vector.<String>(0);
         var _loc2_:IItemListWindow = IItemListWindow(_window.findChildByName("tag_list"));
         _loc2_.destroyListItems();
         var _loc10_:int = 0;
         while(0 < var_58.tags.length)
         {
            var_2264.push(var_58.tags[0]);
            _loc2_.addListItem(getNewTagItem(var_58.tags[0],0));
            _loc10_++;
         }
         clearProperties();
         addProperty("properties","${navigator.roompopup.property.trading}",RoomTradingLevelEnum.getLocalizationKey(var_58.tradeMode));
         if(_navigator.context.configuration.getBoolean("room.ranking.enabled"))
         {
            addProperty("properties","${navigator.roompopup.property.ranking}",var_58.ranking.toString());
         }
         addProperty("properties","${navigator.roompopup.property.max_users}",var_58.maxUserCount.toString());
         IStaticBitmapWrapperWindow(_window.findChildByName("room_thumbnail")).assetUri = "newnavigator_default_room";
         if(_navigator.sessionData.isPerkAllowed("NAVIGATOR_ROOM_THUMBNAIL_CAMERA"))
         {
            if(var_58.officialRoomPicRef != null)
            {
               if(_navigator.getBoolean("new.navigator.official.room.thumbnails.in.amazon"))
               {
                  IStaticBitmapWrapperWindow(_window.findChildByName("room_thumbnail")).assetUri = _navigator.getProperty("navigator.thumbnail.url_base") + var_58.flatId + ".png";
               }
               else
               {
                  IStaticBitmapWrapperWindow(_window.findChildByName("room_thumbnail")).assetUri = _navigator.getProperty("image.library.url") + var_58.officialRoomPicRef;
               }
            }
            else
            {
               IStaticBitmapWrapperWindow(_window.findChildByName("room_thumbnail")).assetUri = _navigator.getProperty("navigator.thumbnail.url_base") + var_58.flatId + ".png";
            }
         }
         _loc6_.arrangeListItems();
         _loc4_.arrangeListItems();
      }
      
      private function clearProperties() : void
      {
         IItemListWindow(_window.findChildByName("properties")).destroyListItems();
      }
      
      private function addProperty(param1:String, param2:String, param3:String) : void
      {
         var _loc5_:IItemListWindow = IItemListWindow(_window.findChildByName(param1));
         var _loc4_:class_1812 = class_1812(_navigator.windowManager.buildFromXML(XML(_navigator.assets.getAssetByName("property_xml").content)));
         _loc4_.findChildByName("property_name").caption = param2;
         _loc4_.findChildByName("property_value").caption = param3;
         _loc5_.addListItem(_loc4_);
      }
      
      private function getNewTagItem(param1:String, param2:int) : class_1741
      {
         var _loc3_:class_1812 = class_1812(_navigator.windowManager.buildFromXML(XML(_navigator.assets.getAssetByName("tag_xml").content)));
         var _loc4_:IRegionWindow = IRegionWindow(_loc3_.findChildByName("tag_region"));
         _loc4_.id = param2;
         _loc4_.procedure = tagRegionProcedure;
         _loc4_.findChildByName("tag_text").caption = "#" + param1;
         return _loc4_;
      }
      
      private function createWindow() : void
      {
         _window = class_1812(_navigator.windowManager.buildFromXML(XML(_navigator.assets.getAssetByName("room_info_popup_bubble_xml").content)));
      }
      
      private function ownerLinkProcedure(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type == "WME_CLICK")
         {
            _navigator.getExtendedProfile(param2.id);
            destroy();
         }
      }
      
      private function groupLinkProcedure(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type == "WME_CLICK")
         {
            _navigator.getGuildInfo(param2.id);
            destroy();
         }
      }
      
      private function reportRegionProcedure(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type == "WME_CLICK")
         {
            _navigator.habboHelp.reportRoom(var_58.flatId,var_58.roomName,var_58.description);
            destroy();
         }
      }
      
      private function tagRegionProcedure(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type == "WME_CLICK")
         {
            _navigator.performTagSearch(var_2264[param2.id]);
            destroy();
         }
      }
      
      private function settingsRegionProcedure(param1:class_1758, param2:class_1741) : void
      {
         var _loc3_:RoomSettingsCtrl = null;
         if(param1.type == "WME_CLICK")
         {
            _loc3_ = LegacyNavigator(_navigator.legacyNavigator).roomSettingsCtrl;
            _loc3_.startRoomSettingsEditFromNavigator(var_58.flatId,var_58.habboGroupId);
            destroy();
         }
      }
      
      private function roomFavoriteRegionProcedure(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type == "WME_CLICK")
         {
            if(!roomIsFavorite)
            {
               _navigator.communication.connection.send(new AddFavouriteRoomMessageComposer(var_58.flatId));
               roomIsFavorite = true;
            }
            else
            {
               _navigator.communication.connection.send(new DeleteFavouriteRoomMessageComposer(var_58.flatId));
               roomIsFavorite = false;
            }
            IStaticBitmapWrapperWindow(_window.findChildByName("favorite_icon")).assetUri = "newnavigator_icon_fav_" + (roomIsFavorite ? "yes" : "no");
         }
      }
      
      private function homeRoomRegionProcedure(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type == "WME_CLICK")
         {
            if(!roomIsHome)
            {
               _navigator.communication.connection.send(new UpdateHomeRoomMessageComposer(var_58.flatId));
               roomIsHome = true;
            }
            IStaticBitmapWrapperWindow(_window.findChildByName("home_icon")).assetUri = "newnavigator_icon_home_" + (roomIsHome ? "yes" : "no");
         }
      }
      
      private function destroy() : void
      {
         if(_window)
         {
            _window.destroy();
         }
         _window = null;
      }
   }
}

