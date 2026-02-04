package com.sulake.habbo.room.object.logic.furniture
{
   import com.sulake.habbo.room.events.RoomObjectFurnitureActionEvent;
   import com.sulake.habbo.room.events.RoomObjectWidgetRequestEvent;
   import com.sulake.habbo.room.messages.RoomObjectDataUpdateMessage;
   import com.sulake.habbo.room.messages.RoomObjectModelDataUpdateMessage;
   import com.sulake.habbo.room.object.data.MapStuffData;
   import com.sulake.room.events.RoomObjectEvent;
   import com.sulake.room.events.RoomSpriteMouseEvent;
   import com.sulake.room.messages.RoomObjectUpdateMessage;
   import com.sulake.room.object.IRoomObjectModelController;
   import com.sulake.room.utils.IRoomGeometry;
   
   public class FurniturePresentLogic extends class_1738
   {
      
      private static const MESSAGE:String = "MESSAGE";
      
      private static const PRODUCT_CODE:String = "PRODUCT_CODE";
      
      private static const EXTRA_PARAM:String = "EXTRA_PARAM";
      
      private static const PURCHASER_NAME:String = "PURCHASER_NAME";
      
      private static const PURCHASER_FIGURE:String = "PURCHASER_FIGURE";
      
      private static const TRUSTED_SENDER:String = "TRUSTED_SENDER";
      
      public function FurniturePresentLogic()
      {
         super();
      }
      
      override public function getEventTypes() : Array
      {
         var _loc1_:Array = ["ROWRE_PRESENT"];
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
         var _loc3_:RoomObjectModelDataUpdateMessage = param1 as RoomObjectModelDataUpdateMessage;
         if(_loc3_ != null)
         {
            if(_loc3_.numberKey == "furniture_disable_picking_animation")
            {
               object.getModelController().setNumber("furniture_disable_picking_animation",_loc3_.numberValue);
            }
         }
      }
      
      private function setObjectVariables() : void
      {
         if(object == null || object.getModelController() == null)
         {
            return;
         }
         var _loc2_:MapStuffData = new MapStuffData();
         _loc2_.initializeFromRoomObjectModel(object.getModel());
         var _loc1_:String = _loc2_.getValue("MESSAGE");
         var _loc3_:String = object.getModel().getString("furniture_data");
         if(_loc1_ == null && _loc3_ != null)
         {
            object.getModelController().setString("furniture_data",_loc3_.substr(1));
         }
         else
         {
            object.getModelController().setString("furniture_data",_loc2_.getValue("MESSAGE"));
         }
         setObjectVariable("furniture_type_id",_loc2_.getValue("PRODUCT_CODE"));
         setObjectVariable("furniture_purchaser_name",_loc2_.getValue("PURCHASER_NAME"));
         setObjectVariable("furniture_purchaser_figure",_loc2_.getValue("PURCHASER_FIGURE"));
         object.getModelController().setNumber("furniture_trusted_sender",_loc2_.getValue("TRUSTED_SENDER") == "true" ? 1 : 0);
      }
      
      private function setObjectVariable(param1:String, param2:String) : void
      {
         if(param2 != null)
         {
            object.getModelController().setString(param1,param2);
         }
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
         switch(param1.type)
         {
            case "rollOver":
               eventDispatcher.dispatchEvent(new RoomObjectFurnitureActionEvent("ROFCAE_MOUSE_BUTTON",object));
               super.mouseEvent(param1,param2);
               break;
            case "rollOut":
               eventDispatcher.dispatchEvent(new RoomObjectFurnitureActionEvent("ROFCAE_MOUSE_ARROW",object));
               super.mouseEvent(param1,param2);
               break;
            case "doubleClick":
               useObject();
               break;
            default:
               super.mouseEvent(param1,param2);
         }
      }
      
      override public function useObject() : void
      {
         var _loc1_:RoomObjectEvent = null;
         if(eventDispatcher != null && object != null)
         {
            _loc1_ = new RoomObjectWidgetRequestEvent("ROWRE_PRESENT",object);
            eventDispatcher.dispatchEvent(_loc1_);
         }
      }
      
      override public function initialize(param1:XML) : void
      {
         var _loc3_:IRoomObjectModelController = null;
         super.initialize(param1);
         if(param1 == null)
         {
            return;
         }
         var _loc2_:XMLList = param1.particlesystems;
         if(_loc2_ == null || _loc2_.length() == 0)
         {
            return;
         }
         if(object != null)
         {
            _loc3_ = object.getModelController();
            if(_loc3_ != null)
            {
               _loc3_.setString("furniture_fireworks_data",String(_loc2_));
            }
         }
      }
   }
}

