package com.sulake.habbo.room.object.logic.furniture
{
   import com.sulake.habbo.room.events.RoomObjectWidgetRequestEvent;
   import com.sulake.habbo.room.messages.RoomObjectDataUpdateMessage;
   import com.sulake.habbo.room.object.data.MapStuffData;
   import com.sulake.room.events.RoomObjectEvent;
   import com.sulake.room.events.RoomSpriteMouseEvent;
   import com.sulake.room.messages.RoomObjectUpdateMessage;
   import com.sulake.room.utils.IRoomGeometry;
   
   public class FurnitureMannequinLogic extends class_1738
   {
      
      private static const KEY_GENDER:String = "GENDER";
      
      private static const KEY_FIGURE:String = "FIGURE";
      
      private static const KEY_OUTFIT_NAME:String = "OUTFIT_NAME";
      
      public function FurnitureMannequinLogic()
      {
         super();
      }
      
      override public function getEventTypes() : Array
      {
         var _loc1_:Array = ["ROWRE_MANNEQUIN"];
         return getAllEventTypes(super.getEventTypes(),_loc1_);
      }
      
      override public function processUpdateMessage(param1:RoomObjectUpdateMessage) : void
      {
         super.processUpdateMessage(param1);
         var _loc2_:RoomObjectDataUpdateMessage = param1 as RoomObjectDataUpdateMessage;
         if(_loc2_ != null && _loc2_.data != null)
         {
            _loc2_.data.writeRoomObjectModel(object.getModelController());
            setObjectVariables();
         }
      }
      
      private function setObjectVariables() : void
      {
         if(object == null || object.getModelController() == null)
         {
            return;
         }
         var _loc1_:MapStuffData = new MapStuffData();
         _loc1_.initializeFromRoomObjectModel(object.getModel());
         object.getModelController().setString("furniture_mannequin_gender",_loc1_.getValue("GENDER"));
         object.getModelController().setString("furniture_mannequin_figure",_loc1_.getValue("FIGURE"));
         object.getModelController().setString("furniture_mannequin_name",_loc1_.getValue("OUTFIT_NAME"));
      }
      
      override public function mouseEvent(param1:RoomSpriteMouseEvent, param2:IRoomGeometry) : void
      {
         if(param1 == null || param2 == null)
         {
            return;
         }
         if(object == null)
         {
            return;
         }
         var _loc3_:* = param1.type;
         if("doubleClick" !== _loc3_)
         {
            super.mouseEvent(param1,param2);
         }
         else
         {
            useObject();
         }
      }
      
      override public function useObject() : void
      {
         var _loc1_:RoomObjectEvent = null;
         if(eventDispatcher != null && object != null)
         {
            _loc1_ = new RoomObjectWidgetRequestEvent("ROWRE_MANNEQUIN",object);
            eventDispatcher.dispatchEvent(_loc1_);
         }
      }
   }
}

