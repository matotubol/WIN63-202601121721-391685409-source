package com.sulake.habbo.room.object.logic.furniture
{
   import com.sulake.habbo.room.events.RoomObjectFurnitureActionEvent;
   import com.sulake.habbo.room.events.RoomObjectStateChangeEvent;
   import com.sulake.habbo.room.events.RoomObjectWidgetRequestEvent;
   import com.sulake.habbo.room.messages.RoomObjectDataUpdateMessage;
   import com.sulake.room.events.RoomObjectEvent;
   import com.sulake.room.events.RoomSpriteMouseEvent;
   import com.sulake.room.messages.RoomObjectUpdateMessage;
   import com.sulake.room.object.IRoomObjectModelController;
   import com.sulake.room.utils.IRoomGeometry;
   
   public class FurnitureJukeboxLogic extends FurnitureMultiStateLogic
   {
      
      private var var_2741:Boolean;
      
      private var var_265:Boolean = false;
      
      private var var_1857:int = -1;
      
      public function FurnitureJukeboxLogic()
      {
         super();
      }
      
      override public function getEventTypes() : Array
      {
         var _loc1_:Array = ["ROFCAE_JUKEBOX_START","ROFCAE_JUKEBOX_MACHINE_STOP","ROFCAE_JUKEBOX_DISPOSE","ROFCAE_JUKEBOX_INIT","ROWRE_JUKEBOX_PLAYLIST_EDITOR"];
         return getAllEventTypes(super.getEventTypes(),_loc1_);
      }
      
      override public function dispose() : void
      {
         requestDispose();
         super.dispose();
      }
      
      override public function processUpdateMessage(param1:RoomObjectUpdateMessage) : void
      {
         var _loc4_:RoomObjectDataUpdateMessage = null;
         var _loc2_:IRoomObjectModelController = null;
         var _loc3_:int = 0;
         super.processUpdateMessage(param1);
         if(object == null)
         {
            return;
         }
         if(object.getModelController().getNumber("furniture_real_room_object") == 1)
         {
            if(!var_265)
            {
               requestInit();
            }
            object.getModelController().setString("RWEIEP_INFOSTAND_EXTRA_PARAM","RWEIEP_JUKEBOX");
            _loc4_ = param1 as RoomObjectDataUpdateMessage;
            if(_loc4_ == null)
            {
               return;
            }
            _loc2_ = object.getModelController();
            if(_loc2_ == null)
            {
               return;
            }
            _loc3_ = int(object.getState(0));
            if(_loc3_ != var_1857)
            {
               var_1857 = _loc3_;
               if(_loc3_ == 1)
               {
                  requestPlayList();
               }
               else if(_loc3_ == 0)
               {
                  requestStopPlaying();
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
            _loc1_ = new RoomObjectWidgetRequestEvent("ROWRE_JUKEBOX_PLAYLIST_EDITOR",object);
            eventDispatcher.dispatchEvent(_loc1_);
            eventDispatcher.dispatchEvent(new RoomObjectStateChangeEvent("ROSCE_STATE_CHANGE",object,-1));
         }
      }
      
      private function requestInit() : void
      {
         if(object == null || eventDispatcher == null)
         {
            return;
         }
         var_2741 = true;
         var _loc1_:RoomObjectFurnitureActionEvent = new RoomObjectFurnitureActionEvent("ROFCAE_JUKEBOX_INIT",object);
         eventDispatcher.dispatchEvent(_loc1_);
         var_265 = true;
      }
      
      private function requestPlayList() : void
      {
         if(object == null || eventDispatcher == null)
         {
            return;
         }
         var_2741 = true;
         var _loc1_:RoomObjectFurnitureActionEvent = new RoomObjectFurnitureActionEvent("ROFCAE_JUKEBOX_START",object);
         eventDispatcher.dispatchEvent(_loc1_);
      }
      
      private function requestStopPlaying() : void
      {
         if(object == null || eventDispatcher == null)
         {
            return;
         }
         var _loc1_:RoomObjectFurnitureActionEvent = new RoomObjectFurnitureActionEvent("ROFCAE_JUKEBOX_MACHINE_STOP",object);
         eventDispatcher.dispatchEvent(_loc1_);
      }
      
      private function requestDispose() : void
      {
         if(!var_2741)
         {
            return;
         }
         if(object == null || eventDispatcher == null)
         {
            return;
         }
         var _loc1_:RoomObjectFurnitureActionEvent = new RoomObjectFurnitureActionEvent("ROFCAE_JUKEBOX_DISPOSE",object);
         eventDispatcher.dispatchEvent(_loc1_);
      }
   }
}

