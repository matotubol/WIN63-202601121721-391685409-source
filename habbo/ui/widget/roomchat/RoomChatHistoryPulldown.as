package com.sulake.habbo.ui.widget.roomchat
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.assets.class_40;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.class_2251;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.window.class_38;
   import flash.display.BitmapData;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class RoomChatHistoryPulldown
   {
      
      public static const STATE_FADE_OUT:int = 3;
      
      public static const STATE_FADE_IN:int = 2;
      
      public static const STATE_VISIBLE:int = 1;
      
      public static const STATE_HIDDEN:int = 0;
      
      public static const PULLDOWN_WINDOW_HEIGHT:int = 39;
      
      private static const FADE_OUT_MS:int = 150;
      
      private static const FADE_IN_MS:int = 250;
      
      private var var_16:RoomChatWidget;
      
      private var _windowManager:class_38;
      
      private var _window:class_1812;
      
      private var var_154:class_2251;
      
      private var var_72:class_1812;
      
      private var var_308:IRegionWindow;
      
      private var var_909:class_40;
      
      private var _lastWidth:int = 0;
      
      private var var_61:int = -1;
      
      private var var_4971:BitmapData;
      
      private var var_3395:BitmapData;
      
      private var var_5007:BitmapData;
      
      private var var_3686:BitmapData;
      
      private var var_3700:BitmapData;
      
      private var var_4505:BitmapData;
      
      private var var_4091:BitmapData;
      
      private var _regionRightMargin:int = 30;
      
      public function RoomChatHistoryPulldown(param1:RoomChatWidget, param2:class_38, param3:class_1812, param4:class_40)
      {
         super();
         var_16 = param1;
         _windowManager = param2;
         var_909 = param4;
         var_72 = param3;
         var_4971 = (var_909.getAssetByName("chat_grapbar_bg") as BitmapDataAsset).content as BitmapData;
         var_3395 = (var_909.getAssetByName("chat_grapbar_grip") as BitmapDataAsset).content as BitmapData;
         var_5007 = (var_909.getAssetByName("chat_grapbar_handle") as BitmapDataAsset).content as BitmapData;
         var_3686 = (var_909.getAssetByName("chat_grapbar_x") as BitmapDataAsset).content as BitmapData;
         var_3700 = (var_909.getAssetByName("chat_grapbar_x_hi") as BitmapDataAsset).content as BitmapData;
         var_4505 = (var_909.getAssetByName("chat_grapbar_x_pr") as BitmapDataAsset).content as BitmapData;
         var_4091 = (var_909.getAssetByName("chat_history_bg") as BitmapDataAsset).content as BitmapData;
         var_154 = _windowManager.createWindow("chat_history_bg","",21,0,16,new Rectangle(0,0,param3.width,param3.height - 39),null,0,0) as class_2251;
         var_72.addChild(var_154);
         _window = _windowManager.createWindow("chat_pulldown","",4,0,1 | 0x10,new Rectangle(0,var_72.height - 39,param3.width,39),null,0) as class_1812;
         var_72.addChild(_window);
         var_308 = _windowManager.createWindow("REGIONchat_pulldown","",5,0,1 | 0x10 | 0 | 0,new Rectangle(0,0,param3.width,param3.height - 39),null,0) as IRegionWindow;
         if(var_308 != null)
         {
            var_308.background = true;
            var_308.mouseThreshold = 0;
            var_308.addEventListener("WME_DOWN",onPulldownMouseDown);
            var_72.addChild(var_308);
            var_308.toolTipCaption = "${chat.history.drag.tooltip}";
            var_308.toolTipDelay = 250;
         }
         var _loc6_:XmlAsset = param4.getAssetByName("chat_history_pulldown") as XmlAsset;
         _window.buildFromXML(_loc6_.content as XML);
         _window.addEventListener("WME_DOWN",onPulldownMouseDown);
         var _loc5_:class_2251 = _window.findChildByName("GrapBarX") as class_2251;
         if(_loc5_ != null)
         {
            _loc5_.mouseThreshold = 0;
            _loc5_.addEventListener("WME_CLICK",onCloseButtonClicked);
            _loc5_.addEventListener("WME_UP",onCloseButtonMouseUp);
            _loc5_.addEventListener("WME_DOWN",onCloseButtonMouseDown);
            _loc5_.addEventListener("WME_OVER",onCloseButtonMouseOver);
            _loc5_.addEventListener("WME_OUT",onCloseButtonMouseOut);
         }
         _window.background = true;
         _window.color = 0;
         _window.mouseThreshold = 0;
         this.state = 0;
         buildWindowGraphics();
      }
      
      public function dispose() : void
      {
         if(var_308 != null)
         {
            var_308.dispose();
            var_308 = null;
         }
         if(_window != null)
         {
            _window.dispose();
            _window = null;
         }
         if(var_154 != null)
         {
            var_154.dispose();
            var_154 = null;
         }
      }
      
      public function update(param1:uint) : void
      {
         switch(state - 2)
         {
            case 0:
               var_154.blend += param1 / 250;
               _window.blend += param1 / 250;
               if(_window.blend >= 1)
               {
                  state = 1;
               }
               break;
            case 1:
               var_154.blend -= param1 / 150;
               _window.blend -= param1 / 150;
               if(_window.blend <= 0)
               {
                  state = 0;
               }
         }
      }
      
      public function set state(param1:int) : void
      {
         if(param1 == var_61)
         {
            return;
         }
         switch(param1)
         {
            case 0:
               if(_window == null || var_154 == null)
               {
                  return;
               }
               _window.visible = false;
               var_154.visible = false;
               var_308.visible = false;
               var_61 = param1;
               break;
            case 1:
               if(var_61 == 0)
               {
                  this.state = 2;
                  break;
               }
               if(_window == null || var_154 == null)
               {
                  return;
               }
               _window.visible = true;
               var_154.visible = true;
               var_308.visible = true;
               var_61 = param1;
               break;
            case 2:
               if(_window == null || var_154 == null)
               {
                  return;
               }
               _window.blend = 0;
               var_154.blend = 0;
               _window.visible = true;
               var_154.visible = true;
               var_61 = param1;
               break;
            case 3:
               if(_window == null || var_154 == null)
               {
                  return;
               }
               _window.blend = 1;
               var_154.blend = 1;
               var_61 = param1;
         }
      }
      
      public function get state() : int
      {
         return var_61;
      }
      
      public function containerResized(param1:Rectangle) : void
      {
         if(_window != null)
         {
            _window.x = 0;
            _window.y = var_72.height - 39;
            _window.width = var_72.width;
         }
         if(var_308 != null)
         {
            var_308.x = 0;
            var_308.y = var_72.height - 39;
            var_308.width = var_72.width - _regionRightMargin;
         }
         if(var_154 != null)
         {
            var_154.rectangle = var_72.rectangle;
            var_154.height -= 39;
         }
         buildWindowGraphics();
      }
      
      private function buildWindowGraphics() : void
      {
         if(_window == null)
         {
            return;
         }
         if(_lastWidth == _window.width)
         {
            return;
         }
         _lastWidth = _window.width;
         var _loc6_:class_2251 = _window.findChildByName("grapBarBg") as class_2251;
         var _loc8_:class_2251 = _window.findChildByName("GrapBarX") as class_2251;
         var _loc1_:class_2251 = _window.findChildByName("grapBarGripL") as class_2251;
         var _loc9_:class_2251 = _window.findChildByName("grapBarGripR") as class_2251;
         var _loc4_:class_2251 = _window.findChildByName("grapBarHandle") as class_2251;
         var _loc11_:int = 5;
         if(_loc8_ != null && _loc4_ != null)
         {
            _loc4_.bitmap = var_5007;
            _loc4_.disposesBitmap = false;
            _loc8_.bitmap = var_3686;
            _loc8_.disposesBitmap = false;
            _regionRightMargin = _window.width - _loc8_.x;
         }
         _loc1_.width = _loc4_.x - _loc11_;
         _loc1_.x = 0;
         _loc9_.x = _loc4_.x + _loc4_.width + _loc11_;
         _loc9_.width = _loc8_.x - _loc11_ - _loc9_.x;
         if(_loc1_.width < 0)
         {
            _loc1_.width = 0;
         }
         if(_loc9_.width < 0)
         {
            _loc9_.width = 0;
         }
         var _loc10_:int = 0;
         if(_loc6_ != null && _loc1_ != null && _loc9_ != null)
         {
            try
            {
               _loc10_ = 1;
               var _loc2_:int = int(_loc6_.width);
               var _loc12_:int = int(_loc6_.height);
               _loc10_ = 2;
               _loc2_ = int(_loc1_.width);
               _loc12_ = int(_loc1_.height);
               _loc10_ = 3;
               _loc2_ = int(_loc9_.width);
               _loc12_ = int(_loc9_.height);
            }
            catch(e:Error)
            {
               throw new Error(e.message + " width:" + 0 + " height:" + 0 + " state:" + _loc10_,e.errorID);
            }
         }
         if(var_154 == null)
         {
            return;
         }
         var_154.bitmap = var_4091;
         var_154.disposesBitmap = false;
      }
      
      private function tileBitmapHorz(param1:BitmapData, param2:BitmapData) : void
      {
         var _loc4_:int = 0;
         var _loc3_:int = param2.width / param1.width;
         var _loc5_:Point = new Point();
         _loc4_ = 0;
         while(_loc4_ < _loc3_ + 1)
         {
            _loc5_.x = _loc4_ * param1.width;
            param2.copyPixels(param1,param1.rect,_loc5_);
            _loc4_++;
         }
      }
      
      private function onPulldownMouseDown(param1:WindowMouseEvent) : void
      {
         if(var_16 != null)
         {
            var_16.onPulldownMouseDown(param1);
         }
      }
      
      private function onCloseButtonClicked(param1:WindowMouseEvent) : void
      {
         if(var_16 != null)
         {
            var_16.onPulldownCloseButtonClicked(param1);
         }
      }
      
      private function onCloseButtonMouseOver(param1:WindowMouseEvent) : void
      {
         if(_window == null)
         {
            return;
         }
         if(!_window.visible)
         {
            return;
         }
         var _loc2_:class_2251 = _window.findChildByName("GrapBarX") as class_2251;
         if(_loc2_ != null)
         {
            _loc2_.disposesBitmap = false;
            _loc2_.bitmap = var_3700;
         }
      }
      
      private function onCloseButtonMouseOut(param1:WindowMouseEvent) : void
      {
         if(_window == null)
         {
            return;
         }
         if(!_window.visible)
         {
            return;
         }
         var _loc2_:class_2251 = _window.findChildByName("GrapBarX") as class_2251;
         if(_loc2_ != null)
         {
            _loc2_.disposesBitmap = false;
            _loc2_.bitmap = var_3686;
         }
      }
      
      private function onCloseButtonMouseDown(param1:WindowMouseEvent) : void
      {
         if(_window == null)
         {
            return;
         }
         if(!_window.visible)
         {
            return;
         }
         var _loc2_:class_2251 = _window.findChildByName("GrapBarX") as class_2251;
         if(_loc2_ != null)
         {
            _loc2_.disposesBitmap = false;
            _loc2_.bitmap = var_4505;
         }
      }
      
      private function onCloseButtonMouseUp(param1:WindowMouseEvent) : void
      {
         if(_window == null)
         {
            return;
         }
         if(!_window.visible)
         {
            return;
         }
         var _loc2_:class_2251 = _window.findChildByName("GrapBarX") as class_2251;
         if(_loc2_ != null)
         {
            _loc2_.disposesBitmap = false;
            _loc2_.bitmap = var_3700;
         }
      }
   }
}

