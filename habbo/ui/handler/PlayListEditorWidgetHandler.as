package com.sulake.habbo.ui.handler
{
   import com.sulake.core.communication.connection.IConnection;
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.habbo.room.events.RoomEngineSoundMachineEvent;
   import com.sulake.habbo.sound.events.NowPlayingEvent;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.IRoomWidgetHandlerContainer;
   import com.sulake.habbo.ui.widget.events.RoomWidgetPlayListEditorEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetPlayListEditorNowPlayingEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetFurniToWidgetMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetPlayListModificationMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetPlayListPlayStateMessage;
   import com.sulake.room.object.IRoomObject;
   import flash.events.Event;
   import package_119.class_2432;
   import package_119.class_2662;
   import package_119.class_2760;
   import package_55.class_2945;
   import package_60.class_2329;
   import package_60.class_3412;
   
   public class PlayListEditorWidgetHandler implements IRoomWidgetHandler
   {
      
      private var _disposed:Boolean = false;
      
      private var _container:IRoomWidgetHandlerContainer;
      
      private var var_37:IConnection = null;
      
      private var var_2276:IMessageEvent;
      
      private var var_3506:IMessageEvent;
      
      private var var_1272:IMessageEvent;
      
      public function PlayListEditorWidgetHandler()
      {
         super();
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get type() : String
      {
         return "RWE_PLAYLIST_EDITOR_WIDGET";
      }
      
      public function set container(param1:IRoomWidgetHandlerContainer) : void
      {
         _container = param1;
         if(_container.soundManager)
         {
            _container.soundManager.events.addEventListener("SDIR_SONG_DISK_INVENTORY_RECEIVENT_EVENT",processSoundManagerEvent);
            _container.soundManager.events.addEventListener("PLUE_PLAY_LIST_UPDATED",processSoundManagerEvent);
            _container.soundManager.events.addEventListener("PLUE_PLAY_LIST_FULL",processSoundManagerEvent);
            _container.soundManager.events.addEventListener("NPE_SONG_CHANGED",processSoundManagerEvent);
            _container.soundManager.events.addEventListener("NPE_USER_PLAY_SONG",processSoundManagerEvent);
            _container.soundManager.events.addEventListener("NPW_USER_STOP_SONG",processSoundManagerEvent);
         }
      }
      
      public function set connection(param1:IConnection) : void
      {
         var_2276 = new class_2432(onFurniListUpdated);
         var_3506 = new class_2760(onFurniListUpdated);
         var_1272 = new class_2662(onFurniListUpdated);
         var_37 = param1;
         var_37.addMessageEvent(var_2276);
         var_37.addMessageEvent(var_3506);
         var_37.addMessageEvent(var_1272);
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            _disposed = true;
            if(var_37)
            {
               var_37.removeMessageEvent(var_2276);
               var_37.removeMessageEvent(var_3506);
               var_37.removeMessageEvent(var_1272);
            }
            var_37 = null;
            var_2276 = null;
            if(_container)
            {
               if(_container.soundManager)
               {
                  if(_container.soundManager.events)
                  {
                     _container.soundManager.events.removeEventListener("SDIR_SONG_DISK_INVENTORY_RECEIVENT_EVENT",processSoundManagerEvent);
                     _container.soundManager.events.removeEventListener("PLUE_PLAY_LIST_UPDATED",processSoundManagerEvent);
                     _container.soundManager.events.removeEventListener("PLUE_PLAY_LIST_FULL",processSoundManagerEvent);
                     _container.soundManager.events.removeEventListener("NPE_SONG_CHANGED",processSoundManagerEvent);
                     _container.soundManager.events.removeEventListener("NPE_USER_PLAY_SONG",processSoundManagerEvent);
                     _container.soundManager.events.removeEventListener("NPW_USER_STOP_SONG",processSoundManagerEvent);
                  }
               }
               _container = null;
            }
         }
      }
      
      public function getWidgetMessages() : Array
      {
         return ["RWFWM_MESSAGE_REQUEST_PLAYLIST_EDITOR","RWPLAM_ADD_TO_PLAYLIST","RWPLAM_REMOVE_FROM_PLAYLIST","RWPLPS_TOGGLE_PLAY_PAUSE","RWPLUA_OPEN_CATALOGUE_BUTTON_PRESSED"];
      }
      
      public function processWidgetMessage(param1:RoomWidgetMessage) : RoomWidgetUpdateEvent
      {
         var _loc5_:RoomWidgetFurniToWidgetMessage = null;
         var _loc4_:IRoomObject = null;
         switch(param1.type)
         {
            case "RWFWM_MESSAGE_REQUEST_PLAYLIST_EDITOR":
               _loc5_ = param1 as RoomWidgetFurniToWidgetMessage;
               _loc4_ = _container.roomEngine.getRoomObject(_loc5_.roomId,_loc5_.id,_loc5_.category);
               if(_loc4_ != null)
               {
                  var _loc7_:Boolean = _container.isOwnerOfFurniture(_loc4_);
                  var _loc2_:Boolean = _container.roomSession.isRoomOwner || _container.roomSession.roomControllerLevel >= 1 || _container.sessionDataManager.isAnyRoomController;
               }
               break;
            case "RWPLAM_ADD_TO_PLAYLIST":
               var _loc8_:RoomWidgetPlayListModificationMessage = param1 as RoomWidgetPlayListModificationMessage;
               if(var_37 != null)
               {
                  var_37.send(new class_2329(null.diskId,null.slotNumber));
               }
               break;
            case "RWPLAM_REMOVE_FROM_PLAYLIST":
               var _loc9_:RoomWidgetPlayListModificationMessage = param1 as RoomWidgetPlayListModificationMessage;
               if(var_37 != null)
               {
                  var_37.send(new class_3412(null.slotNumber));
               }
               break;
            case "RWPLPS_TOGGLE_PLAY_PAUSE":
               var _loc6_:RoomWidgetPlayListPlayStateMessage = param1 as RoomWidgetPlayListPlayStateMessage;
               if(var_37 != null)
               {
                  var_37.send(new class_2945(null.furniId,null.position));
               }
               break;
            case "RWPLUA_OPEN_CATALOGUE_BUTTON_PRESSED":
               _container.habboTracking.trackGoogle("playlistEditorPanelOpenCatalogue","click");
         }
         return null;
      }
      
      public function getProcessedEvents() : Array
      {
         var _loc1_:Array = [];
         _loc1_.push("ROSM_JUKEBOX_DISPOSE");
         return _loc1_;
      }
      
      public function processEvent(param1:Event) : void
      {
         var _loc2_:RoomEngineSoundMachineEvent = null;
         var _loc3_:RoomWidgetPlayListEditorEvent = null;
         var _loc4_:* = param1.type;
         if("ROSM_JUKEBOX_DISPOSE" === _loc4_)
         {
            _loc2_ = param1 as RoomEngineSoundMachineEvent;
            _loc3_ = new RoomWidgetPlayListEditorEvent("RWPLEE_HIDE_PLAYLIST_EDITOR",_loc2_.objectId);
            _container.events.dispatchEvent(_loc3_);
         }
      }
      
      public function update() : void
      {
      }
      
      private function onFurniListUpdated(param1:IMessageEvent) : void
      {
         var _loc2_:class_2432 = param1 as class_2432;
         if(_loc2_ && _loc2_.getParser().fragmentNo == 0)
         {
            if(_container != null)
            {
               if(_container.events != null)
               {
                  _container.events.dispatchEvent(new RoomWidgetPlayListEditorEvent("RWPLEE_INVENTORY_UPDATED",-1));
               }
            }
         }
      }
      
      private function processSoundManagerEvent(param1:Event) : void
      {
         switch(param1.type)
         {
            case "SDIR_SONG_DISK_INVENTORY_RECEIVENT_EVENT":
               _container.events.dispatchEvent(new RoomWidgetPlayListEditorEvent("RWPLEE_SONG_DISK_INVENTORY_UPDATED"));
               break;
            case "PLUE_PLAY_LIST_UPDATED":
               _container.events.dispatchEvent(new RoomWidgetPlayListEditorEvent("RWPLEE_PLAY_LIST_UPDATED"));
               break;
            case "PLUE_PLAY_LIST_FULL":
               _container.events.dispatchEvent(new RoomWidgetPlayListEditorEvent("RWPLEE_PLAY_LIST_FULL"));
               break;
            case "NPE_SONG_CHANGED":
               var _loc2_:NowPlayingEvent = param1 as NowPlayingEvent;
               _container.events.dispatchEvent(new RoomWidgetPlayListEditorNowPlayingEvent("RWPLENPE_SONG_CHANGED",null.id,null.position,null.priority));
               break;
            case "NPE_USER_PLAY_SONG":
               _loc2_ = param1 as NowPlayingEvent;
               _container.events.dispatchEvent(new RoomWidgetPlayListEditorNowPlayingEvent("RWPLENPE_USER_PLAY_SONG",null.id,null.position,null.priority));
               break;
            case "NPW_USER_STOP_SONG":
               _loc2_ = param1 as NowPlayingEvent;
               _container.events.dispatchEvent(new RoomWidgetPlayListEditorNowPlayingEvent("RWPLENPW_USER_STOP_SONG",null.id,null.position,null.priority));
         }
      }
   }
}

