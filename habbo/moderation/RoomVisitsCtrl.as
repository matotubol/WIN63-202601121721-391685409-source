package com.sulake.habbo.moderation
{
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_2250;
   import com.sulake.core.window.events.class_1758;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import package_122.class_3492;
   import package_74.class_3766;
   import package_74.class_3840;
   
   public class RoomVisitsCtrl implements class_13, ITrackedWindow
   {
      
      private static var ROOM_ROW_POOL_MAX_SIZE:int = 200;
      
      private static var ROOM_ROW_POOL:Array = [];
      
      private var _main:ModerationManager;
      
      private var _frame:class_2250;
      
      private var var_121:IItemListWindow;
      
      private var var_1270:int;
      
      private var _rooms:Array;
      
      private var _disposed:Boolean;
      
      private var var_1339:class_1812;
      
      private var var_908:Timer;
      
      private var var_2430:Array = [];
      
      public function RoomVisitsCtrl(param1:ModerationManager, param2:int)
      {
         super();
         _main = param1;
         var_1270 = param2;
      }
      
      public static function getFormattedTime(param1:int, param2:int) : String
      {
         return padToTwoDigits(param1) + ":" + padToTwoDigits(param2);
      }
      
      public static function padToTwoDigits(param1:int) : String
      {
         return param1 < 10 ? "0" + param1 : "" + param1;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function show() : void
      {
         var_908 = new Timer(300,1);
         var_908.addEventListener("timer",onResizeTimer);
         _main.messageHandler.addRoomVisitsListener(this);
         _main.connection.send(new class_3492(var_1270));
         _frame = class_2250(_main.getXmlWindow("roomvisits_frame"));
         var_121 = IItemListWindow(_frame.findChildByName("visits_list"));
         var_1339 = var_121.getListItemAt(0) as class_1812;
         var_121.removeListItems();
         _frame.procedure = onWindow;
         var _loc1_:class_1741 = _frame.findChildByTag("close");
         _loc1_.procedure = onClose;
      }
      
      public function onRoomVisits(param1:class_3766) : void
      {
         if(param1.userId != var_1270)
         {
            return;
         }
         if(_disposed)
         {
            return;
         }
         this._rooms = param1.rooms;
         _frame.caption = "Room visits: " + param1.userName;
         populate();
         onResizeTimer(null);
         _frame.visible = true;
         _main.messageHandler.removeRoomVisitsListener(this);
      }
      
      public function getType() : int
      {
         return 6;
      }
      
      public function getId() : String
      {
         return "" + var_1270;
      }
      
      public function getFrame() : class_2250
      {
         return _frame;
      }
      
      private function populate() : void
      {
         var _loc2_:* = null;
         var _loc1_:* = true;
         for each(_loc2_ in _rooms)
         {
            populateRoomRow(_loc2_,_loc1_);
            _loc1_ = !_loc1_;
         }
      }
      
      private function populateRoomRow(param1:class_3840, param2:Boolean) : void
      {
         var _loc4_:class_1812 = getRoomRowWindow();
         var _loc3_:uint = param2 ? 4288861930 : 4294967295;
         _loc4_.color = _loc3_;
         var _loc7_:class_1741 = _loc4_.findChildByName("room_name_txt");
         _loc7_.caption = param1.roomName;
         new OpenRoomTool(_frame,_main,_loc7_,param1.roomId);
         _loc7_.color = _loc3_;
         var _loc5_:ITextWindow = ITextWindow(_loc4_.findChildByName("time_txt"));
         _loc5_.text = getFormattedTime(param1.enterHour,param1.enterMinute);
         var _loc6_:ITextWindow = ITextWindow(_loc4_.findChildByName("view_room_txt"));
         new OpenRoomInSpectatorMode(_main,_loc6_,param1.roomId);
         _loc6_.color = _loc3_;
         addRoomRowToList(_loc4_,var_121);
      }
      
      private function addRoomRowToList(param1:class_1812, param2:IItemListWindow) : void
      {
         param2.addListItem(param1);
         var_2430.push(param1);
      }
      
      private function getRoomRowWindow() : class_1812
      {
         if(ROOM_ROW_POOL.length > 0)
         {
            return ROOM_ROW_POOL.pop() as class_1812;
         }
         return class_1812(var_1339.clone());
      }
      
      private function storeRoomRowWindow(param1:class_1812) : void
      {
         var _loc3_:class_1741 = null;
         var _loc2_:class_1741 = null;
         if(ROOM_ROW_POOL.length < ROOM_ROW_POOL_MAX_SIZE)
         {
            _loc3_ = param1.findChildByName("room_name_txt");
            _loc3_.procedure = null;
            _loc2_ = param1.findChildByName("view_room_txt");
            _loc2_.procedure = null;
            param1.width = var_1339.width;
            param1.height = var_1339.height;
            ROOM_ROW_POOL.push(param1);
         }
         else
         {
            param1.dispose();
         }
      }
      
      private function onClose(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         dispose();
      }
      
      private function onWindow(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type != "WE_RESIZED" || param2 != _frame)
         {
            return;
         }
         if(!this.var_908.running)
         {
            this.var_908.reset();
            this.var_908.start();
         }
      }
      
      private function onResizeTimer(param1:TimerEvent) : void
      {
         var _loc3_:class_1812 = class_1812(var_121.parent);
         var _loc5_:class_1741 = _loc3_.getChildByName("scroller") as class_1741;
         var _loc4_:* = var_121.scrollableRegion.height > var_121.height;
         if(_loc5_.visible)
         {
            if(!_loc4_)
            {
               _loc5_.visible = false;
               var_121.width += 17;
            }
         }
         else if(_loc4_)
         {
            _loc5_.visible = true;
            var_121.width -= 17;
         }
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _disposed = true;
         if(var_121 != null)
         {
            var_121.removeListItems();
            var_121.dispose();
            var_121 = null;
         }
         if(_frame != null)
         {
            _frame.destroy();
            _frame = null;
         }
         _main = null;
         if(var_908 != null)
         {
            var_908.stop();
            var_908.removeEventListener("timer",onResizeTimer);
            var_908 = null;
         }
         for each(var _loc1_ in var_2430)
         {
            storeRoomRowWindow(null);
         }
         if(var_1339 != null)
         {
            var_1339.dispose();
            var_1339 = null;
         }
         var_2430 = [];
      }
   }
}

