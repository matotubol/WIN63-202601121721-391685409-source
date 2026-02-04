package com.sulake.habbo.ui.handler
{
   import com.sulake.habbo.room.events.RoomEngineAreaHideStateWidgetEvent;
   import com.sulake.habbo.room.events.RoomEngineObjectEvent;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.IRoomWidgetHandlerContainer;
   import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
   import com.sulake.habbo.ui.widget.furniture.areahide.AreaHideFurniWidget;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
   import com.sulake.room.object.IRoomObject;
   import com.sulake.room.object.IRoomObjectModel;
   import flash.events.Event;
   
   public class FurnitureAreaHideWidgetHandler implements IRoomWidgetHandler
   {
      
      private var var_1134:Boolean = false;
      
      private var var_16:AreaHideFurniWidget;
      
      private var _container:IRoomWidgetHandlerContainer;
      
      public function FurnitureAreaHideWidgetHandler()
      {
         super();
      }
      
      public function get disposed() : Boolean
      {
         return var_1134;
      }
      
      public function dispose() : void
      {
         if(!var_1134)
         {
            container = null;
            var_1134 = true;
         }
      }
      
      public function get type() : String
      {
         return "RWE_AREA_HIDE";
      }
      
      public function set widget(param1:AreaHideFurniWidget) : void
      {
         var_16 = param1;
      }
      
      public function get container() : IRoomWidgetHandlerContainer
      {
         return _container;
      }
      
      public function set container(param1:IRoomWidgetHandlerContainer) : void
      {
         _container = param1;
      }
      
      public function getWidgetMessages() : Array
      {
         return null;
      }
      
      public function processWidgetMessage(param1:RoomWidgetMessage) : RoomWidgetUpdateEvent
      {
         return null;
      }
      
      public function getProcessedEvents() : Array
      {
         var _loc1_:Array = [];
         _loc1_.push("RETWE_REQUEST_AREA_HIDE");
         _loc1_.push("RETWE_UPDATE_STATE_AREA_HIDE");
         return _loc1_;
      }
      
      public function processEvent(param1:Event) : void
      {
         var _loc4_:RoomEngineObjectEvent = null;
         var _loc9_:IRoomObject = null;
         var _loc13_:IRoomObjectModel = null;
         var _loc11_:Boolean = false;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc12_:int = 0;
         var _loc5_:int = 0;
         var _loc2_:* = false;
         var _loc10_:* = false;
         var _loc3_:* = false;
         switch(param1.type)
         {
            case "RETWE_REQUEST_AREA_HIDE":
               if(validateRights())
               {
                  _loc4_ = param1 as RoomEngineObjectEvent;
                  _loc9_ = _container.roomEngine.getRoomObject(_loc4_.roomId,_loc4_.objectId,_loc4_.category);
                  _loc13_ = _loc9_.getModel();
                  _loc11_ = Boolean(_loc9_.getState(0));
                  _loc7_ = _loc13_.getNumber("furniture_area_hide_root_x");
                  _loc8_ = _loc13_.getNumber("furniture_area_hide_root_y");
                  _loc12_ = _loc13_.getNumber("furniture_area_hide_width");
                  _loc5_ = _loc13_.getNumber("furniture_area_hide_length");
                  _loc2_ = _loc13_.getNumber("furniture_area_hide_invisibility") == 1;
                  _loc10_ = _loc13_.getNumber("furniture_area_hide_wallitems") == 1;
                  _loc3_ = _loc13_.getNumber("furniture_area_hide_invert") == 1;
                  var_16.open(_loc9_.getId(),_loc11_,_loc7_,_loc8_,_loc12_,_loc5_,_loc2_,_loc10_,_loc3_);
               }
               break;
            case "RETWE_UPDATE_STATE_AREA_HIDE":
               var _loc6_:RoomEngineAreaHideStateWidgetEvent = param1 as RoomEngineAreaHideStateWidgetEvent;
               var_16.updateStatus(null.objectId,null.isOn);
         }
      }
      
      private function validateRights() : Boolean
      {
         var _loc1_:Boolean = _container.roomSession.isRoomOwner;
         var _loc2_:* = _container.roomSession.roomControllerLevel >= 1;
         var _loc3_:Boolean = _container.sessionDataManager.isAnyRoomController;
         return _loc1_ || _loc3_ || _loc2_;
      }
      
      public function update() : void
      {
      }
   }
}

