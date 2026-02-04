package com.sulake.habbo.inventory
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.class_40;
   import com.sulake.core.assets.loaders.AssetLoaderEvent;
   import com.sulake.core.assets.loaders.BitmapFileLoader;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.*;
   import com.sulake.habbo.inventory.trading.TradingModel;
   import com.sulake.habbo.room.IStuffData;
   import com.sulake.habbo.utils.StringUtil;
   import com.sulake.habbo.window.class_38;
   import com.sulake.habbo.window.widgets.ILimitedItemPreviewOverlayWidget;
   import com.sulake.habbo.window.widgets.IProductDisplayInfo;
   import com.sulake.habbo.window.widgets.class_1902;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.utils.Timer;
   import package_69.JSONDecoder;
   
   public class ItemPopupCtrl
   {
      
      public static const const_426:int = 1;
      
      public static const LOCATION_RIGHT:int = 2;
      
      private static const BOUNDS_MARGIN:int = -5;
      
      private static const OPEN_DELAY_MS:int = 250;
      
      private static const CLOSE_DELAY_MS:int = 100;
      
      private static const IMAGE_MAX_WIDTH:int = 180;
      
      private static const IMAGE_MAX_HEIGHT:int = 200;
      
      private var var_683:Timer = new Timer(250,1);
      
      private var _hideDelayTimer:Timer = new Timer(100,1);
      
      private var _assets:class_40;
      
      private var var_94:class_1812;
      
      private var _parent:class_1812;
      
      private var var_3770:int = 2;
      
      private var var_1456:BitmapData;
      
      private var var_1726:BitmapData;
      
      private var var_23:TradingModel;
      
      private var _windowManager:class_38;
      
      private var var_2417:Boolean = false;
      
      public function ItemPopupCtrl(param1:class_1812, param2:class_40, param3:class_38, param4:TradingModel)
      {
         super();
         if(param1 == null || param2 == null)
         {
            throw new Error("Null pointers passed as argument!");
         }
         var_94 = param1;
         var_94.visible = false;
         _assets = param2;
         _windowManager = param3;
         var_683.addEventListener("timer",onDisplayTimer);
         _hideDelayTimer.addEventListener("timer",onHideTimer);
         var_23 = param4;
         var _loc5_:BitmapDataAsset = _assets.getAssetByName("popup_arrow_right_png") as BitmapDataAsset;
         if(_loc5_ != null && _loc5_.content != null)
         {
            var_1726 = _loc5_.content as BitmapData;
         }
         _loc5_ = _assets.getAssetByName("popup_arrow_left_png") as BitmapDataAsset;
         if(_loc5_ != null && _loc5_.content != null)
         {
            var_1456 = _loc5_.content as BitmapData;
         }
      }
      
      public function dispose() : void
      {
         if(var_683 != null)
         {
            var_683.removeEventListener("timer",onDisplayTimer);
            var_683.stop();
            var_683 = null;
         }
         if(_hideDelayTimer != null)
         {
            _hideDelayTimer.removeEventListener("timer",onHideTimer);
            _hideDelayTimer.stop();
            _hideDelayTimer = null;
         }
         _assets = null;
         var_94 = null;
         _parent = null;
         var_1456 = null;
         var_1726 = null;
      }
      
      public function updateContent(param1:class_1812, param2:String, param3:BitmapData = null, param4:IProductDisplayInfo = null, param5:IStuffData = null, param6:int = 2, param7:Boolean = false) : void
      {
         if(var_94 == null)
         {
            return;
         }
         if(param1 == null)
         {
            return;
         }
         if(param3 == null)
         {
            param3 = new BitmapData(1,1,true,16777215);
         }
         if(_parent != null)
         {
            _parent.removeChild(var_94);
         }
         _parent = param1;
         var_3770 = param6;
         var_2417 = false;
         var _loc14_:ITextWindow = ITextWindow(var_94.findChildByName("item_name_text"));
         if(_loc14_)
         {
            _loc14_.text = param2;
         }
         var _loc17_:class_2010 = class_2010(var_94.findChildByName("nft_image"));
         var _loc15_:IStaticBitmapWrapperWindow = IStaticBitmapWrapperWindow(var_94.findChildByName("nft_overlay_icon"));
         var _loc10_:class_2010 = class_2010(var_94.findChildByName("unique_item_overlay_widget"));
         var _loc9_:class_2251 = var_94.findChildByName("item_image") as class_2251;
         var _loc18_:class_1902 = _loc17_.widget as class_1902;
         if(param4 != null)
         {
            _loc17_.visible = true;
            _loc15_.visible = true;
            _loc10_.visible = false;
            _loc9_.visible = false;
            _loc18_.productInfo = param4;
            var_94.height = _loc17_.bottom + 28;
            return;
         }
         _loc17_.visible = false;
         _loc18_.clearPreviewer();
         _loc15_.visible = false;
         _loc9_.visible = true;
         if(param7 && var_23)
         {
            _loc10_.visible = false;
            _loc9_.bitmap = new BitmapData(1,1,true,16777215);
            if(param5 != null)
            {
               var_2417 = true;
               var _loc16_:String = param5.getJSONValue("id");
               if(!StringUtil.isBlank(null))
               {
                  loadExtraData(null);
               }
               else
               {
                  var _loc13_:String = param5.getJSONValue("w");
                  if(!StringUtil.isBlank(null))
                  {
                     var _loc11_:String = var_23.getInventory().getProperty("stories.image_url_base") + null;
                     loadImage(null);
                  }
               }
            }
            return;
         }
         var _loc8_:BitmapData = new BitmapData(Math.min(180,param3.width),Math.min(200,param3.height),true,16777215);
         _loc8_.copyPixels(param3,new Rectangle(0,0,_loc8_.width,_loc8_.height),new Point(0,0),null,null,true);
         _loc9_.bitmap = _loc8_;
         _loc9_.width = _loc9_.bitmap.width;
         _loc9_.height = _loc9_.bitmap.height;
         _loc9_.x = (var_94.width - _loc9_.width) / 2;
         var_94.height = _loc9_.bottom + 10;
         if(param5 != null && param5.uniqueSerialNumber > 0)
         {
            var _loc12_:ILimitedItemPreviewOverlayWidget = ILimitedItemPreviewOverlayWidget(_loc10_.widget);
            _loc12_.serialNumber = param5.uniqueSerialNumber;
            null.seriesSize = param5.uniqueSeriesSize;
         }
         else
         {
            _loc10_.visible = false;
         }
      }
      
      private function loadExtraData(param1:String) : void
      {
         var _loc3_:String = var_23.getInventory().getProperty("extra_data_service_url") + param1;
         var _loc2_:URLLoader = new URLLoader(new URLRequest(_loc3_));
         _loc2_.addEventListener("complete",onExtraDataLoaded);
      }
      
      private function onExtraDataLoaded(param1:Event) : void
      {
         var _loc2_:Object = null;
         var _loc3_:String = URLLoader(param1.target).data;
         if(var_2417 && !StringUtil.isBlank(_loc3_))
         {
            try
            {
               _loc2_ = new JSONDecoder(_loc3_,false).getValue();
               loadImage(_loc2_.url);
            }
            catch(error:Error)
            {
            }
         }
      }
      
      private function loadImage(param1:String) : void
      {
         if(!StringUtil.isBlank(param1))
         {
            var _loc2_:BitmapFileLoader = new BitmapFileLoader("image/png",new URLRequest(param1));
            null.addEventListener("AssetLoaderEventComplete",onExtImageLoaded);
         }
      }
      
      private function onExtImageLoaded(param1:AssetLoaderEvent) : void
      {
         if(!var_94 || !var_2417)
         {
            return;
         }
         var _loc4_:class_2251 = var_94.findChildByName("item_image") as class_2251;
         if(!_loc4_ || _assets == null)
         {
            return;
         }
         var _loc6_:DisplayObject = BitmapFileLoader(param1.target).content as DisplayObject;
         var _loc2_:BitmapData = new BitmapData(Math.min(180,_loc6_.width),Math.min(200,_loc6_.height),true,16777215);
         var _loc3_:Number = 180 / _loc6_.width;
         var _loc5_:Matrix = new Matrix();
         _loc5_.scale(_loc3_,_loc3_);
         _loc2_.draw(_loc6_,_loc5_);
         _loc4_.bitmap = _loc2_;
         _loc4_.width = _loc4_.bitmap.width;
         _loc4_.height = _loc4_.bitmap.height;
         _loc4_.x = (var_94.width - _loc4_.width) / 2;
         var_94.height = _loc4_.bottom + 10;
      }
      
      public function show() : void
      {
         _hideDelayTimer.reset();
         var_683.reset();
         if(_parent == null)
         {
            return;
         }
         var_94.visible = true;
         _parent.addChild(var_94);
         refreshArrow(var_3770);
         switch(var_3770 - 1)
         {
            case 0:
               var_94.x = -1 * var_94.width - -5;
               break;
            case 1:
               var_94.x = _parent.width + -5;
         }
         var_94.y = (_parent.height - var_94.height) / 2;
      }
      
      public function hide() : void
      {
         var_94.visible = false;
         _hideDelayTimer.reset();
         var_683.reset();
         if(_parent != null)
         {
            _parent.removeChild(var_94);
         }
      }
      
      public function showDelayed() : void
      {
         _hideDelayTimer.reset();
         var_683.reset();
         var_683.start();
      }
      
      public function hideDelayed() : void
      {
         _hideDelayTimer.reset();
         var_683.reset();
         _hideDelayTimer.start();
      }
      
      private function refreshArrow(param1:int = 2) : void
      {
         if(var_94 == null || Boolean(var_94.disposed))
         {
            return;
         }
         var _loc2_:class_2251 = class_2251(var_94.findChildByName("arrow_pointer"));
         if(!_loc2_)
         {
            return;
         }
         switch(param1 - 1)
         {
            case 0:
               _loc2_.bitmap = var_1726.clone();
               _loc2_.width = var_1726.width;
               _loc2_.height = var_1726.height;
               _loc2_.y = (var_94.height - var_1726.height) / 2;
               _loc2_.x = var_94.width - 1;
               break;
            case 1:
               _loc2_.bitmap = var_1456.clone();
               _loc2_.width = var_1456.width;
               _loc2_.height = var_1456.height;
               _loc2_.y = (var_94.height - var_1456.height) / 2;
               _loc2_.x = -1 * var_1456.width + 1;
         }
         _loc2_.invalidate();
      }
      
      private function onDisplayTimer(param1:TimerEvent) : void
      {
         show();
      }
      
      private function onHideTimer(param1:TimerEvent) : void
      {
         hide();
      }
   }
}

