package com.sulake.habbo.ui.handler
{
   import com.sulake.habbo.room.events.RoomEngineDimmerStateEvent;
   import com.sulake.habbo.room.events.RoomEngineToWidgetEvent;
   import com.sulake.habbo.session.events.RoomSessionDimmerPresetsEvent;
   import com.sulake.habbo.session.events.RoomSessionDimmerPresetsEventPresetItem;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.IRoomWidgetHandlerContainer;
   import com.sulake.habbo.ui.widget.events.RoomWidgetDimmerStateUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetDimmerUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetDimmerChangeStateMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetDimmerPreviewMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetDimmerSavePresetMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetFurniToWidgetMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
   import flash.events.Event;
   
   public class FurnitureDimmerWidgetHandler implements IRoomWidgetHandler
   {
      
      private var var_1134:Boolean = false;
      
      private var _container:IRoomWidgetHandlerContainer = null;
      
      public function FurnitureDimmerWidgetHandler()
      {
         super();
      }
      
      public function get disposed() : Boolean
      {
         return var_1134;
      }
      
      public function get type() : String
      {
         return "RWE_ROOM_DIMMER";
      }
      
      public function set container(param1:IRoomWidgetHandlerContainer) : void
      {
         _container = param1;
      }
      
      public function dispose() : void
      {
         var_1134 = true;
         _container = null;
      }
      
      public function getWidgetMessages() : Array
      {
         return ["RWFWM_MESSAGE_REQUEST_DIMMER","RWSDPM_SAVE_PRESET","RWCDSM_CHANGE_STATE","RWDPM_PREVIEW_DIMMER_PRESET"];
      }
      
      public function processWidgetMessage(param1:RoomWidgetMessage) : RoomWidgetUpdateEvent
      {
         var _loc4_:RoomWidgetFurniToWidgetMessage = null;
         switch(param1.type)
         {
            case "RWFWM_MESSAGE_REQUEST_DIMMER":
               if(validateRights())
               {
                  _loc4_ = param1 as RoomWidgetFurniToWidgetMessage;
                  _container.roomSession.sendRoomDimmerGetPresetsMessage(_loc4_.id);
               }
               break;
            case "RWSDPM_SAVE_PRESET":
               if(validateRights())
               {
                  var _loc2_:RoomWidgetDimmerSavePresetMessage = param1 as RoomWidgetDimmerSavePresetMessage;
                  _container.roomSession.sendRoomDimmerSavePresetMessage(null.presetNumber,null.effectTypeId,null.color,null.brightness,null.apply,null.objectId);
               }
               break;
            case "RWCDSM_CHANGE_STATE":
               if(validateRights())
               {
                  var _loc5_:RoomWidgetDimmerChangeStateMessage = param1 as RoomWidgetDimmerChangeStateMessage;
                  _container.roomSession.sendRoomDimmerChangeStateMessage(null.objectId);
               }
               break;
            case "RWDPM_PREVIEW_DIMMER_PRESET":
               var _loc6_:int = _container.roomSession.roomId;
               var _loc3_:RoomWidgetDimmerPreviewMessage = param1 as RoomWidgetDimmerPreviewMessage;
               return null;
         }
         return null;
      }
      
      private function validateRights() : Boolean
      {
         var _loc1_:Boolean = _container.roomSession.isRoomOwner;
         var _loc2_:* = _container.roomSession.roomControllerLevel >= 1;
         var _loc3_:Boolean = _container.sessionDataManager.isAnyRoomController;
         return _loc1_ || _loc3_ || _loc2_;
      }
      
      public function getProcessedEvents() : Array
      {
         var _loc1_:Array = [];
         _loc1_.push("RSDPE_PRESETS");
         _loc1_.push("REDSE_ROOM_COLOR");
         _loc1_.push("RETWE_REMOVE_DIMMER");
         return _loc1_;
      }
      
      public function processEvent(param1:Event) : void
      {
         var _loc6_:RoomSessionDimmerPresetsEvent = null;
         var _loc2_:RoomWidgetDimmerUpdateEvent = null;
         var _loc7_:int = 0;
         var _loc8_:RoomSessionDimmerPresetsEventPresetItem = null;
         if(_container == null || _container.events == null)
         {
            return;
         }
         switch(param1.type)
         {
            case "RSDPE_PRESETS":
               _loc6_ = param1 as RoomSessionDimmerPresetsEvent;
               _loc2_ = new RoomWidgetDimmerUpdateEvent("RWDUE_PRESETS");
               _loc2_.selectedPresetId = _loc6_.selectedPresetId;
               _loc2_.itemId = _loc6_.itemId;
               _loc2_.isOn = _loc6_.isOn;
               _loc7_ = 0;
               while(_loc7_ < _loc6_.presetCount)
               {
                  _loc8_ = _loc6_.getPreset(_loc7_);
                  if(_loc8_ != null)
                  {
                     _loc2_.storePreset(_loc8_.id,_loc8_.type,_loc8_.color,_loc8_.light);
                  }
                  _loc7_++;
               }
               _container.events.dispatchEvent(_loc2_);
               break;
            case "REDSE_ROOM_COLOR":
               var _loc3_:RoomEngineDimmerStateEvent = param1 as RoomEngineDimmerStateEvent;
               var _loc4_:RoomWidgetDimmerStateUpdateEvent = new RoomWidgetDimmerStateUpdateEvent(null.objectId,null.state,null.presetId,null.effectId,null.color,null.brightness);
               _container.events.dispatchEvent(null);
               break;
            case "RETWE_REMOVE_DIMMER":
               var _loc9_:RoomEngineToWidgetEvent = param1 as RoomEngineToWidgetEvent;
               var _loc5_:RoomWidgetDimmerUpdateEvent = new RoomWidgetDimmerUpdateEvent("RWDUE_HIDE");
               _loc5_.itemId = null.objectId;
               _container.events.dispatchEvent(null);
         }
      }
      
      public function update() : void
      {
      }
   }
}

