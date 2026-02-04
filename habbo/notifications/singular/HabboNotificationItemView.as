package com.sulake.habbo.notifications.singular
{
   import com.sulake.core.assets.IAsset;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.runtime.class_31;
   import com.sulake.core.utils.class_55;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_1775;
   import com.sulake.core.window.components.class_2010;
   import com.sulake.core.window.components.class_2052;
   import com.sulake.core.window.components.class_2251;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.localization.class_27;
   import com.sulake.habbo.session.events.BadgeImageReadyEvent;
   import com.sulake.habbo.window.class_38;
   import com.sulake.habbo.window.widgets.IProductDisplayInfo;
   import com.sulake.habbo.window.widgets.class_2343;
   import flash.display.BitmapData;
   import flash.geom.Point;
   
   public class HabboNotificationItemView implements class_31
   {
      
      public static const MAX_HEIGHT:int = 70;
      
      public static const SIDE_MARGIN:int = 5;
      
      private static const STATE_IDLE:int = 0;
      
      private static const STATE_FADE_IN:int = 1;
      
      private static const STATE_DISPLAY:int = 2;
      
      private static const STATE_FADE_OUT:int = 3;
      
      private static const STATE_SWIPE_OUT:int = 4;
      
      private var var_167:class_27;
      
      private var _window:class_1741;
      
      private var var_452:HabboNotificationItem;
      
      private var _hovering:Boolean = false;
      
      private var _styleConfig:class_55;
      
      private var _viewConfig:class_55;
      
      private var var_2099:uint;
      
      private var var_2184:uint;
      
      private var var_1916:uint;
      
      private var var_2278:uint;
      
      private var _margin:int;
      
      private var var_916:Number;
      
      private var _resizeMargin:int;
      
      private var var_3482:int;
      
      private var var_61:int;
      
      private var var_4912:int;
      
      public function HabboNotificationItemView(param1:class_27, param2:IAsset, param3:class_38, param4:class_55, param5:class_55, param6:HabboNotificationItem)
      {
         super();
         var_167 = param1;
         _styleConfig = param4;
         _viewConfig = param5;
         var _loc7_:XmlAsset = param2 as XmlAsset;
         if(_loc7_ == null)
         {
            return;
         }
         _window = param3.buildFromXML(_loc7_.content as XML,1);
         _window.tags.push("notificationview");
         _window.context.getDesktopWindow().addEventListener("WE_RESIZED",onRoomViewResized);
         _window.procedure = onWindowEvent;
         _window.blend = 0;
         _window.visible = false;
         var _loc8_:ITextWindow = class_1812(_window).findChildByTag("notification_text") as ITextWindow;
         if(_loc8_ != null)
         {
            _resizeMargin = _window.height - _loc8_.bottom;
         }
         else
         {
            _resizeMargin = 15;
         }
         var_3482 = _window.height;
         _margin = 4;
         var_916 = 0;
         var_61 = 0;
         if(param6.style.styleName == "nft_opening")
         {
            showNftOpeningNotification(param6);
         }
         else if(param6.style.styleName == "treasure_hunt")
         {
            showTreasureHuntNotification(param6);
         }
         else
         {
            showNormalNotification(param6);
         }
      }
      
      public function get disposed() : Boolean
      {
         return _window == null;
      }
      
      public function get ready() : Boolean
      {
         return var_61 == 0;
      }
      
      public function get verticalPosition() : int
      {
         return _margin;
      }
      
      private function showTreasureHuntNotification(param1:HabboNotificationItem) : void
      {
         if(param1 == null)
         {
            return;
         }
         _window.findChildByName("treasure_hunt_image").visible = param1.style.icon == null;
         showNormalNotification(param1);
      }
      
      private function showNftOpeningNotification(param1:HabboNotificationItem) : void
      {
         if(param1 == null)
         {
            return;
         }
         var _loc6_:String = param1.content;
         setNotificationText(_loc6_);
         var _loc2_:IProductDisplayInfo = param1.style.extraData[0];
         var _loc7_:String = param1.style.extraData[1];
         var _loc5_:uint = uint(param1.style.extraData[2]);
         var _loc3_:class_2343 = (_window.findChildByName("icon_widget") as class_2010).widget as class_2343;
         _loc3_.productInfo = _loc2_;
         var _loc4_:class_1775 = _window.findChildByName("rarity_text") as class_1775;
         _loc4_.caption = var_167.getLocalization("collectibles.item.rarity") + ": " + _loc7_;
         reposition();
         startFadeIn();
      }
      
      private function showNormalNotification(param1:HabboNotificationItem) : void
      {
         var _loc2_:BitmapData = null;
         if(param1 == null)
         {
            return;
         }
         var _loc3_:String = param1.content;
         setNotificationText(_loc3_);
         if(param1.style.iconAssetUri == null)
         {
            _loc2_ = param1.style.icon;
            setNotificationIcon(_loc2_);
         }
         else
         {
            IStaticBitmapWrapperWindow(class_1812(_window).findChildByTag("notification_icon_static")).assetUri = param1.style.iconAssetUri;
         }
         var_452 = param1;
         reposition();
         startFadeIn();
      }
      
      public function replaceIcon(param1:BadgeImageReadyEvent) : void
      {
         if(param1.badgeId != var_452.style.iconSrc)
         {
            return;
         }
         if(param1.badgeImage != null)
         {
            setNotificationIcon(param1.badgeImage);
         }
      }
      
      public function update(param1:uint) : void
      {
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc2_:Number = NaN;
         switch(var_61)
         {
            case 1:
               var_2099 += param1;
               _loc3_ = var_2099 / Number(_viewConfig["time_fade_in"]);
               if(var_2099 > int(_viewConfig["time_fade_in"]))
               {
                  startDisplay();
               }
               adjustBlend(_loc3_);
               break;
            case 2:
               var_2278 += param1;
               if(var_2278 > int(_viewConfig["time_display"]) && !_hovering)
               {
                  startFadeOut();
               }
               break;
            case 3:
               var_2184 += param1;
               _loc4_ = 1 - var_2184 / Number(_viewConfig["time_fade_out"]);
               adjustBlend(_loc4_);
               if(var_2184 > int(_viewConfig["time_fade_out"]))
               {
                  startIdling();
               }
               break;
            case 4:
               var_1916 += param1;
               _loc2_ = var_1916 / Number(_viewConfig["time_swipe_out"]);
               adjustSwipeOut(_loc2_);
               if(var_1916 > int(_viewConfig["time_swipe_out"]))
               {
                  startIdling();
               }
         }
      }
      
      public function dispose() : void
      {
         if(_window != null)
         {
            _window.dispose();
            _window = null;
         }
         if(var_452 != null)
         {
            var_452.dispose();
            var_452 = null;
         }
      }
      
      private function setNotificationText(param1:String) : void
      {
         var _loc2_:ITextWindow = class_1812(_window).findChildByTag("notification_text") as ITextWindow;
         if(_loc2_ == null || param1 == null)
         {
            return;
         }
         _window.height = 0;
         _loc2_.text = param1;
         _loc2_.height = _loc2_.textHeight + _resizeMargin;
         if(_window.height < var_3482)
         {
            _window.height = var_3482;
         }
      }
      
      private function setNotificationIcon(param1:BitmapData) : void
      {
         var _loc6_:BitmapData = null;
         var _loc5_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:class_2251 = class_1812(_window).findChildByTag("notification_icon") as class_2251;
         if(_loc4_ == null)
         {
            return;
         }
         if(param1 == null)
         {
            _loc4_.bitmap = null;
            return;
         }
         if(param1.width < _loc4_.width && param1.height < _loc4_.height)
         {
            _loc6_ = new BitmapData(_loc4_.width,_loc4_.height,true,0);
            _loc2_ = (_loc4_.width - param1.width) / 2;
            _loc3_ = (_loc4_.height - param1.height) / 2;
            _loc6_.copyPixels(param1,param1.rect,new Point(_loc2_,_loc3_));
         }
         else if(param1.width < param1.height)
         {
            _loc6_ = new BitmapData(param1.height,param1.height,true,0);
            _loc5_ = (param1.height - param1.width) / 2;
            _loc6_.copyPixels(param1,param1.rect,new Point(_loc5_,0));
         }
         else if(param1.width > param1.height)
         {
            _loc6_ = new BitmapData(param1.width,param1.width,true,0);
            _loc5_ = (param1.width - param1.height) / 2;
            _loc6_.copyPixels(param1,param1.rect,new Point(0,_loc5_));
         }
         else
         {
            _loc6_ = new BitmapData(param1.width,param1.height);
            _loc6_.copyPixels(param1,param1.rect,new Point(0,0));
         }
         _loc4_.bitmap = _loc6_;
      }
      
      private function startFadeIn() : void
      {
         var_2099 = 0;
         var_61 = 1;
         _window.visible = true;
      }
      
      private function startFadeOut() : void
      {
         var_2184 = 0;
         var_61 = 3;
      }
      
      private function startSwipeOut() : void
      {
         var_1916 = 0;
         var_61 = 4;
      }
      
      private function startDisplay() : void
      {
         var_2278 = 0;
         var_61 = 2;
      }
      
      private function startIdling() : void
      {
         var_61 = 0;
         _window.visible = false;
      }
      
      public function reposition(param1:int = -1) : void
      {
         if(_window == null)
         {
            return;
         }
         var _loc2_:class_2052 = _window.context.getDesktopWindow();
         if(_loc2_ == null)
         {
            return;
         }
         if(param1 != -1)
         {
            _margin = param1;
         }
         _window.x = _loc2_.width - _window.width - 5;
         _window.y = _margin;
         var_4912 = _window.x;
      }
      
      public function onWindowEvent(param1:class_1758, param2:class_1741) : void
      {
         if(param1 == null)
         {
            return;
         }
         if(param1.type == "WME_CLICK" && param1.target.tags.indexOf("slide_notification_away") != -1)
         {
            startSwipeOut();
            return;
         }
         if(param1.type == "WME_OVER")
         {
            _hovering = true;
         }
         else if(param1.type == "WME_OUT")
         {
            _hovering = false;
         }
         else if(param1.type == "WME_CLICK")
         {
            if(var_452 != null)
            {
               var_452.ExecuteUiLinks();
               startFadeOut();
            }
         }
      }
      
      private function onRoomViewResized(param1:class_1758) : void
      {
         reposition();
      }
      
      private function adjustBlend(param1:Number) : void
      {
         var_916 = param1;
         if(var_916 > 1)
         {
            var_916 = 1;
         }
         if(var_916 < 0)
         {
            var_916 = 0;
         }
         _window.blend = var_916;
      }
      
      private function adjustSwipeOut(param1:Number) : void
      {
         _window.x = var_4912 + param1 * _viewConfig["distance_swipe_out"];
      }
      
      public function get height() : int
      {
         return int(_viewConfig["height"]);
      }
   }
}

