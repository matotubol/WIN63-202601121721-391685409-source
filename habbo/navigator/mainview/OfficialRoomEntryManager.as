package com.sulake.habbo.navigator.mainview
{
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_2251;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.navigator.UserCountRenderer;
   import com.sulake.habbo.navigator.Util;
   import com.sulake.habbo.navigator.class_42;
   import flash.display.BitmapData;
   import com.sulake.habbo.communication.messages.incoming.navigator.class_2460;
   
   public class OfficialRoomEntryManager implements class_13
   {
      
      private static const HOTTEST_GROUPS_TAG:String = "hottest_groups";
      
      private static const IMAGE_WIDTH_WIDE:int = 267;
      
      private static const IMAGE_WIDTH_NARROW:int = 65;
      
      private static const NARROW_IMAGE_OFFSET:int = -70;
      
      private var _disposed:Boolean;
      
      private var _navigator:class_42;
      
      private var var_1577:UserCountRenderer;
      
      public function OfficialRoomEntryManager(param1:class_42)
      {
         super();
         _navigator = param1;
         var_1577 = new UserCountRenderer(_navigator);
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function dispose() : void
      {
         if(var_1577)
         {
            var_1577.dispose();
            var_1577 = null;
         }
         _disposed = true;
      }
      
      public function refreshAdFooter(param1:class_1812) : void
      {
         if(_navigator.data.adRoom == null)
         {
            return;
         }
         var _loc5_:class_1812 = class_1812(param1.getChildByName("ad_footer"));
         var _loc2_:class_1812 = class_1812(_loc5_.getChildByName("ad_cont"));
         if(_loc2_.numChildren < 1)
         {
            _loc2_.addChild(createEntry(true));
         }
         var _loc3_:class_1812 = class_1812(_loc2_.getChildAt(0));
         refreshEntry(_loc3_,true,_navigator.data.adRoom);
         _loc5_.visible = true;
         _navigator.data.adIndex++;
      }
      
      public function createEntry(param1:Boolean) : class_1812
      {
         var _loc3_:class_2251 = null;
         var _loc4_:class_1812 = class_1812(_navigator.getXmlWindow("grs_official_room_row_phase_one"));
         var _loc5_:class_1812 = class_1812(_loc4_.findChildByName("image_cont"));
         var _loc2_:String = !param1 ? "_b" : "";
         _navigator.refreshButton(_loc5_,"rico_rnd_l" + _loc2_,true,null,0);
         _navigator.refreshButton(_loc5_,"rico_rnd_r" + _loc2_,true,null,0);
         _loc3_ = _loc5_.findChildByName("rico_rnd_m") as class_2251;
         _loc3_.bitmap = _navigator.getButtonImage("rico_rnd_m");
         _loc3_.disposesBitmap = false;
         var _loc6_:class_1812 = class_1812(_loc4_.findChildByName("folder_cont"));
         _navigator.refreshButton(_loc6_,"rico_rnd_l" + _loc2_,true,null,0);
         _navigator.refreshButton(_loc6_,"rico_rnd_r" + _loc2_,true,null,0);
         _loc3_ = _loc6_.findChildByName("rico_rnd_m") as class_2251;
         _loc3_.bitmap = _navigator.getButtonImage("rico_rnd_m");
         _loc3_.disposesBitmap = false;
         _loc4_.addEventListener("WME_OVER",onCellMouseOver);
         _loc4_.addEventListener("WME_OUT",onCellMouseOut);
         _loc4_.addEventListener("WME_CLICK",onCellMouseClick);
         _loc4_.color = param1 ? 4294967295 : 4292797682;
         return _loc4_;
      }
      
      public function refreshEntry(param1:class_1812, param2:Boolean, param3:class_2460) : void
      {
         Util.hideChildren(param1);
         if(param2)
         {
            param1.id = param3.index;
            if(param3.type == 4)
            {
               refreshFolderEntry(param1,param3);
            }
            else
            {
               refreshNormalEntry(param1,param3);
            }
            param1.visible = true;
         }
         else
         {
            param1.height = 0;
            param1.visible = false;
         }
      }
      
      private function refreshNormalEntry(param1:class_1812, param2:class_2460) : void
      {
         refreshCell(param1,param2);
         refreshDetails(param1,param2);
         refreshUserCount(param1,param2);
         param1.height = 68;
      }
      
      private function refreshFolderEntry(param1:class_1812, param2:class_2460) : void
      {
         var _loc3_:class_1812 = class_1812(param1.findChildByName("folder_cont"));
         _loc3_.visible = true;
         var _loc5_:ITextWindow = ITextWindow(_loc3_.findChildByName("folder_name_text"));
         _loc5_.text = param2.popupCaption;
         var _loc6_:ITextWindow = ITextWindow(_loc3_.findChildByName("arrow_label"));
         _loc6_.text = param2.open ? "${navigator.folder.hide}" : "${navigator.folder.show}";
         _navigator.refreshButton(_loc3_,"arrow_down_white",param2.open,null,0);
         _navigator.refreshButton(_loc3_,"arrow_right_white",!param2.open,null,0);
         this.refreshFolderImage(_loc3_,param2);
         param1.height = 68;
         var _loc4_:class_1812 = class_1812(param1.findChildByName("folderNameContainer"));
         if(_loc5_.text == "")
         {
            _loc4_.visible = false;
            return;
         }
         _loc4_.visible = true;
         if(!_navigator.isPerkAllowed("NAVIGATOR_PHASE_ONE_2014"))
         {
            _loc4_.width = _loc5_.textWidth + 20;
         }
      }
      
      private function refreshUserCount(param1:class_1812, param2:class_2460) : void
      {
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         var _loc5_:int = 0;
         if(param2.showDetails && param2.type == 2)
         {
            _loc4_ = 3;
            _loc3_ = 34;
            _loc5_ = 13;
            var_1577.refreshUserCount(param2.maxUsers,param1,param2.userCount,"${navigator.usercounttooltip.users}",param1.width - _loc4_ - _loc3_,param1.height - _loc4_ - _loc5_);
         }
      }
      
      private function refreshCell(param1:class_1812, param2:class_2460) : void
      {
         var _loc3_:class_1812 = class_1812(param1.findChildByName("image_cont"));
         _loc3_.visible = true;
         _loc3_.width = param2.showDetails ? 65 : 267;
         refreshPicText(_loc3_,param2);
         refreshRoomImage(_loc3_,param2);
      }
      
      private function refreshPicText(param1:class_1812, param2:class_2460) : void
      {
         var _loc6_:class_1812 = class_1812(param1.findChildByName("picTextContainer"));
         if(param2.picText == "" || param2.showDetails)
         {
            _loc6_.visible = false;
            return;
         }
         _loc6_.visible = true;
         var _loc4_:ITextWindow = ITextWindow(_loc6_.findChildByName("picText"));
         _loc4_.text = param2.picText;
         _loc4_.height = _loc4_.textHeight + 10;
         var _loc5_:* = _loc4_.textHeight > 10;
         _loc6_.height = _loc4_.height + 4;
      }
      
      private function refreshFolderImage(param1:class_1812, param2:class_2460) : void
      {
         var _loc3_:class_2251 = class_2251(param1.findChildByName("folder_image"));
         _loc3_.visible = false;
         if(param2.picRef != "")
         {
            refreshCustomImage(param2,_loc3_);
         }
      }
      
      private function refreshRoomImage(param1:class_1812, param2:class_2460) : void
      {
         var _loc3_:class_2251 = class_2251(param1.findChildByName("room_image"));
         _loc3_.visible = false;
         if(param2.picRef != "")
         {
            refreshCustomImage(param2,_loc3_);
         }
         else if(param2.guestRoomData != null)
         {
            refreshGuestRoomImage(param1,param2,_loc3_);
         }
         else
         {
            refreshEmptyImage(param1,param2,_loc3_);
         }
      }
      
      private function refreshCustomImage(param1:class_2460, param2:class_2251) : void
      {
         var _loc4_:String = "customImage." + param1.picRef;
         if(param2.tags[0] == _loc4_)
         {
            param2.visible = true;
            return;
         }
         class_21.log("Loading custom image: " + param1.picRef);
         param2.x = 0;
         param2.visible = false;
         var _loc3_:OfficialRoomImageLoader = new OfficialRoomImageLoader(_navigator,param1.picRef,param2);
         _loc3_.startLoad();
         param2.tags.splice(0,param2.tags.length);
         param2.tags.push(_loc4_);
      }
      
      private function refreshGuestRoomImage(param1:class_1812, param2:class_2460, param3:class_2251) : void
      {
         var _loc4_:String = "guestRoom." + param2.guestRoomData.thumbnail.getAsString();
         if(param3.tags[0] == _loc4_)
         {
            param3.visible = true;
            return;
         }
         class_21.log("Redrawing guest room image");
         param3.x = 0;
         param3.width = 64;
         param3.bitmap = new BitmapData(64,64);
         param3.bitmap.fillRect(param3.bitmap.rect,4294967295);
         param3.tags.splice(0,param3.tags.length);
         param3.tags.push(_loc4_);
         param3.visible = true;
      }
      
      private function refreshEmptyImage(param1:class_1812, param2:class_2460, param3:class_2251) : void
      {
         if(param3.tags[0] == "empty")
         {
            param3.visible = true;
            return;
         }
         class_21.log("Redrawing empty image");
         param3.x = 0;
         param3.width = 64;
         param3.bitmap = new BitmapData(64,64,false,4291611852);
         param3.tags.splice(0,param3.tags.length);
         param3.tags.push("empty");
         param3.visible = true;
      }
      
      private function onCellMouseOver(param1:class_1758) : void
      {
         var _loc2_:class_1741 = param1.target;
         this.setEnterArrowVisibility(_loc2_,true);
      }
      
      private function onCellMouseOut(param1:class_1758) : void
      {
         var _loc2_:class_1741 = param1.target;
         this.setEnterArrowVisibility(_loc2_,false);
      }
      
      private function onCellMouseClick(param1:class_1758) : void
      {
         var _loc2_:class_1741 = param1.target;
         this.handleClick(_loc2_);
      }
      
      private function setEnterArrowVisibility(param1:class_1741, param2:Boolean) : void
      {
         var _loc5_:class_1812 = class_1812(param1);
         if(_loc5_ == null)
         {
            return;
         }
         var _loc3_:class_1812 = class_1812(_loc5_.findChildByName("enter_room"));
         if(_loc3_ == null)
         {
            return;
         }
         if(param2)
         {
            _navigator.refreshButton(_loc3_,"enter_room_l",true,null,0);
            _navigator.refreshButton(_loc3_,"enter_room_r",true,null,0);
            var _loc4_:class_2251 = class_2251(_loc3_.findChildByName("enter_room_m"));
            if(_loc4_.bitmap == null)
            {
               null.bitmap = _navigator.getButtonImage("enter_room_m");
               null.disposesBitmap = false;
            }
            _navigator.refreshButton(_loc3_,"enter_room_a",true,null,0);
         }
         _loc3_.visible = param2;
      }
      
      private function handleClick(param1:class_1741) : void
      {
         var _loc2_:class_2460 = this.getEntry(param1);
         if(_loc2_ == null)
         {
            return;
         }
         if(_loc2_.guestRoomData != null)
         {
            class_21.log("ENTERING ROOM: " + _loc2_.guestRoomData.flatId);
            if(_loc2_.guestRoomData.doorMode == 2)
            {
               _navigator.passwordInput.show(_loc2_.guestRoomData);
            }
            else
            {
               _navigator.goToRoom(_loc2_.guestRoomData.flatId,true);
            }
         }
         else if(_loc2_.tag != null)
         {
            class_21.log("MAKING TAG SEARCH: " + _loc2_.tag);
            if(_loc2_.tag == "hottest_groups")
            {
               _navigator.performGuildBaseSearch();
            }
            else
            {
               _navigator.mainViewCtrl.startSearch(5,9,_loc2_.tag);
            }
         }
         else
         {
            class_21.log("FOLDER CLICKD: " + _loc2_.index);
            _loc2_.toggleOpen();
            this._navigator.mainViewCtrl.refresh();
         }
      }
      
      private function getEntry(param1:class_1741) : class_2460
      {
         var _loc2_:class_1812 = param1 as class_1812;
         if(_loc2_ == null || _loc2_.name != "cont")
         {
            class_21.log("Target not cont");
            return null;
         }
         class_21.log("PARENT NAME: " + param1.parent.name);
         return _loc2_.parent.name == "ad_cont" ? findAdEntry() : findEntryInOfficialRoomList(_loc2_);
      }
      
      private function findAdEntry() : class_2460
      {
         return _navigator.data.adRoom;
      }
      
      private function findEntryInOfficialRoomList(param1:class_1812) : class_2460
      {
         if(_navigator.data.officialRooms == null)
         {
            class_21.log("No official rooms data click");
            return null;
         }
         var _loc3_:int = int(param1.id);
         class_21.log("Got index: " + _loc3_);
         for each(var _loc2_ in _navigator.data.officialRooms.entries)
         {
            if(_loc2_.index == _loc3_)
            {
               return _loc2_;
            }
         }
         class_21.log("No room found " + _loc3_ + ", " + _navigator.data.officialRooms.entries.length);
         return null;
      }
      
      private function refreshDetails(param1:class_1812, param2:class_2460) : void
      {
         var _loc3_:class_1812 = class_1812(param1.findChildByName("details_container"));
         _loc3_.visible = param2.showDetails;
         class_21.log("Refreshing details: " + _loc3_.visible);
         if(!param2.showDetails)
         {
            return;
         }
         Util.hideChildren(_loc3_);
         refreshEntryCaption(_loc3_,param2);
         refreshEntryDesc(_loc3_,param2);
      }
      
      private function refreshEntryCaption(param1:class_1812, param2:class_2460) : void
      {
         var _loc3_:ITextWindow = ITextWindow(param1.getChildByName("entry_caption"));
         _loc3_.visible = true;
         _loc3_.text = getPopupCaption(param2);
      }
      
      private function refreshEntryDesc(param1:class_1812, param2:class_2460) : void
      {
         var _loc4_:String = getPopupDesc(param2);
         if(_loc4_ == "")
         {
            return;
         }
         var _loc5_:ITextWindow = ITextWindow(param1.getChildByName("entry_desc"));
         _loc5_.text = _loc4_;
         _loc5_.visible = true;
      }
      
      public function getPopupCaption(param1:class_2460) : String
      {
         if(param1.popupCaption != null && param1.popupCaption != "")
         {
            return param1.popupCaption;
         }
         if(param1.guestRoomData != null)
         {
            return param1.guestRoomData.roomName;
         }
         if(param1.tag != null && param1.tag != "")
         {
            return param1.tag;
         }
         return "NA";
      }
      
      public function getPopupDesc(param1:class_2460) : String
      {
         if(param1.popupCaption != null && param1.popupCaption != "")
         {
            return param1.popupDesc;
         }
         if(param1.guestRoomData != null)
         {
            return param1.guestRoomData.description;
         }
         return "";
      }
   }
}

