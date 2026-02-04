package com.sulake.habbo.room.object.logic.furniture
{
   import com.sulake.habbo.room.events.RoomObjectBadgeAssetEvent;
   import com.sulake.habbo.room.events.RoomObjectWidgetRequestEvent;
   import com.sulake.habbo.room.messages.RoomObjectDataUpdateMessage;
   import com.sulake.habbo.room.messages.RoomObjectGroupBadgeUpdateMessage;
   import com.sulake.habbo.room.object.data.StringArrayStuffData;
   import com.sulake.room.events.RoomSpriteMouseEvent;
   import com.sulake.room.messages.RoomObjectUpdateMessage;
   import com.sulake.room.utils.IRoomGeometry;
   import flash.utils.getTimer;
   
   public class class_1908 extends class_1738
   {
      
      public function class_1908()
      {
         super();
      }
      
      override public function getEventTypes() : Array
      {
         var _loc1_:Array = ["ROGBE_LOAD_BADGE","ROWRE_BADGE_DISPLAY_ENGRAVING"];
         return getAllEventTypes(super.getEventTypes(),_loc1_);
      }
      
      override public function processUpdateMessage(param1:RoomObjectUpdateMessage) : void
      {
         var _loc2_:StringArrayStuffData = null;
         super.processUpdateMessage(param1);
         var _loc4_:RoomObjectDataUpdateMessage = param1 as RoomObjectDataUpdateMessage;
         if(_loc4_ != null)
         {
            _loc2_ = _loc4_.data as StringArrayStuffData;
            if(_loc2_ != null)
            {
               updateBadge(_loc2_.getValue(1));
            }
         }
         var _loc3_:RoomObjectGroupBadgeUpdateMessage = param1 as RoomObjectGroupBadgeUpdateMessage;
         if(_loc3_ != null)
         {
            if(_loc3_.assetName != "loading_icon")
            {
               object.getModelController().setString("furniture_badge_asset_name",_loc3_.assetName);
               object.getModelController().setNumber("furniture_badge_image_status",1);
               this.update(getTimer());
            }
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
         if(eventDispatcher != null && object != null)
         {
            eventDispatcher.dispatchEvent(new RoomObjectWidgetRequestEvent("ROWRE_BADGE_DISPLAY_ENGRAVING",object));
         }
      }
      
      protected function updateBadge(param1:String) : void
      {
         if(param1 != "")
         {
            eventDispatcher.dispatchEvent(new RoomObjectBadgeAssetEvent("ROGBE_LOAD_BADGE",object,param1,false));
         }
      }
   }
}

