package com.sulake.habbo.ui.widget.furniture.video
{
   import com.sulake.core.assets.class_40;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.class_1970;
   import com.sulake.core.window.events.WindowKeyboardEvent;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.localization.class_27;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.handler.class_3409;
   import com.sulake.habbo.ui.widget.RoomWidgetBase;
   import com.sulake.habbo.window.class_38;
   import com.sulake.room.object.IRoomObject;
   import com.vimeo.api.VimeoPlayer;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   
   public class VimeoDisplayWidget extends RoomWidgetBase
   {
      
      private static const const_148:String = "9a106b76302cbce891b714afdc6a0c93";
      
      private var var_201:VimeoPlayer;
      
      private var _window:class_1812;
      
      private var _roomObject:IRoomObject;
      
      public function VimeoDisplayWidget(param1:IRoomWidgetHandler, param2:class_38, param3:class_40, param4:class_27)
      {
         super(param1,param2,param3,param4);
         ownHandler.widget = this;
      }
      
      private function get ownHandler() : class_3409
      {
         return var_41 as class_3409;
      }
      
      override public function get mainWindow() : class_1741
      {
         return _window;
      }
      
      public function show(param1:IRoomObject, param2:Boolean, param3:int) : void
      {
         _roomObject = param1;
         createWindow(param2,param3);
         _window.visible = true;
      }
      
      private function createWindow(param1:Boolean, param2:int) : void
      {
         if(_window != null)
         {
            return;
         }
         _window = windowManager.buildFromXML(XML(assets.getAssetByName("vimeo_viewer_xml").content)) as class_1812;
         _window.findChildByName("video_id_editor").visible = param1;
         _window.findChildByName("video_wrapper").visible = param2 > 0;
         _window.procedure = windowProcedure;
         _window.center();
         var _loc3_:class_1970 = class_1970(_window.findChildByName("video_wrapper"));
         var_201 = new VimeoPlayer("9a106b76302cbce891b714afdc6a0c93",param2,_loc3_.width,_loc3_.height);
         _loc3_.setDisplayObject(var_201);
         var_201.addEventListener("mouseUp",onVideoMouseEvent);
         var_201.addEventListener("mouseMove",onVideoMouseEvent);
      }
      
      private function onVideoMouseEvent(param1:MouseEvent) : void
      {
         if(_window != null)
         {
            DisplayObject(param1.target).stage.dispatchEvent(param1);
         }
      }
      
      private function windowProcedure(param1:class_1758, param2:class_1741) : void
      {
         switch(param1.type)
         {
            case "WME_CLICK":
               var _loc4_:* = param2.name;
               if("header_button_close" !== _loc4_)
               {
                  break;
               }
               hide(_roomObject);
               break;
            case "WE_RESIZE":
               _loc4_ = param2.name;
               if("video_wrapper" !== _loc4_)
               {
                  break;
               }
               if(var_201 != null)
               {
                  var_201.setSize(param2.width,param2.height);
               }
               break;
            case "WKE_KEY_DOWN":
               if(WindowKeyboardEvent(param1).charCode == 13)
               {
                  var _loc3_:int = int(_window.findChildByName("video_id").caption);
                  ownHandler.setVideo(_roomObject,0);
                  _window.findChildByName("video_wrapper").visible = 0 > 0;
                  var_201.loadVideo(0);
               }
         }
      }
      
      public function hide(param1:IRoomObject) : void
      {
         if(_roomObject != param1)
         {
            return;
         }
         if(var_201 != null)
         {
            var_201.destroy();
            var_201 = null;
         }
         if(_window != null)
         {
            _window.dispose();
            _window = null;
         }
         _roomObject = null;
      }
   }
}

