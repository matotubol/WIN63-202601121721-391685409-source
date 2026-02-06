package com.sulake.habbo.ui.handler
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.habbo.room.events.RoomEngineToWidgetEvent;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.IRoomWidgetHandlerContainer;
   import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
   import com.sulake.habbo.ui.widget.furniture.video.YoutubeDisplayWidget;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
   import com.sulake.room.object.IRoomObject;
   import flash.events.Event;
   import com.sulake.habbo.communication.messages.incoming.room.furniture.YoutubeDisplayVideoMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.room.furniture.YoutubeDisplayPlaylistsMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.room.furniture.YoutubeControlVideoMessageEvent;
   import com.sulake.habbo.communication.messages.parser.room.furniture.YoutubeDisplayVideoMessageEventParser;
   import com.sulake.habbo.communication.messages.parser.room.furniture.YoutubeDisplayPlaylistsMessageEventParser;
   import com.sulake.habbo.communication.messages.parser.room.furniture.YoutubeControlVideoMessageEventParser;
   import com.sulake.habbo.communication.messages.outgoing.room.furniture.SetYoutubeDisplayPlaylistMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.room.furniture.ControlYoutubeDisplayPlaybackMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.room.furniture.GetYoutubeDisplayStatusMessageComposer;
   
   public class class_2671 implements IRoomWidgetHandler
   {
      
      private static const CONTROL_COMMAND_PREVIOUS_VIDEO:int = 0;
      
      private static const CONTROL_COMMAND_NEXT_VIDEO:int = 1;
      
      private static const CONTROL_COMMAND_PAUSE_VIDEO:int = 2;
      
      private static const CONTROL_COMMAND_CONTINUE_VIDEO:int = 3;
      
      private var _container:IRoomWidgetHandlerContainer;
      
      private var var_16:YoutubeDisplayWidget;
      
      private var name_1:Vector.<IMessageEvent>;
      
      public function class_2671()
      {
         super();
      }
      
      public function get type() : String
      {
         return "RWE_YOUTUBE";
      }
      
      public function set container(param1:IRoomWidgetHandlerContainer) : void
      {
         _container = param1;
         addMessageEvent(new YoutubeDisplayVideoMessageEvent(onVideo));
         addMessageEvent(new YoutubeDisplayPlaylistsMessageEvent(onPlaylists));
         addMessageEvent(new YoutubeControlVideoMessageEvent(onControlVideo));
      }
      
      private function addMessageEvent(param1:IMessageEvent) : void
      {
         if(name_1 == null)
         {
            name_1 = new Vector.<IMessageEvent>(0);
         }
         name_1.push(param1);
         _container.connection.addMessageEvent(param1);
      }
      
      private function removeEvents() : void
      {
         for each(var _loc1_ in name_1)
         {
            _container.connection.removeMessageEvent(_loc1_);
            _loc1_.dispose();
         }
      }
      
      private function onVideo(param1:YoutubeDisplayVideoMessageEvent) : void
      {
         var _loc2_:YoutubeDisplayVideoMessageEventParser = param1.getParser();
         var_16.showVideo(_loc2_.furniId,_loc2_.videoId,_loc2_.startAtSeconds,_loc2_.endAtSeconds,_loc2_.state);
      }
      
      private function onControlVideo(param1:YoutubeControlVideoMessageEvent) : void
      {
         var _loc2_:YoutubeControlVideoMessageEventParser = param1.getParser();
         var_16.controlVideo(_loc2_.furniId,_loc2_.commandId);
      }
      
      private function onPlaylists(param1:YoutubeDisplayPlaylistsMessageEvent) : void
      {
         var _loc2_:YoutubeDisplayPlaylistsMessageEventParser = param1.getParser();
         var_16.populatePlaylists(_loc2_.furniId,_loc2_.playlists,_loc2_.selectedPlaylistId);
      }
      
      public function set widget(param1:YoutubeDisplayWidget) : void
      {
         var_16 = param1;
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
         return [];
      }
      
      public function processEvent(param1:Event) : void
      {
         if(_container.roomEngine == null)
         {
            return;
         }
         var _loc4_:RoomEngineToWidgetEvent = param1 as RoomEngineToWidgetEvent;
         if(_loc4_ == null)
         {
            return;
         }
         var _loc2_:IRoomObject = _container.roomEngine.getRoomObject(_loc4_.roomId,_loc4_.objectId,_loc4_.category);
         switch(param1.type)
         {
            case "RETWE_OPEN_WIDGET":
               if(_loc2_ != null)
               {
                  var _loc3_:Boolean = _container.isOwnerOfFurniture(_loc2_) || _container.sessionDataManager.hasSecurity(4);
                  var_16.show(_loc2_,false);
                  _container.connection.send(new GetYoutubeDisplayStatusMessageComposer(_loc2_.getId()));
               }
               break;
            case "RETWE_CLOSE_WIDGET":
               var_16.hide(_loc2_);
         }
      }
      
      public function update() : void
      {
      }
      
      public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         removeEvents();
         _container = null;
      }
      
      public function get disposed() : Boolean
      {
         return _container == null;
      }
      
      public function selectPlaylist(param1:int, param2:String) : void
      {
         _container.connection.send(new SetYoutubeDisplayPlaylistMessageComposer(param1,param2));
      }
      
      public function switchToPreviousVideo(param1:int) : void
      {
         _container.connection.send(new ControlYoutubeDisplayPlaybackMessageComposer(param1,0));
      }
      
      public function switchToNextVideo(param1:int) : void
      {
         _container.connection.send(new ControlYoutubeDisplayPlaybackMessageComposer(param1,1));
      }
      
      public function pauseVideo(param1:int) : void
      {
         _container.connection.send(new ControlYoutubeDisplayPlaybackMessageComposer(param1,2));
      }
      
      public function continueVideo(param1:int) : void
      {
         _container.connection.send(new ControlYoutubeDisplayPlaybackMessageComposer(param1,3));
      }
   }
}

