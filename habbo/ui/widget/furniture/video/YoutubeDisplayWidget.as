package com.sulake.habbo.ui.widget.furniture.video
{
   import com.sulake.core.assets.class_40;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.class_1970;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.localization.class_27;
   import com.sulake.habbo.tracking.class_53;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.handler.class_2671;
   import com.sulake.habbo.ui.widget.RoomWidgetBase;
   import com.sulake.habbo.window.class_38;
   import com.sulake.room.object.IRoomObject;
   import flash.display.DisplayObject;
   import flash.display.Loader;
   import flash.display.LoaderInfo;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import com.sulake.habbo.communication.messages.parser.room.furniture.class_3334;
   
   public class YoutubeDisplayWidget extends RoomWidgetBase
   {
      
      private static const const_665:uint = 4291611903;
      
      private static const const_896:uint = 4294967295;
      
      private var _habboTracking:class_53;
      
      private var var_201:Object;
      
      private var _window:class_1812;
      
      private var _roomObject:IRoomObject;
      
      private var var_165:class_1812;
      
      private var var_1581:class_1741;
      
      private var _queuedVideoParams:Object;
      
      private var var_2145:String;
      
      private var _canControlPlayback:Boolean;
      
      private var var_2101:int = -1;
      
      public function YoutubeDisplayWidget(param1:IRoomWidgetHandler, param2:class_38, param3:class_40, param4:class_27, param5:class_53)
      {
         super(param1,param2,param3,param4);
         _habboTracking = param5;
         ownHandler.widget = this;
      }
      
      private function get ownHandler() : class_2671
      {
         return var_41 as class_2671;
      }
      
      override public function get mainWindow() : class_1741
      {
         return _window;
      }
      
      public function show(param1:IRoomObject, param2:Boolean) : void
      {
         _roomObject = param1;
         _canControlPlayback = param2;
         createWindow(param2);
         _window.visible = true;
      }
      
      private function createWindow(param1:Boolean) : void
      {
         if(_window != null)
         {
            return;
         }
         _window = windowManager.buildFromXML(XML(assets.getAssetByName("video_viewer_xml").content)) as class_1812;
         if(param1)
         {
            var_1581 = IItemListWindow(_window.findChildByName("playlists")).removeListItemAt(0);
         }
         else
         {
            _window.findChildByName("right_pane").dispose();
            _window.findChildByName("video_background").width = _window.width - 20;
            _window.findChildByName("video_background").setParamFlag(128);
            _window.width -= 250;
         }
         _window.procedure = windowProcedure;
         _window.center();
      }
      
      private function onPlayerLoaderInit(param1:Event) : void
      {
         var _loc2_:Loader = null;
         if(_window == null)
         {
            return;
         }
         var _loc3_:LoaderInfo = param1.target as LoaderInfo;
         if(_loc3_)
         {
            _loc2_ = _loc3_.loader;
            class_1970(_window.findChildByName("video_wrapper")).setDisplayObject(_loc2_);
            _loc2_.content.addEventListener("onReady",onPlayerReady);
            _loc2_.content.addEventListener("onStateChange",onPlayerStateChange);
            _loc2_.content.addEventListener("mouseUp",onVideoMouseEvent);
            _loc2_.content.addEventListener("mouseMove",onVideoMouseEvent);
         }
      }
      
      private function onVideoMouseEvent(param1:MouseEvent) : void
      {
         if(_window != null && _canControlPlayback)
         {
            DisplayObject(param1.target).stage.dispatchEvent(new MouseEvent(param1.type));
            if(var_201 && param1.type == "mouseUp" && var_2145 != "")
            {
               if(var_201.getPlayerState() == 1)
               {
                  ownHandler.pauseVideo(_roomObject.getId());
               }
               else if(var_201.getPlayerState() == 2)
               {
                  ownHandler.continueVideo(_roomObject.getId());
               }
            }
         }
      }
      
      private function onPlayerReady(param1:Event) : void
      {
         var_201 = param1.target;
         if(_window != null)
         {
            var _loc2_:class_1741 = _window.findChildByName("video_wrapper");
            var_201.setSize(null.width,null.height);
            if(_queuedVideoParams != null)
            {
               loadVideo(_queuedVideoParams);
               _queuedVideoParams = null;
            }
         }
         else
         {
            var_201.destroy();
         }
      }
      
      private function onPlayerStateChange(param1:Event) : void
      {
         var_201 = param1.target;
         if(_window != null)
         {
            switch(var_201.getPlayerState())
            {
               case -1:
               case 1:
                  if(var_2101 == 2)
                  {
                     var_201.pauseVideo();
                  }
            }
         }
      }
      
      public function hide(param1:IRoomObject) : void
      {
         if(_roomObject != param1)
         {
            return;
         }
         if(_window != null)
         {
            _window.dispose();
            _window = null;
         }
         if(var_1581 != null)
         {
            var_1581.dispose();
            var_1581 = null;
         }
         if(var_201 != null)
         {
            var_201.destroy();
            var_201 = null;
         }
         if(var_2145 != null)
         {
            _habboTracking.trackEventLog("YouTubeTVs",var_2145,"video.closed");
         }
         _queuedVideoParams = null;
         var_165 = null;
         _roomObject = null;
      }
      
      override public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         hide(_roomObject);
         _habboTracking = null;
         super.dispose();
      }
      
      private function windowProcedure(param1:class_1758, param2:class_1741) : void
      {
         switch(param1.type)
         {
            case "WME_CLICK":
               switch(param2.name)
               {
                  case "header_button_close":
                     hide(_roomObject);
                     break;
                  case "playlist_prev":
                     ownHandler.switchToPreviousVideo(_roomObject.getId());
                     break;
                  case "playlist_next":
                     ownHandler.switchToNextVideo(_roomObject.getId());
                     break;
                  default:
                     if(param2 is IRegionWindow)
                     {
                        if(var_165 != null)
                        {
                           var_165.findChildByName("item_background").color = 4294967295;
                        }
                        if(var_165 == param2)
                        {
                           var_165 = null;
                           ownHandler.selectPlaylist(_roomObject.getId(),"");
                        }
                        else
                        {
                           var_165 = param2 as class_1812;
                           var_165.findChildByName("item_background").color = 4291611903;
                           ownHandler.selectPlaylist(_roomObject.getId(),var_165.name);
                        }
                        updateButtons();
                     }
               }
               break;
            case "WE_RESIZE":
               loop3:
               switch(param2.name)
               {
                  case "video_viewer":
                     if(_window != null)
                     {
                        var _loc5_:class_1741 = _window.findChildByName("right_pane");
                        if(_loc5_ != null)
                        {
                           var _loc6_:int = _window.width - 29;
                           var _loc3_:int = _loc6_ * 0.66;
                           var _loc8_:class_1741 = _window.findChildByName("video_background");
                           _loc8_.width = 0;
                           null.x = null.right + 9;
                           null.width = 0 - 0;
                        }
                     }
                     break;
                  case "playlists":
                     var _loc9_:IItemListWindow = param2 as IItemListWindow;
                     if(_loc9_ == null)
                     {
                        break;
                     }
                     var _loc7_:int = 0;
                     while(true)
                     {
                        if(0 >= null.numListItems)
                        {
                           break loop3;
                        }
                        var _loc4_:class_1812 = null.getListItemAt(0) as class_1812;
                        _loc4_.findChildByName("item_background").width = null.width;
                        null.findChildByName("item_contents").width = null.width;
                        null.findChildByName("item_description").width = null.width - 22;
                        _loc7_++;
                     }
                     break;
                  case "video_wrapper":
                     if(var_201 != null)
                     {
                        var_201.setSize(param2.width,param2.height);
                     }
               }
         }
      }
      
      public function showVideo(param1:int, param2:String, param3:int, param4:int, param5:int) : void
      {
         if(_roomObject == null || _roomObject.getId() != param1)
         {
            return;
         }
         var _loc6_:Object = param3 > 0 || param4 > 0 ? {
            "videoId":param2,
            "startSeconds":param3,
            "endSeconds":param4,
            "suggestedQuality":"large"
         } : {
            "videoId":param2,
            "suggestedQuality":"large"
         };
         if(var_201 != null)
         {
            loadVideo(_loc6_);
            _queuedVideoParams = null;
         }
         else
         {
            _queuedVideoParams = _loc6_;
         }
         var_2101 = param5;
      }
      
      public function controlVideo(param1:int, param2:int) : void
      {
         if(_roomObject == null || _roomObject.getId() != param1)
         {
            return;
         }
         if(_window != null)
         {
            if(var_201)
            {
               switch(param2 - 1)
               {
                  case 0:
                     var_2101 = 1;
                     var_201.playVideo();
                     break;
                  case 1:
                     var_2101 = 2;
                     var_201.pauseVideo();
               }
            }
         }
      }
      
      private function loadVideo(param1:Object) : void
      {
         var_2145 = param1.videoId;
         var _loc2_:* = var_2145 != "";
         if(_loc2_)
         {
            var_201.loadVideoById(param1);
            _habboTracking.trackEventLog("YouTubeTVs",var_2145,"video.started");
         }
         else
         {
            var_201.stopVideo();
         }
         if(_window != null)
         {
            _window.findChildByName("no_videos_label").visible = !_loc2_;
            _window.findChildByName("video_wrapper").visible = _loc2_;
         }
      }
      
      public function populatePlaylists(param1:int, param2:Vector.<class_3334>, param3:String) : void
      {
         if(_roomObject == null || _roomObject.getId() != param1 || _window == null || var_1581 == null)
         {
            return;
         }
         var _loc6_:IItemListWindow = _window.findChildByName("playlists") as IItemListWindow;
         if(_loc6_ == null)
         {
            return;
         }
         _loc6_.destroyListItems();
         var_165 = null;
         for each(var _loc5_ in param2)
         {
            var _loc4_:class_1812 = var_1581.clone() as class_1812;
            _loc4_.name = _loc5_.playlistId;
            null.findChildByName("item_background").width = _loc6_.width;
            if(_loc5_.playlistId == param3)
            {
               null.findChildByName("item_background").color = 4291611903;
               var_165 = null;
            }
            null.findChildByName("item_contents").width = _loc6_.width;
            null.findChildByName("item_title").caption = _loc5_.title;
            null.findChildByName("item_description").caption = _loc5_.description.replace(/\r/g,"");
            null.findChildByName("item_description").width = _loc6_.width - 22;
            _loc6_.addListItem(null);
         }
         updateButtons();
      }
      
      private function updateButtons() : void
      {
         if(_window == null)
         {
            return;
         }
         if(var_165 != null)
         {
            _window.findChildByName("playlist_prev").enable();
            _window.findChildByName("playlist_next").enable();
         }
         else
         {
            _window.findChildByName("playlist_prev").disable();
            _window.findChildByName("playlist_next").disable();
         }
      }
   }
}

