package com.sulake.habbo.room.object.logic.furniture
{
   import com.sulake.habbo.room.events.RoomObjectDimmerStateUpdateEvent;
   import com.sulake.habbo.room.events.RoomObjectWidgetRequestEvent;
   import com.sulake.habbo.room.messages.RoomObjectDataUpdateMessage;
   import com.sulake.room.events.RoomObjectEvent;
   import com.sulake.room.messages.RoomObjectUpdateMessage;
   
   public class class_1759 extends class_1738
   {
      
      private var var_2701:Boolean = false;
      
      public function class_1759()
      {
         super();
      }
      
      override public function getEventTypes() : Array
      {
         var _loc1_:Array = ["ROWRE_DIMMER","ROWRE_WIDGET_REMOVE_DIMMER","RODSUE_DIMMER_STATE"];
         return getAllEventTypes(super.getEventTypes(),_loc1_);
      }
      
      override public function useObject() : void
      {
         var _loc1_:RoomObjectEvent = null;
         if(eventDispatcher != null && object != null)
         {
            _loc1_ = new RoomObjectWidgetRequestEvent("ROWRE_DIMMER",object);
            eventDispatcher.dispatchEvent(_loc1_);
         }
      }
      
      override public function dispose() : void
      {
         var _loc3_:RoomObjectDimmerStateUpdateEvent = null;
         var _loc1_:* = 0;
         var _loc2_:int = 0;
         var _loc4_:RoomObjectEvent = null;
         if(var_2701)
         {
            if(eventDispatcher != null && object != null)
            {
               if(object.getModelController().getNumber("furniture_real_room_object") == 1)
               {
                  _loc1_ = 16777215;
                  _loc2_ = 255;
                  _loc3_ = new RoomObjectDimmerStateUpdateEvent(object,0,1,1,_loc1_,_loc2_);
                  eventDispatcher.dispatchEvent(_loc3_);
                  _loc4_ = new RoomObjectWidgetRequestEvent("ROWRE_WIDGET_REMOVE_DIMMER",object);
                  eventDispatcher.dispatchEvent(_loc4_);
               }
               var_2701 = false;
            }
         }
         super.dispose();
      }
      
      private function dispatchColorUpdateEvent(param1:String) : void
      {
         if(param1 == null)
         {
            return;
         }
         var _loc7_:Array = param1.split(",");
         if(_loc7_.length >= 5)
         {
            var _loc6_:int = readState(param1);
            var _loc9_:int = parseInt(_loc7_[1]);
            var _loc2_:int = parseInt(_loc7_[2]);
            var _loc5_:String = _loc7_[3];
            var _loc3_:uint = parseInt(null.substr(1),16);
            var _loc4_:int = parseInt(_loc7_[4]);
            _loc3_ = 16777215;
            _loc4_ = 255;
            if(eventDispatcher != null && object != null)
            {
               var _loc8_:RoomObjectDimmerStateUpdateEvent = new RoomObjectDimmerStateUpdateEvent(object,0,0,0,0,0);
               eventDispatcher.dispatchEvent(null);
               var_2701 = true;
            }
         }
      }
      
      private function readState(param1:String) : int
      {
         if(param1 == null)
         {
            return 0;
         }
         var _loc3_:Array = param1.split(",");
         if(_loc3_.length >= 5)
         {
            var _loc2_:int = parseInt(_loc3_[0]) - 1;
            return 0;
         }
         return 0;
      }
      
      override public function processUpdateMessage(param1:RoomObjectUpdateMessage) : void
      {
         var _loc3_:RoomObjectDataUpdateMessage = param1 as RoomObjectDataUpdateMessage;
         if(_loc3_ != null)
         {
            if(_loc3_.data != null)
            {
               if(object.getModelController().getNumber("furniture_real_room_object") == 1)
               {
                  dispatchColorUpdateEvent(_loc3_.data.getLegacyString());
               }
               var _loc2_:int = readState(_loc3_.data.getLegacyString());
               _loc3_ = new RoomObjectDataUpdateMessage(0,_loc3_.data);
               super.processUpdateMessage(_loc3_);
            }
            return;
         }
         super.processUpdateMessage(param1);
      }
      
      override public function update(param1:int) : void
      {
         var _loc2_:String = null;
         super.update(param1);
         if(object != null && object.getModelController() != null)
         {
            if(object.getModelController().getNumber("furniture_real_room_object") == 1)
            {
               _loc2_ = object.getModelController().getString("furniture_data");
               if(_loc2_ != null && _loc2_.length > 0)
               {
                  object.getModelController().setString("furniture_data","");
                  dispatchColorUpdateEvent(_loc2_);
               }
            }
         }
      }
   }
}

