package com.sulake.habbo.navigator.inroom
{
   import com.sulake.core.runtime.class_17;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_2250;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.navigator.GuildInfoCtrl;
   import com.sulake.habbo.navigator.SimpleAlertView;
   import com.sulake.habbo.navigator.TagRenderer;
   import com.sulake.habbo.navigator.Util;
   import com.sulake.habbo.navigator.class_42;
   import com.sulake.habbo.session.IRoomSession;
   import com.sulake.habbo.utils.class_2323;
   import flash.events.Event;
   import com.sulake.habbo.communication.messages.outgoing.navigator.ToggleStaffPickMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.navigator.AddFavouriteRoomMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.navigator.UpdateHomeRoomMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.navigator.DeleteFavouriteRoomMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.room.action.MuteAllInRoomComposer;
   import com.sulake.habbo.communication.messages.incoming.navigator.class_1945;
   import com.sulake.habbo.communication.messages.outgoing.users.GetExtendedProfileMessageComposer;
   
   public class RoomInfoViewCtrl
   {
      
      private var _navigator:class_42;
      
      private var var_2062:GuildInfoCtrl;
      
      private var _window:class_2250;
      
      private var var_1511:TagRenderer;
      
      private var _embedExpanded:Boolean = false;
      
      private var var_588:Boolean = false;
      
      public function RoomInfoViewCtrl(param1:class_42)
      {
         super();
         _navigator = param1;
         var_2062 = new GuildInfoCtrl(_navigator);
         var_1511 = new TagRenderer(_navigator);
      }
      
      public function dispose() : void
      {
         _navigator = null;
         var_588 = false;
         if(_window)
         {
            _window.dispose();
            _window = null;
         }
         if(var_1511)
         {
            var_1511.dispose();
            var_1511 = null;
         }
         if(var_2062)
         {
            var_2062.dispose();
            var_2062 = null;
         }
      }
      
      public function close() : void
      {
         if(_window == null)
         {
            return;
         }
         var_588 = false;
         _window.dispose();
         _window = null;
         _navigator.events.dispatchEvent(new Event("HABBO_ROOM_SETTINGS_TRACKING_EVENT_CLOSED"));
      }
      
      public function reload() : void
      {
         if(var_588)
         {
            refresh();
         }
      }
      
      public function toggle() : void
      {
         if(var_588)
         {
            var_588 = false;
            if(_window)
            {
               _window.dispose();
               _window = null;
            }
         }
         else
         {
            var_588 = true;
            refresh();
            if(_window != null)
            {
               _window.activate();
            }
         }
      }
      
      private function refresh() : void
      {
         if(_navigator.data.enteredGuestRoom == null)
         {
            return;
         }
         var_1511.useHashTags = true;
         prepareWindow();
         Util.hideChildren(_window.content);
         refreshRoomDetails(_navigator.data.enteredGuestRoom);
         refreshEmbed();
         var_2062.refresh(_window.content,_navigator.data.enteredGuestRoom);
         refreshButtons(_navigator.data.enteredGuestRoom);
         Util.moveChildrenToColumn(_window.content,["room_details","public_space_details","guild_info","embed_info","buttons_cont"],0,3);
         _window.findChildByName("guild_info").x = 11;
         _window.height = Util.getLowestPoint(_window.content) + 45;
      }
      
      private function isHome(param1:class_1945) : Boolean
      {
         return param1 != null && param1.flatId == _navigator.data.homeRoomId;
      }
      
      private function refreshEmbed() : void
      {
         var _loc6_:ITextWindow = null;
         var _loc4_:ITextFieldWindow = null;
         var _loc3_:class_1741 = null;
         var _loc1_:class_1812 = class_1812(find("embed_info"));
         var _loc2_:Boolean = _navigator.getBoolean("embed.showInRoomInfo");
         var _loc5_:* = _navigator.data.enteredGuestRoom != null;
         if(_loc5_ && _loc2_)
         {
            _loc6_ = ITextWindow(_loc1_.findChildByName("embed_info_txt"));
            _loc4_ = ITextFieldWindow(_loc1_.findChildByName("embed_src_txt"));
            _loc3_ = _loc1_.findChildByName("embed_info_region");
            _loc1_.visible = true;
            if(_embedExpanded)
            {
               _loc4_.text = this.getEmbedData();
            }
            _loc6_.visible = _embedExpanded;
            _loc4_.visible = _embedExpanded;
            _loc3_.visible = false;
            _loc1_.height = Util.getLowestPoint(_loc1_) + 5;
            _loc3_.visible = true;
            _loc3_.height = _embedExpanded ? _loc4_.y : int(_loc1_.height);
         }
         else
         {
            _loc1_.visible = false;
         }
      }
      
      private function refreshRoomDetails(param1:class_1945) : void
      {
         if(param1 == null)
         {
            return;
         }
         var _loc4_:class_1812 = class_1812(find("room_details"));
         var _loc6_:ITextWindow = ITextWindow(find("room_name"));
         _loc6_.text = param1.roomName;
         _loc6_.height = _loc6_.textHeight + 5;
         var _loc2_:ITextWindow = ITextWindow(find("owner_name"));
         if(param1.showOwner && param1.ownerId > 0)
         {
            find("owner_name_cont").visible = true;
            _loc2_.visible = true;
            _loc2_.text = param1.ownerName;
            class_2323.setUserInfoState(false,_loc4_);
         }
         else
         {
            find("owner_name_cont").visible = false;
         }
         var _loc3_:ITextWindow = ITextWindow(find("room_desc"));
         _loc3_.text = param1.description;
         var_1511.refreshTags(_loc4_,param1.tags);
         _loc3_.visible = false;
         if(param1.description != "")
         {
            _loc3_.height = _loc3_.textHeight + 5;
            _loc3_.visible = true;
         }
         find("rating_region").visible = _navigator.data.canRate;
         ITextWindow(find("rating_txt")).text = "" + _navigator.data.currentRoomRating;
         var _loc5_:class_1741 = _window.findChildByName("rating_txt");
         _window.findChildByName("rating_region").x = _loc5_.x + _loc5_.width + 5;
         find("ranking_cont").visible = param1.ranking > 0;
         ITextWindow(find("ranking_txt")).text = "" + param1.ranking;
         _navigator.refreshButton(_loc4_,"home",isHome(param1),null,0);
         _window.findChildByName("make_home_region").visible = !isHome(param1);
         _window.findChildByName("make_favourite_region").visible = !_navigator.data.currentRoomOwner && !_navigator.data.isCurrentRoomFavourite();
         _window.findChildByName("favourite_region").visible = !_navigator.data.currentRoomOwner && _navigator.data.isCurrentRoomFavourite();
         _window.findChildByName("floor_plan_editor_button").visible = _navigator.data.canEditRoomSettings;
         Util.moveChildrenToColumn(_loc4_,["room_name","owner_name_cont","rating_cont","ranking_cont","padding_cont","tags","room_desc","thumbnail_container"],_loc6_.y,0);
         _loc4_.visible = true;
         _loc4_.height = Util.getLowestPoint(_loc4_);
      }
      
      private function refreshStaffPick(param1:Boolean = false) : void
      {
         var _loc2_:class_1741 = null;
         if(_window)
         {
            _loc2_ = _window.findChildByName("staff_pick_button");
            if(!_navigator.data.roomPicker)
            {
               _loc2_.visible = false;
               return;
            }
            _loc2_.visible = true;
            if(param1)
            {
               _loc2_.caption = _navigator.getText(!_navigator.data.currentRoomIsStaffPick ? "navigator.staffpicks.unpick" : "navigator.staffpicks.pick");
            }
            else
            {
               _loc2_.caption = _navigator.getText(_navigator.data.currentRoomIsStaffPick ? "navigator.staffpicks.unpick" : "navigator.staffpicks.pick");
            }
         }
      }
      
      public function refreshButtons(param1:class_1945) : void
      {
         var _loc3_:class_1812 = null;
         if(_navigator.data.enteredGuestRoom == null || _window == null)
         {
            return;
         }
         find("room_settings_button").visible = _navigator.data.canEditRoomSettings;
         find("room_filter_button").visible = _navigator.data.canEditRoomSettings && _navigator.getBoolean("room.custom.filter.enabled");
         if(!_navigator.getBoolean("room.report.enabled"))
         {
            _loc3_ = class_1812(find("room_report_button"));
            if(_loc3_)
            {
               _loc3_.visible = false;
            }
         }
         refreshStaffPick();
         var _loc6_:class_1741 = find("room_muteall_button");
         _loc6_.visible = _navigator.data.enteredGuestRoom.canMute && _navigator.getBoolean("room_moderation.mute_all.enabled");
         var _loc5_:Boolean = _navigator.data.enteredGuestRoom.allInRoomMuted;
         _loc6_.caption = _loc5_ ? "${navigator.muteall_on}" : "${navigator.muteall_off}";
         var _loc7_:IRoomSession = _navigator.roomSessionManager.getSession(_navigator.data.enteredGuestRoom.flatId);
         find("floor_plan_editor_button").visible = _loc7_.roomControllerLevel >= 1;
         var _loc4_:class_1812 = class_1812(_window.findChildByName("buttons_cont"));
         var _loc2_:Array = ["room_settings_button","room_filter_button","floor_plan_editor_button","staff_pick_button","room_report_button","room_muteall_button"];
         Util.moveChildrenToColumn(_loc4_,_loc2_,0,3);
         _loc4_.visible = Util.hasVisibleChildren(class_1812(_loc4_));
         _loc4_.height = Util.getLowestPoint(_loc4_);
      }
      
      private function prepareWindow() : void
      {
         var_588 = true;
         if(_window != null)
         {
            return;
         }
         _window = class_2250(_navigator.getXmlWindow("iro_room_details_framed"));
         _window.center();
         addMouseClickListener(find("make_favourite_region"),onAddFavouriteClick);
         addMouseClickListener(find("favourite_region"),onRemoveFavouriteClick);
         addMouseClickListener(find("room_settings_button"),onRoomSettingsClick);
         addMouseClickListener(find("room_filter_button"),onRoomFilterButtonClick);
         addMouseClickListener(find("floor_plan_editor_button"),onFloorPlanEditorButtonClick);
         addMouseClickListener(find("room_muteall_button"),onMuteAllClick);
         addMouseClickListener(find("make_home_region"),onMakeHomeClick);
         addMouseClickListener(find("remove_rights_region"),onRemoveRights);
         addMouseClickListener(find("embed_src_txt"),onEmbedSrcClick);
         addMouseClickListener(find("staff_pick_button"),onStaffPick);
         addMouseClickListener(find("room_report_button"),onRoomReport);
         _navigator.refreshButton(IRegionWindow(find("remove_rights_region")),"remove_rights",_navigator.hasRoomRightsButIsNotOwner(_navigator.data.enteredGuestRoom.flatId),null,0);
         _navigator.refreshButton(IRegionWindow(find("make_home_region")),"make_home",true,null,0);
         _navigator.refreshButton(IRegionWindow(find("favourite_region")),"favourite",true,null,0);
         _navigator.refreshButton(IRegionWindow(find("make_favourite_region")),"make_favourite",true,null,0);
         _navigator.refreshButton(class_1812(find("embed_info")),"icon_weblink",true,null,0);
         addMouseClickListener(_window.findChildByTag("close"),onCloseButtonClick);
         var _loc2_:class_1812 = class_1812(_window.findChildByName("owner_name_cont"));
         _loc2_.procedure = onOwnerName;
         Util.layoutChildrenInArea(_loc2_,1000,10,2,5);
         setupLabelAndValue("rating_cont","rating_caption","rating_txt");
         setupLabelAndValue("ranking_cont","ranking_caption","ranking_txt");
         var _loc4_:class_1812 = class_1812(find("embed_info"));
         var _loc5_:ITextWindow = ITextWindow(find("embed_info_txt"));
         _loc5_.height = _loc5_.textHeight + 5;
         Util.moveChildrenToColumn(_loc4_,["embed_info_txt","embed_src_txt"],_loc5_.y,2);
         _loc4_.height = Util.getLowestPoint(_loc4_) + 5;
         _loc4_.findChildByName("embed_info_region").procedure = onEmbedInfo;
         if(_navigator.sessionData.isPerkAllowed("NAVIGATOR_ROOM_THUMBNAIL_CAMERA"))
         {
            _window.findChildByName("add_thumbnail_region").visible = _navigator.data.canEditRoomSettings;
            if(_navigator.data.canEditRoomSettings)
            {
               addMouseClickListener(find("add_thumbnail_region"),onAddRoomThumbnail);
            }
            var _loc3_:String = "";
            if(_navigator.data.enteredGuestRoom.officialRoomPicRef != null)
            {
               if(_navigator.getBoolean("new.navigator.official.room.thumbnails.in.amazon"))
               {
                  var _loc1_:String = _navigator.getProperty("navigator.thumbnail.url_base");
                  _loc3_ = null + _navigator.data.enteredGuestRoom.flatId + ".png";
               }
               else
               {
                  _loc3_ = _navigator.getProperty("image.library.url") + _navigator.data.enteredGuestRoom.officialRoomPicRef;
               }
            }
            else
            {
               _loc1_ = _navigator.getProperty("navigator.thumbnail.url_base");
               _loc3_ = null + _navigator.data.enteredGuestRoom.flatId + ".png";
            }
            IStaticBitmapWrapperWindow(_window.findChildByName("thumbnail_image")).assetUri = null;
         }
         else
         {
            _window.findChildByName("thumbnail_container").visible = false;
         }
      }
      
      private function setupLabelAndValue(param1:String, param2:String, param3:String) : void
      {
         var _loc4_:class_1812 = class_1812(find(param1));
         var _loc5_:ITextWindow = ITextWindow(_loc4_.findChildByName(param2));
         _loc5_.width = _loc5_.textWidth;
         Util.moveChildrenToRow(_loc4_,[param2,param3],_loc5_.x,_loc5_.y,3);
      }
      
      private function addMouseClickListener(param1:class_1741, param2:Function) : void
      {
         if(param1 != null)
         {
            param1.addEventListener("WME_CLICK",param2);
         }
      }
      
      private function find(param1:String) : class_1741
      {
         var _loc2_:class_1741 = _window.findChildByName(param1);
         if(_loc2_ == null)
         {
            throw new Error("Window element with name: " + param1 + " cannot be found!");
         }
         return _loc2_;
      }
      
      public function onAddFavouriteClick(param1:class_1758) : void
      {
         var _loc2_:SimpleAlertView = null;
         if(_navigator.data.enteredGuestRoom == null)
         {
            return;
         }
         if(_navigator.data.isFavouritesFull())
         {
            _loc2_ = new SimpleAlertView(_navigator,"${navigator.favouritesfull.title}","${navigator.favouritesfull.body}");
            _loc2_.show();
         }
         else
         {
            _navigator.trackGoogle("roomInfo","addFavourite");
            _navigator.send(new AddFavouriteRoomMessageComposer(_navigator.data.enteredGuestRoom.flatId));
         }
      }
      
      public function onRemoveFavouriteClick(param1:class_1758) : void
      {
         if(_navigator.data.enteredGuestRoom == null)
         {
            return;
         }
         _navigator.trackGoogle("roomInfo","removeFavourite");
         _navigator.send(new DeleteFavouriteRoomMessageComposer(_navigator.data.enteredGuestRoom.flatId));
      }
      
      private function onRoomSettingsClick(param1:class_1758) : void
      {
         var _loc2_:class_1945 = _navigator.data.enteredGuestRoom;
         if(_loc2_ == null)
         {
            class_21.log("No entered room data?!");
            return;
         }
         _navigator.trackGoogle("roomInfo","editRoomSettings");
         _navigator.roomSettingsCtrl.startRoomSettingsEdit(_loc2_.flatId);
         close();
      }
      
      private function onRoomFilterButtonClick(param1:class_1758) : void
      {
         var _loc2_:class_1945 = _navigator.data.enteredGuestRoom;
         if(_loc2_ == null)
         {
            class_21.log("No entered room data?!");
            return;
         }
         _navigator.trackGoogle("roomInfo","editRoomFilter");
         _navigator.roomFilterCtrl.startRoomFilterEdit(_loc2_.flatId);
         close();
      }
      
      private function onFloorPlanEditorButtonClick(param1:class_1758) : void
      {
         _navigator.trackGoogle("roomInfo","floorPlanEditor");
         _navigator.windowManager.displayFloorPlanEditor();
         close();
      }
      
      private function onMuteAllClick(param1:class_1758) : void
      {
         _navigator.send(new MuteAllInRoomComposer());
      }
      
      private function onMakeHomeClick(param1:class_1758) : void
      {
         var _loc2_:class_1945 = _navigator.data.enteredGuestRoom;
         if(_loc2_ == null)
         {
            class_21.log("No entered room data?!");
            return;
         }
         class_21.log("SETTING HOME ROOM TO: " + _loc2_.flatId);
         _navigator.trackGoogle("roomInfo","makeHome");
         _navigator.send(new UpdateHomeRoomMessageComposer(_loc2_.flatId));
      }
      
      private function onCloseButtonClick(param1:class_1758) : void
      {
         hideInfo(null);
      }
      
      private function onRemoveRights(param1:class_1758) : void
      {
         _navigator.removeRoomRights(_navigator.enteredGuestRoomData.flatId);
         find("remove_rights_region").visible = false;
      }
      
      private function onStaffPick(param1:class_1758) : void
      {
         refreshStaffPick(true);
         _navigator.send(new ToggleStaffPickMessageComposer(_navigator.data.enteredGuestRoom.flatId,_navigator.data.currentRoomIsStaffPick));
      }
      
      private function onRoomReport(param1:class_1758) : void
      {
         _navigator.trackGoogle("roomInfo","reportRoom");
         var _loc2_:class_1945 = _navigator.data.enteredGuestRoom;
         _navigator.habboHelp.reportRoom(_loc2_.flatId,_loc2_.roomName,_loc2_.description);
         close();
      }
      
      private function onEmbedSrcClick(param1:class_1758) : void
      {
         var _loc2_:ITextFieldWindow = ITextFieldWindow(find("embed_src_txt"));
         _loc2_.setSelection(0,_loc2_.text.length);
         _navigator.trackGoogle("roomInfo","embedSrc");
      }
      
      private function onAddRoomThumbnail(param1:class_1758) : void
      {
         (_navigator.windowManager as class_17).context.createLinkEvent("roomThumbnailCamera/open");
         close();
         var _loc2_:String = _navigator.getProperty("navigator.thumbnail.url_base") + _navigator.data.enteredGuestRoom.flatId + ".png";
         _navigator.windowManager.resourceManager.removeAsset(_loc2_);
         _navigator.trackGoogle("roomInfo","addThumbnail");
      }
      
      private function hideInfo(param1:Event) : void
      {
         if(_window)
         {
            _window.dispose();
            _window = null;
         }
         var_588 = false;
      }
      
      private function getEmbedData() : String
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         if(_navigator.data.enteredGuestRoom != null)
         {
            _loc2_ = "private";
            _loc3_ = "" + _navigator.data.enteredGuestRoom.flatId;
         }
         var _loc1_:String = _navigator.getProperty("user.hash");
         _navigator.registerParameter("navigator.embed.src","roomType",_loc2_);
         _navigator.registerParameter("navigator.embed.src","embedCode",_loc1_);
         _navigator.registerParameter("navigator.embed.src","roomId",_loc3_);
         return _navigator.getText("navigator.embed.src");
      }
      
      private function onEmbedInfo(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         _embedExpanded = !_embedExpanded;
         refresh();
      }
      
      private function onOwnerName(param1:class_1758, param2:class_1741) : void
      {
         class_2323.onEntry(param1,param2);
         if(param1.type == "WME_CLICK")
         {
            _navigator.trackGoogle("roomInfo","extendedProfile");
            _navigator.trackGoogle("extendedProfile","navigator_roomInfo");
            _navigator.send(new GetExtendedProfileMessageComposer(_navigator.data.enteredGuestRoom.ownerId));
         }
      }
   }
}

