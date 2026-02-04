package com.sulake.habbo.ui.widget.roomtools
{
   import com.sulake.core.assets.class_40;
   import com.sulake.core.window.class_1741;
   import com.sulake.habbo.freeflowchat.class_51;
   import com.sulake.habbo.ui.IRoomDesktop;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.RoomUI;
   import com.sulake.habbo.ui.handler.RoomToolsWidgetHandler;
   import com.sulake.habbo.ui.widget.RoomWidgetBase;
   import com.sulake.habbo.ui.widget.chatinput.RoomChatInputWidget;
   import com.sulake.habbo.utils.StringUtil;
   import com.sulake.habbo.window.class_38;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import package_42.class_1945;
   
   public class RoomToolsWidget extends RoomWidgetBase
   {
      
      private static const ROOM_HISTORY_MAX_LENGTH:int = 10;
      
      private static var var_2143:int;
      
      private static var _visitedRooms:Vector.<class_1945> = new Vector.<class_1945>();
      
      private var _currentRoomName:String = "";
      
      private var var_140:RoomToolsToolbarCtrl;
      
      private var var_714:RoomToolsInfoCtrl;
      
      private var var_22:IRoomDesktop;
      
      private var var_1560:class_51;
      
      private var var_1103:Timer;
      
      public function RoomToolsWidget(param1:IRoomWidgetHandler, param2:class_38, param3:class_40, param4:RoomUI)
      {
         super(param1,param2,param3,param4.localization);
         handler.widget = this;
         var_22 = param4.desktop;
         var_1560 = param4.freeFlowChat;
         var_714 = new RoomToolsInfoCtrl(this,param2,param3);
         var_140 = new RoomToolsToolbarCtrl(this,param2,param3);
         var_140.updateRoomHistoryButtons();
         var_140.setChatHistoryButton(!var_1560 || !var_1560.isDisabledInPreferences);
         var _loc5_:String = param4.getProperty("camera.launch.ui.position");
         var_140.setCameraButton(handler.container.sessionDataManager.isPerkAllowed("CAMERA") && (StringUtil.isBlank(_loc5_) || _loc5_ == "room-menu"));
         var_140.setLikeButton(handler.canRate);
         var_140.setCollapsed(handler.sessionDataManager.isNoob || !(handler.sessionDataManager.uiFlags & 2));
      }
      
      override public function dispose() : void
      {
         if(var_1103)
         {
            var_1103.stop();
            var_1103 = null;
         }
         if(var_140)
         {
            var_140.dispose();
            var_140 = null;
         }
         if(var_714)
         {
            var_714.dispose();
            var_714 = null;
         }
         var_1560 = null;
         var_22 = null;
         super.dispose();
      }
      
      public function updateRoomData(param1:class_1945) : void
      {
         for each(var _loc2_ in _visitedRooms)
         {
            if(_loc2_.flatId == param1.flatId)
            {
               _loc2_.roomName = param1.roomName;
            }
         }
      }
      
      public function storeRoomData(param1:class_1945) : void
      {
         for each(var _loc2_ in _visitedRooms)
         {
            if(_loc2_.flatId == param1.flatId)
            {
               return;
            }
         }
         _visitedRooms.push(param1);
         if(_visitedRooms.length > 10)
         {
            _visitedRooms.shift();
         }
         var_2143 = _visitedRooms.length - 1;
         if(var_140)
         {
            var_140.setLikeButton(handler.canRate);
         }
      }
      
      public function showRoomInfo(param1:Boolean, param2:String, param3:String, param4:Array) : void
      {
         if(!var_714)
         {
            return;
         }
         _currentRoomName = param2;
         var_714.showRoomInfo(param1,param2,param3,param4);
      }
      
      public function enterNewRoom(param1:int) : void
      {
         if(!var_140 || !var_714)
         {
            return;
         }
         var _loc3_:int = 0;
         for each(var _loc2_ in _visitedRooms)
         {
            if(_loc2_.flatId == param1)
            {
               var_2143 = _loc3_;
            }
            _loc3_++;
         }
         var_140.disableRoomHistoryButtons();
         if(var_1103 != null)
         {
            var_1103.stop();
         }
         var_1103 = new Timer(2000,1);
         var_1103.addEventListener("timer",roomButtonTimerEventHandler);
         var_1103.start();
         var_714.setElementVisible("tags",true);
      }
      
      private function roomButtonTimerEventHandler(param1:TimerEvent) : void
      {
         var _loc2_:Timer = param1.target as Timer;
         if(_loc2_)
         {
            _loc2_.stop();
            _loc2_.removeEventListener("timer",roomButtonTimerEventHandler);
         }
         if(var_140)
         {
            var_140.updateRoomHistoryButtons();
         }
      }
      
      public function setCollapsed(param1:Boolean) : void
      {
         if(var_140)
         {
            var_140.setCollapsed(param1);
         }
         if(var_714)
         {
            var_714.setToolbarCollapsed(param1);
         }
      }
      
      public function get handler() : RoomToolsWidgetHandler
      {
         return var_41 as RoomToolsWidgetHandler;
      }
      
      public function getIconLocation(param1:String) : class_1741
      {
         return var_140.window.findChildByName(param1);
      }
      
      public function getWidgetAreaWidth() : int
      {
         return var_140 ? var_140.right : 0;
      }
      
      public function getChatInputY() : int
      {
         if(!var_22)
         {
            return 0;
         }
         var _loc1_:RoomChatInputWidget = var_22.getWidget("RWE_CHAT_INPUT_WIDGET") as RoomChatInputWidget;
         if(!_loc1_)
         {
            return 0;
         }
         return _loc1_.getChatInputY();
      }
      
      public function getRoomToolbarRight() : int
      {
         return var_140 ? var_140.right : 0;
      }
      
      public function goToNextRoom() : void
      {
         var _loc1_:int = var_2143 + 1;
         var _loc2_:int = int(_visitedRooms.length);
         if(_loc1_ > _loc2_)
         {
            _loc1_ = _loc2_;
         }
         handler.goToPrivateRoom(_visitedRooms[_loc1_].flatId);
         var_140.disableRoomHistoryButtons();
      }
      
      public function goToPreviousRoom() : void
      {
         var _loc1_:int = var_2143 - 1;
         if(_loc1_ < 0)
         {
            _loc1_ = 0;
         }
         handler.goToPrivateRoom(_visitedRooms[_loc1_].flatId);
         var_140.disableRoomHistoryButtons();
      }
      
      public function get freeFlowChat() : class_51
      {
         return var_1560;
      }
      
      public function get visitedRooms() : Vector.<class_1945>
      {
         return _visitedRooms;
      }
      
      public function get currentRoomIndex() : int
      {
         return var_2143;
      }
      
      public function get currentRoomName() : String
      {
         return _currentRoomName;
      }
      
      override public function release() : void
      {
         var_140.release();
         var_140.visible = false;
         var_714.hide();
         var_1560.visible = false;
         super.release();
      }
      
      override public function reuse(param1:IRoomDesktop) : void
      {
         super.reuse(param1);
         var_22 = param1;
         var_140.visible = true;
      }
   }
}

