package com.sulake.habbo.window.widgets
{
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.class_1970;
   import com.sulake.core.window.components.class_2010;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.core.window.iterators.EmptyIterator;
   import com.sulake.core.window.utils.IIterator;
   import com.sulake.core.window.utils.PropertyStruct;
   import com.sulake.habbo.room.events.RoomEngineEvent;
   import com.sulake.habbo.room.preview.RoomPreviewer;
   import com.sulake.habbo.window.HabboWindowManagerComponent;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.geom.Point;
   
   public class RoomPreviewerWidget implements IRoomPreviewerWidget
   {
      
      public static const TYPE:String = "room_previewer";
      
      private static const SCALE_KEY:String = "room_previewer:scale";
      
      private static const const_774:String = "room_previewer:offsetx";
      
      private static const const_416:String = "room_previewer:offsety";
      
      private static const const_1255:String = "room_previewer:zoom";
      
      private static var ROOM_ID_COUNTER:int = 2;
      
      private static const SCALE_DEFAULT:PropertyStruct = new PropertyStruct("room_previewer:scale",64,"int",false,[32,64]);
      
      private static const OFFSET_X_DEFAULT:PropertyStruct = new PropertyStruct("room_previewer:offsetx",0,"int",false);
      
      private static const OFFSET_Y_DEFAULT:PropertyStruct = new PropertyStruct("room_previewer:offsety",0,"int",false);
      
      private static const ZOOM_DEFAULT:PropertyStruct = new PropertyStruct("room_previewer:zoom",1,"int",false);
      
      private var _disposed:Boolean;
      
      private var var_210:class_2010;
      
      private var _windowManager:HabboWindowManagerComponent;
      
      private var var_134:class_1812;
      
      private var var_624:class_1970;
      
      private var var_281:RoomPreviewer;
      
      private var var_337:int = int(SCALE_DEFAULT.value);
      
      private var _offsetX:int = 0;
      
      private var _offsetY:int = 0;
      
      private var var_2585:int = int(ZOOM_DEFAULT.value);
      
      public function RoomPreviewerWidget(param1:class_2010, param2:HabboWindowManagerComponent)
      {
         super();
         var_210 = param1;
         _windowManager = param2;
         if(param2.roomEngine)
         {
            param2.roomEngine.events.addEventListener("REE_INITIALIZED",onRoomInitialized);
         }
         var_134 = _windowManager.buildFromXML(_windowManager.assets.getAssetByName("room_previewer_xml").content as XML) as class_1812;
         var_624 = var_134.findChildByName("room_canvas") as class_1970;
         var_281 = new RoomPreviewer(param2.roomEngine,ROOM_ID_COUNTER++);
         var_281.createRoomForPreviews();
         var_134.addEventListener("WME_CLICK",onClickRoomView);
         var_134.addEventListener("WE_RESIZE",onResizeCanvas);
         var_210.rootWindow = var_134;
         var_134.width = var_210.width;
         var_134.height = var_210.height;
         var_281.modifyRoomCanvas(var_134.width,var_134.height);
      }
      
      public function get scale() : int
      {
         return var_337;
      }
      
      public function set scale(param1:int) : void
      {
         var_337 = param1;
         refresh();
      }
      
      public function get offsetX() : int
      {
         return _offsetX;
      }
      
      public function set offsetX(param1:int) : void
      {
         _offsetX = param1;
         refresh();
      }
      
      public function get offsetY() : int
      {
         return _offsetY;
      }
      
      public function set offsetY(param1:int) : void
      {
         _offsetY = param1;
         refresh();
      }
      
      public function get zoom() : int
      {
         return var_2585;
      }
      
      public function set zoom(param1:int) : void
      {
         var_2585 = param1;
         refresh();
      }
      
      public function get properties() : Array
      {
         var _loc1_:Array = [];
         if(_disposed)
         {
            return _loc1_;
         }
         _loc1_.push(SCALE_DEFAULT.withValue(var_337));
         _loc1_.push(OFFSET_X_DEFAULT.withValue(_offsetX));
         _loc1_.push(OFFSET_Y_DEFAULT.withValue(_offsetY));
         _loc1_.push(ZOOM_DEFAULT.withValue(var_2585));
         return _loc1_;
      }
      
      public function set properties(param1:Array) : void
      {
         for each(var _loc2_ in param1)
         {
            switch(_loc2_.key)
            {
               case "room_previewer:scale":
                  scale = int(_loc2_.value);
                  break;
               case "room_previewer:offsetx":
                  offsetX = int(_loc2_.value);
                  break;
               case "room_previewer:offsety":
                  offsetY = int(_loc2_.value);
                  break;
               case "room_previewer:zoom":
                  zoom = int(_loc2_.value);
            }
         }
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            if(var_281 != null)
            {
               var_281.dispose();
               var_281 = null;
            }
            if(var_134 != null)
            {
               var_134.dispose();
               var_134 = null;
            }
            if(var_210 != null)
            {
               var_210.rootWindow = null;
               var_210 = null;
            }
            if(_windowManager && _windowManager.roomEngine && _windowManager.roomEngine.events)
            {
               _windowManager.roomEngine.events.removeEventListener("REE_INITIALIZED",onRoomInitialized);
            }
            _windowManager = null;
            _disposed = true;
         }
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get iterator() : IIterator
      {
         return EmptyIterator.INSTANCE;
      }
      
      private function onRoomInitialized(param1:RoomEngineEvent) : void
      {
         var _loc2_:DisplayObject = null;
         var _loc3_:* = param1.type;
         if("REE_INITIALIZED" === _loc3_)
         {
            if(var_281 && param1.roomId == var_281.previewRoomId)
            {
               var_281.reset(false);
               _loc2_ = var_281.getRoomCanvas(var_624.width,var_624.height);
               if(_loc2_ != null)
               {
                  var_624.setDisplayObject(_loc2_);
               }
            }
         }
      }
      
      private function refresh() : void
      {
         var _loc1_:DisplayObject = null;
         if(var_281 && var_281.isRoomEngineReady)
         {
            var_337 == 64 ? var_281.zoomIn() : var_281.zoomOut();
            var_281.addViewOffset = new Point(_offsetX,_offsetY);
            _loc1_ = var_624.getDisplayObject();
            _loc1_.scaleX = _loc1_.scaleY = zoom;
            _loc1_.x = offsetX;
            _loc1_.y = offsetY;
         }
      }
      
      public function toString() : String
      {
         return "RoomPreviewerWidget";
      }
      
      private function onResizeCanvas(param1:class_1758, param2:class_1741 = null) : void
      {
         var _loc3_:int = param1.window.width;
         var _loc4_:int = param1.window.height;
         var_281.modifyRoomCanvas(_loc3_,_loc4_);
      }
      
      private function onClickRoomView(param1:WindowMouseEvent) : void
      {
         var_281.changeRoomObjectState();
      }
      
      public function get roomPreviewer() : RoomPreviewer
      {
         return var_281;
      }
      
      public function showPreview(param1:BitmapData) : void
      {
         var _loc2_:Bitmap = new Bitmap(param1);
         _loc2_.scaleX = 2;
         _loc2_.scaleY = 2;
         var_624.setDisplayObject(_loc2_);
      }
   }
}

