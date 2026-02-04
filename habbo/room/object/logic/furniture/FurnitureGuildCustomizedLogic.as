package com.sulake.habbo.room.object.logic.furniture
{
   import com.sulake.habbo.room.events.RoomObjectBadgeAssetEvent;
   import com.sulake.habbo.room.events.RoomObjectWidgetRequestEvent;
   import com.sulake.habbo.room.messages.RoomObjectDataUpdateMessage;
   import com.sulake.habbo.room.messages.RoomObjectGroupBadgeUpdateMessage;
   import com.sulake.habbo.room.messages.RoomObjectSelectedMessage;
   import com.sulake.habbo.room.object.data.StringArrayStuffData;
   import com.sulake.room.events.RoomObjectEvent;
   import com.sulake.room.events.RoomSpriteMouseEvent;
   import com.sulake.room.messages.RoomObjectUpdateMessage;
   import com.sulake.room.utils.IRoomGeometry;
   import flash.utils.getTimer;
   
   public class FurnitureGuildCustomizedLogic extends FurnitureMultiStateLogic
   {
      
      public static const GUILD_ID_STUFFDATA_KEY:int = 1;
      
      public static const BADGE_CODE_STUFFDATA_KEY:int = 2;
      
      public static const COLOR_1_STUFFDATA_KEY:int = 3;
      
      public static const COLOR_2_STUFFDATA_KEY:int = 4;
      
      public function FurnitureGuildCustomizedLogic()
      {
         super();
      }
      
      override public function getEventTypes() : Array
      {
         var _loc1_:Array = ["ROGBE_LOAD_BADGE","ROWRE_GUILD_FURNI_CONTEXT_MENU","ROWRE_CLOSE_FURNI_CONTEXT_MENU"];
         return getAllEventTypes(super.getEventTypes(),_loc1_);
      }
      
      override public function processUpdateMessage(param1:RoomObjectUpdateMessage) : void
      {
         var _loc3_:StringArrayStuffData = null;
         var _loc6_:RoomObjectEvent = null;
         super.processUpdateMessage(param1);
         var _loc5_:RoomObjectDataUpdateMessage = param1 as RoomObjectDataUpdateMessage;
         if(_loc5_ != null)
         {
            _loc3_ = _loc5_.data as StringArrayStuffData;
            if(_loc3_ != null)
            {
               updateGuildId(_loc3_.getValue(1));
               updateGuildBadge(_loc3_.getValue(2));
               updateGuildColors(_loc3_.getValue(3),_loc3_.getValue(4));
            }
         }
         var _loc4_:RoomObjectGroupBadgeUpdateMessage = param1 as RoomObjectGroupBadgeUpdateMessage;
         if(_loc4_ != null)
         {
            if(_loc4_.assetName != "loading_icon")
            {
               object.getModelController().setString("furniture_guild_customized_asset_name",_loc4_.assetName);
               this.update(getTimer());
            }
         }
         var _loc2_:RoomObjectSelectedMessage = param1 as RoomObjectSelectedMessage;
         if(_loc2_)
         {
            if(eventDispatcher != null && object != null)
            {
               if(!_loc2_.selected)
               {
                  _loc6_ = new RoomObjectWidgetRequestEvent("ROWRE_CLOSE_FURNI_CONTEXT_MENU",object);
                  eventDispatcher.dispatchEvent(_loc6_);
               }
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
         if("click" === _loc3_)
         {
            openContextMenu();
         }
         super.mouseEvent(param1,param2);
      }
      
      protected function openContextMenu() : void
      {
         var _loc1_:RoomObjectEvent = new RoomObjectWidgetRequestEvent("ROWRE_GUILD_FURNI_CONTEXT_MENU",object);
         eventDispatcher.dispatchEvent(_loc1_);
      }
      
      private function updateGuildColors(param1:String, param2:String) : void
      {
         object.getModelController().setNumber("furniture_guild_customized_color_1",parseInt(param1,16));
         object.getModelController().setNumber("furniture_guild_customized_color_2",parseInt(param2,16));
      }
      
      private function updateGuildBadge(param1:String) : void
      {
         eventDispatcher.dispatchEvent(new RoomObjectBadgeAssetEvent("ROGBE_LOAD_BADGE",object,param1,true));
      }
      
      protected function updateGuildId(param1:String) : void
      {
         object.getModelController().setNumber("furniture_guild_customized_guild_id",parseInt(param1));
      }
   }
}

