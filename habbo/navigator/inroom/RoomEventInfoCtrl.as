package com.sulake.habbo.navigator.inroom
{
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.navigator.class_42;
   import com.sulake.habbo.session.IRoomSession;
   import com.sulake.habbo.communication.messages.incoming.navigator.class_2842;
   
   public class RoomEventInfoCtrl implements class_13
   {
      
      private static const TOOLBAR_EXTENSION_ID:String = "room_event_info";
      
      private var _navigator:class_42;
      
      private var _window:class_1812;
      
      private var _expanded:Boolean = true;
      
      public function RoomEventInfoCtrl(param1:class_42)
      {
         super();
         _navigator = param1;
      }
      
      private function get enabled() : Boolean
      {
         var _loc1_:Boolean = _navigator.getInteger("new.identity",0) == 0 || !_navigator.getBoolean("new.identity.hide.ui");
         return _navigator.getBoolean("eventinfo.enabled") && _loc1_;
      }
      
      public function dispose() : void
      {
         if(_navigator)
         {
            _navigator.toolbar.extensionView.detachExtension("room_event_info");
         }
         _navigator = null;
         if(_window)
         {
            _window.dispose();
            _window = null;
         }
      }
      
      public function get disposed() : Boolean
      {
         return _navigator == null;
      }
      
      public function refresh() : void
      {
         if(_navigator.toolbar == null || _navigator.toolbar.extensionView == null || !enabled)
         {
            return;
         }
         var _loc5_:* = _navigator.data.roomEventData != null;
         var _loc8_:Boolean = _navigator.data.currentRoomOwner || _navigator.data.eventMod;
         var _loc10_:int = _navigator.data.currentRoomId;
         var _loc11_:IRoomSession = _navigator.roomSessionManager.getSession(_loc10_);
         if(!_loc11_)
         {
            return;
         }
         if(_loc11_.roomControllerLevel == 1)
         {
            _loc8_ = true;
         }
         var _loc2_:Boolean = _navigator.data.currentRoomOwner;
         if(!_loc5_ && !_loc2_ && !_loc8_)
         {
            _navigator.toolbar.extensionView.detachExtension("room_event_info");
            return;
         }
         prepareWindow();
         var _loc7_:Boolean = _expanded && _loc5_ && _loc2_;
         _window.findChildByName("event_bg_owner").visible = _loc7_;
         var _loc1_:Boolean = _expanded && _loc5_ && !_loc2_;
         _window.findChildByName("event_bg_visitor").visible = _loc1_;
         var _loc3_:Boolean = !_expanded || !_loc5_;
         _window.findChildByName("event_bg_contracted").visible = _loc3_;
         var _loc4_:Boolean = _expanded && _loc5_ && _loc8_;
         _window.findChildByName("modify_link_region").visible = _loc4_;
         _window.findChildByName("extend_event_region").visible = _loc4_ && canExtend();
         var _loc12_:Boolean = !_loc5_ && _loc8_;
         _window.findChildByName("get_event").visible = _loc12_;
         _window.findChildByName("create_link").visible = false;
         var _loc6_:Boolean = _expanded && _loc5_ && !_loc8_;
         _window.findChildByName("in_progress_txt").visible = _loc6_;
         var _loc9_:Boolean = _expanded && _loc5_;
         _window.findChildByName("desc_txt").visible = _loc9_;
         _window.findChildByName("header_txt").visible = _loc5_;
         _window.visible = _loc5_ && (_loc7_ || _loc1_ || _loc3_ || _loc4_ || _loc6_ || _loc9_) || _loc12_;
         if(_loc5_)
         {
            _window.findChildByName("header_txt").caption = _navigator.data.roomEventData.eventName;
            _window.findChildByName("desc_txt").caption = _navigator.data.roomEventData.eventDescription;
         }
         _navigator.toolbar.extensionView.attachExtension("room_event_info",_window,-1,["next_quest_timer","quest_tracker"]);
         _window.x = 0;
         _window.y = 0;
         _window.height = _expanded && _loc5_ ? _window.findChildByName("event_bg_visitor").height : int(_window.findChildByName("event_bg_contracted").height);
      }
      
      private function canExtend() : Boolean
      {
         var _loc2_:class_2842 = _navigator.data.roomEventData;
         if(_loc2_ == null)
         {
            return false;
         }
         if(!_navigator.getBoolean("roomad.limit_total_time"))
         {
            return true;
         }
         var _loc5_:Date = new Date();
         var _loc1_:Number = Number(_loc5_.getTime());
         var _loc6_:Date = _loc2_.expirationDate;
         var _loc3_:int = _navigator.getInteger("room_ad.duration.minutes",120);
         var _loc4_:int = _navigator.getInteger("room_ad.maximum_total_time.minutes",10080);
         return _loc6_.getTime() + _loc3_ * 60 * 1000 < _loc1_ + _loc4_ * 60 * 1000;
      }
      
      private function onGetEventClick(param1:class_1758) : void
      {
         if(_navigator.data.roomEventData != null)
         {
            _expanded = !_expanded;
            refresh();
         }
         else
         {
            _navigator.openCatalogRoomAdsPage();
         }
      }
      
      private function prepareWindow() : void
      {
         if(this._window != null)
         {
            return;
         }
         _window = class_1812(_navigator.getXmlWindow("iro_event_info"));
         _window.findChildByName("modify_link_region").procedure = onModify;
         _window.findChildByName("extend_event_region").procedure = onExtend;
         _window.findChildByName("bg_region").addEventListener("WME_CLICK",onGetEventClick);
      }
      
      public function close() : void
      {
         if(_window != null && Boolean(_window.visible))
         {
            _window.visible = false;
            _navigator.toolbar.extensionView.detachExtension("room_event_info");
         }
      }
      
      private function onModify(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type == "WME_CLICK")
         {
            _navigator.roomEventViewCtrl.show();
         }
      }
      
      private function onExtend(param1:class_1758, param2:class_1741) : void
      {
         var _loc3_:class_2842 = null;
         if(param1.type == "WME_CLICK")
         {
            _loc3_ = _navigator.data.roomEventData;
            _navigator.openCatalogRoomAdsExtendPage(_loc3_.eventName,_loc3_.eventDescription,_loc3_.expirationDate,_loc3_.categoryId);
         }
      }
      
      public function set expanded(param1:Boolean) : void
      {
         _expanded = param1;
      }
   }
}

