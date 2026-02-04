package com.sulake.habbo.moderation
{
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_1775;
   import com.sulake.core.window.components.class_1885;
   import com.sulake.core.window.components.class_2250;
   import com.sulake.core.window.components.class_2261;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.core.window.utils.class_1750;
   import package_122.class_3058;
   import package_122.class_3143;
   import package_122.class_3274;
   import package_122.class_3379;
   import package_74.class_2004;
   import package_74.class_4039;
   
   public class RoomToolCtrl implements class_13, ITrackedWindow
   {
      
      private var _main:ModerationManager;
      
      private var _flatId:int;
      
      private var var_24:class_4039;
      
      private var _frame:class_2250;
      
      private var var_121:IItemListWindow;
      
      private var _disposed:Boolean;
      
      private var _msgSelect:class_2261;
      
      private var var_878:ITextFieldWindow;
      
      private var _includeInfo:Boolean = true;
      
      private var var_1582:class_1885;
      
      private var var_2345:class_1885;
      
      private var var_2449:class_1885;
      
      private var var_3799:class_1812;
      
      public function RoomToolCtrl(param1:ModerationManager, param2:int)
      {
         super();
         _main = param1;
         _flatId = param2;
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
      
      public static function moveChildrenToColumn(param1:class_1812, param2:int, param3:int) : void
      {
         var _loc4_:int = 0;
         var _loc5_:class_1741 = null;
         _loc4_ = 0;
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
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function show() : void
      {
         _frame = class_2250(_main.getXmlWindow("roomtool_frame"));
         var _loc1_:IItemListWindow = _frame.findChildByName("list_cont") as IItemListWindow;
         var _loc2_:class_1812 = _loc1_.getListItemByName("room_cont") as class_1812;
         var_3799 = _loc2_.findChildByName("room_data") as class_1812;
         _loc2_.removeChild(var_3799);
         _main.messageHandler.addRoomInfoListener(this);
         _main.connection.send(new class_3058(_flatId));
         class_21.log("BEGINNING TO SHOW: " + _flatId);
      }
      
      public function getType() : int
      {
         return 9;
      }
      
      public function getId() : String
      {
         return "" + _flatId;
      }
      
      public function getFrame() : class_2250
      {
         return _frame;
      }
      
      private function onClose(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         dispose();
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _disposed = true;
         _main.messageHandler.removeRoomEnterListener(this);
         if(_frame != null)
         {
            _frame.destroy();
            _frame = null;
         }
         if(var_24 != null)
         {
            var_24.dispose();
            var_24 = null;
         }
         _main = null;
         var_121 = null;
         _msgSelect = null;
         var_878 = null;
         var_1582 = null;
         var_2345 = null;
         var_2449 = null;
      }
      
      public function onRoomChange() : void
      {
         setSendButtonState("send_caution_but");
         setSendButtonState("send_message_but");
      }
      
      private function setSendButtonState(param1:String) : void
      {
         var _loc3_:Boolean = var_24 != null && var_24.flatId == _main.currentFlatId;
         var _loc2_:class_1775 = class_1775(_frame.findChildByName(param1));
         if(_loc3_ && _main.initMsg.roomAlertPermission)
         {
            _loc2_.enable();
         }
         else
         {
            _loc2_.disable();
         }
      }
      
      public function onRoomInfo(param1:class_4039) : void
      {
         if(_disposed)
         {
            return;
         }
         class_21.log("GOT ROOM INFO: " + param1.flatId + ", " + _flatId);
         if(param1.flatId != _flatId)
         {
            class_21.log("NOT THE SAME FLAT: " + param1.flatId + ", " + _flatId);
            return;
         }
         var_24 = param1;
         populate();
         _main.messageHandler.removeRoomInfoListener(this);
         _frame.visible = true;
         _main.messageHandler.addRoomEnterListener(this);
      }
      
      public function populate() : void
      {
         var_121 = IItemListWindow(_frame.findChildByName("list_cont"));
         var _loc1_:class_1741 = _frame.findChildByTag("close");
         _loc1_.procedure = onClose;
         var_878 = ITextFieldWindow(_frame.findChildByName("message_input"));
         var_878.procedure = onInputClick;
         _msgSelect = class_2261(_frame.findChildByName("msgTemplatesSelect"));
         prepareMsgSelect(_msgSelect);
         _msgSelect.procedure = onSelectTemplate;
         var_1582 = class_1885(_frame.findChildByName("kick_check"));
         var_2345 = class_1885(_frame.findChildByName("lock_check"));
         var_2449 = class_1885(_frame.findChildByName("changename_check"));
         refreshRoomData(var_24.room,"room_cont");
         setTxt("owner_name_txt",var_24.ownerName);
         setTxt("owner_in_room_txt",var_24.ownerInRoom ? "Yes" : "No");
         setTxt("user_count_txt","" + var_24.userCount);
         _frame.findChildByName("enter_room_but").procedure = onEnterRoom;
         _frame.findChildByName("chatlog_but").procedure = onChatlog;
         _frame.findChildByName("edit_in_hk_but").procedure = onEditInHk;
         _frame.findChildByName("send_caution_but").procedure = onSendCaution;
         _frame.findChildByName("send_message_but").procedure = onSendMessage;
         if(!_main.initMsg.roomKickPermission)
         {
            var_1582.disable();
         }
         _frame.findChildByName("owner_name_txt").procedure = onOwnerName;
         this.onRoomChange();
      }
      
      private function disposeItemFromList(param1:IItemListWindow, param2:class_1741) : void
      {
         var _loc3_:class_1741 = param1.removeListItem(param2);
         if(_loc3_ != null)
         {
            _loc3_.dispose();
         }
      }
      
      private function refreshRoomData(param1:class_2004, param2:String) : void
      {
         var _loc6_:class_1812 = class_1812(var_121.getListItemByName(param2));
         var _loc7_:class_1812 = class_1812(_loc6_.findChildByName("room_data"));
         if(_loc7_ == null)
         {
            _loc7_ = _loc6_.addChild(var_3799.clone()) as class_1812;
         }
         if(!param1.exists)
         {
            disposeItemFromList(var_121,_loc6_);
            disposeItemFromList(var_121,var_121.getListItemByName("event_spacing"));
            return;
         }
         var _loc4_:ITextWindow = ITextWindow(_loc7_.findChildByName("name"));
         _loc4_.caption = param1.name;
         _loc4_.height = _loc4_.textHeight + 5;
         var _loc3_:ITextWindow = ITextWindow(_loc7_.findChildByName("desc"));
         _loc3_.caption = param1.desc;
         _loc3_.height = _loc3_.textHeight + 5;
         var _loc5_:class_1812 = class_1812(_loc7_.findChildByName("tags_cont"));
         var _loc8_:ITextWindow = ITextWindow(_loc5_.findChildByName("tags_txt"));
         _loc8_.caption = getTagsAsString(param1.tags);
         _loc8_.height = _loc8_.textHeight + 5;
         _loc5_.height = _loc8_.height;
         if(param1.tags.length < 1)
         {
            _loc7_.removeChild(_loc5_);
         }
         moveChildrenToColumn(_loc7_,_loc4_.y,0);
         _loc7_.height = getLowestPoint(_loc7_);
         _loc6_.height = _loc7_.height + 2 * _loc7_.y;
         class_21.log("XXXX: " + _loc6_.height + ", " + _loc7_.height + ", " + _loc4_.height + ", " + _loc3_.height + ", " + _loc5_.height + ", " + _loc8_.height);
      }
      
      private function getTagsAsString(param1:Array) : String
      {
         var _loc3_:* = null;
         var _loc2_:String = "";
         for each(_loc3_ in param1)
         {
            if(_loc2_ == "")
            {
               _loc2_ = _loc3_;
            }
            else
            {
               _loc2_ = _loc2_ + ", " + _loc3_;
            }
         }
         return _loc2_;
      }
      
      private function setTxt(param1:String, param2:String) : void
      {
         var _loc3_:ITextWindow = ITextWindow(_frame.findChildByName(param1));
         _loc3_.text = param2;
      }
      
      private function onOwnerName(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         _main.windowTracker.show(new UserInfoFrameCtrl(_main,var_24.ownerId),_frame,false,false,true);
      }
      
      private function onEnterRoom(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         class_21.log("Enter room clicked");
         _main.goToRoom(var_24.flatId);
      }
      
      private function onChatlog(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         _main.windowTracker.show(new ChatlogCtrl(new class_3143(0,var_24.flatId),_main,4,var_24.flatId),_frame,false,false,true);
      }
      
      private function onEditInHk(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         class_21.log("Edit in hk clicked");
         _main.openHkPage("roomadmin.url","" + var_24.flatId);
      }
      
      private function onSendCaution(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         class_21.log("Sending caution...");
         act(true);
      }
      
      private function onSendMessage(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         class_21.log("Sending message...");
         act(false);
      }
      
      private function act(param1:Boolean) : void
      {
         if(_includeInfo || var_878.text == "")
         {
            _main.windowManager.alert("Alert","You must input a message to the user",0,onAlertClose);
            return;
         }
         var _loc2_:int = determineAction(param1,var_1582.isSelected);
         _main.connection.send(new class_3274(_loc2_,var_878.text,""));
         if(var_2345.isSelected || Boolean(var_2449.isSelected) || Boolean(var_1582.isSelected))
         {
            _main.connection.send(new class_3379(var_24.flatId,var_2345.isSelected,var_2449.isSelected,var_1582.isSelected));
         }
         this.dispose();
      }
      
      private function determineAction(param1:Boolean, param2:Boolean) : int
      {
         if(param2)
         {
            return param1 ? 1 : 4;
         }
         return param1 ? 0 : 3;
      }
      
      private function onInputClick(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type != "WE_FOCUSED")
         {
            return;
         }
         if(!_includeInfo)
         {
            return;
         }
         var_878.text = "";
         _includeInfo = false;
      }
      
      private function onAlertClose(param1:class_1750, param2:class_1758) : void
      {
         param1.dispose();
      }
      
      private function prepareMsgSelect(param1:class_2261) : void
      {
         class_21.log("MSG TEMPLATES: " + _main.initMsg.roomMessageTemplates.length);
         param1.populate(_main.initMsg.roomMessageTemplates);
      }
      
      private function onSelectTemplate(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type != "WE_SELECTED")
         {
            return;
         }
         var _loc3_:String = _main.initMsg.roomMessageTemplates[_msgSelect.selection];
         if(_loc3_ != null)
         {
            _includeInfo = false;
            var_878.text = _loc3_;
         }
      }
   }
}

