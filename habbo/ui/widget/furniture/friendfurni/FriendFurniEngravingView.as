package com.sulake.habbo.ui.widget.furniture.friendfurni
{
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.class_1970;
   import com.sulake.core.window.components.class_2251;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.avatar.class_1827;
   import com.sulake.habbo.avatar.class_259;
   import com.sulake.habbo.room.object.data.StringArrayStuffData;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.errors.IllegalOperationError;
   import flash.geom.Point;
   
   public class FriendFurniEngravingView implements class_259, class_13
   {
      
      private var var_1966:StringArrayStuffData;
      
      private var var_16:FriendFurniEngravingWidget;
      
      private var _window:class_1812 = null;
      
      private var _disposed:Boolean = false;
      
      public function FriendFurniEngravingView(param1:FriendFurniEngravingWidget, param2:StringArrayStuffData)
      {
         super();
         var_16 = param1;
         var_1966 = param2;
      }
      
      private static function setElementImage(param1:class_1741, param2:BitmapData, param3:int = 0, param4:int = 0, param5:int = 0) : void
      {
         if(param2 == null)
         {
            return;
         }
         if(param1 == null)
         {
            return;
         }
         if(param1.disposed)
         {
            return;
         }
         var _loc10_:int = param3 > 0 ? param3 : param1.height;
         var _loc7_:int = (param1.width - param2.width) / 2 + param4;
         var _loc8_:int = (_loc10_ - param2.height) / 2 + param5;
         if(param1 as class_2251 != null)
         {
            var _loc9_:class_2251 = class_2251(param1);
            if(_loc9_.bitmap == null || param3 > 0)
            {
               null.bitmap = new BitmapData(param1.width,_loc10_,true,0);
            }
            null.bitmap.fillRect(null.bitmap.rect,0);
            null.bitmap.copyPixels(param2,param2.rect,new Point(_loc7_,_loc8_),null,null,false);
            param1.invalidate();
         }
         else if(param1 as class_1970 != null)
         {
            var _loc6_:class_1970 = class_1970(param1);
            _loc6_.setDisplayObject(new Bitmap(param2));
         }
      }
      
      protected function get stuffData() : StringArrayStuffData
      {
         return var_1966;
      }
      
      protected function get widget() : FriendFurniEngravingWidget
      {
         return var_16;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function dispose() : void
      {
         if(!disposed)
         {
            destroyWindow();
            var_16 = null;
            var_1966 = null;
            _disposed = true;
         }
      }
      
      public function open() : void
      {
         createWindow();
      }
      
      public function close() : void
      {
         destroyWindow();
      }
      
      protected function assetName() : String
      {
         throw new IllegalOperationError("Must implement in concrete view!");
      }
      
      private function createWindow() : void
      {
         if(!_window)
         {
            _window = class_1812(widget.windowManager.buildFromXML(XML(widget.assets.getAssetByName(assetName()).content)));
            _window.procedure = windowProc;
            _window.center();
            _window.findChildByName("name_left").caption = stuffData.getValue(1);
            _window.findChildByName("name_right").caption = stuffData.getValue(2);
            _window.findChildByName("date").caption = stuffData.getValue(5);
            var _loc2_:class_1827 = widget.engravingWidgetHandler.container.avatarRenderManager.createAvatarImage(stuffData.getValue(3),"h",null,this);
            var _loc1_:class_1827 = widget.engravingWidgetHandler.container.avatarRenderManager.createAvatarImage(stuffData.getValue(4),"h",null,this);
            if(!null.isPlaceholder())
            {
               setAvatarImage("avatar_left",null.getCroppedImage("full"));
            }
            if(!null.isPlaceholder())
            {
               null.setDirection("full",4);
               setAvatarImage("avatar_right",null.getCroppedImage("full"));
            }
         }
      }
      
      public function avatarImageReady(param1:String) : void
      {
         var _loc3_:class_1827 = null;
         var _loc2_:class_1827 = null;
         if(param1 == stuffData.getValue(3))
         {
            _loc3_ = widget.engravingWidgetHandler.container.avatarRenderManager.createAvatarImage(stuffData.getValue(3),"h",null,this);
            setAvatarImage("avatar_left",_loc3_.getCroppedImage("full"));
         }
         if(param1 == stuffData.getValue(4))
         {
            _loc2_ = widget.engravingWidgetHandler.container.avatarRenderManager.createAvatarImage(stuffData.getValue(4),"h",null,this);
            _loc2_.setDirection("full",4);
            setAvatarImage("avatar_right",_loc2_.getCroppedImage("full"));
         }
      }
      
      private function setAvatarImage(param1:String, param2:BitmapData) : void
      {
         var _loc3_:class_2251 = class_2251(_window.findChildByName(param1));
         setElementImage(_loc3_,param2,0,0,0);
      }
      
      private function destroyWindow() : void
      {
         if(_window)
         {
            _window.dispose();
            _window = null;
         }
      }
      
      private function windowProc(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type == "WME_CLICK")
         {
            var _loc3_:* = param2.name;
            if("header_button_close" === _loc3_)
            {
               widget.close(widget.stuffId);
            }
         }
      }
   }
}

