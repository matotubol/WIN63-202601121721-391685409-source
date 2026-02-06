package com.sulake.habbo.notifications.singular
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.assets.class_40;
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.runtime.class_17;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_1775;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.localization.class_27;
   import com.sulake.habbo.notifications.HabboNotifications;
   import com.sulake.habbo.toolbar.IHabboToolbar;
   import com.sulake.habbo.window.class_38;
   import com.sulake.room.utils.ColorConverter;
   import com.sulake.habbo.communication.messages.incoming.competition.SecondsUntilMessageEvent;
   import com.sulake.habbo.communication.messages.outgoing.competition.GetSecondsUntilMessageComposer;
   
   public class NewFeatureNotification implements class_13
   {
      
      private static const FEATURE_TYPE_NORMAL:String = "normal";
      
      private static const FEATURE_TYPE_PROMO:String = "promo";
      
      private static const BG_COLOR_NORMAL:String = "#686661";
      
      private static const LINK_COLOR_NORMAL:uint = 16777215;
      
      private static const LINK_COLOR_HIGHLIGHT:uint = 12247545;
      
      private var _window:class_1812;
      
      private var _toolbar:IHabboToolbar;
      
      private var var_167:class_27;
      
      private var var_1775:ITextWindow;
      
      private var _key:String;
      
      private var _windowManager:class_38;
      
      private var _assets:class_40;
      
      private var var_704:Boolean;
      
      private var var_948:SecondsUntilMessageEvent;
      
      private var _notifications:HabboNotifications;
      
      private var var_1066:String = "normal";
      
      private var _disposed:Boolean;
      
      public function NewFeatureNotification(param1:class_40, param2:class_38, param3:IHabboToolbar, param4:class_27, param5:HabboNotifications, param6:String)
      {
         super();
         if(!param1 || !param2)
         {
            return;
         }
         _key = param6;
         _toolbar = param3;
         var_167 = param4;
         _assets = param1;
         _windowManager = param2;
         _notifications = param5;
         var_704 = false;
         var _loc7_:String = getString("notifications.new_feature.expiry." + _key);
         if(_loc7_ != null && _loc7_.length > 0)
         {
            var_948 = new SecondsUntilMessageEvent(onTime);
            param5.communication.addHabboConnectionMessageEvent(var_948);
            param5.communication.connection.send(new GetSecondsUntilMessageComposer(_loc7_));
         }
         else
         {
            var_704 = true;
            init();
         }
      }
      
      private function onTime(param1:SecondsUntilMessageEvent) : void
      {
         if(_disposed || var_704)
         {
            return;
         }
         var _loc2_:String = getString("notifications.new_feature.expiry." + _key);
         if(param1.getParser().timeStr == _loc2_)
         {
            var_704 = true;
            if(param1.getParser().secondsUntil > 0)
            {
               if(var_948 != null)
               {
                  _notifications.communication.removeHabboConnectionMessageEvent(var_948);
                  var_948 = null;
               }
               init();
            }
            else
            {
               dispose();
            }
         }
      }
      
      private function init() : void
      {
         var_1066 = getString("notifications.new_feature.type." + _key);
         if(var_1066 == null || var_1066.length == 0)
         {
            var_1066 = "normal";
         }
         var _loc1_:XmlAsset = _assets.getAssetByName(var_1066 == "normal" ? "new_feature_notification_xml" : "new_feature_notification_" + var_1066 + "_xml") as XmlAsset;
         if(_loc1_ == null)
         {
            return;
         }
         _window = _windowManager.buildFromXML(_loc1_.content as XML) as class_1812;
         if(_window == null)
         {
            return;
         }
         _window.procedure = eventHandler;
         _toolbar.extensionView.attachExtension("new_feature_" + _key,_window);
         if(var_1066 == "normal")
         {
            var_1775 = _window.findChildByName("cancel_link") as ITextWindow;
            var _loc2_:IRegionWindow = _window.findChildByName("cancel_link_region") as IRegionWindow;
         }
         else if(var_1066 == "promo")
         {
            var_1775 = _window.findChildByName("desc") as ITextWindow;
            _loc2_ = _window as IRegionWindow;
         }
         initLayout();
      }
      
      private function initLayout() : void
      {
         var _loc2_:* = 0;
         var _loc1_:String = getString("notifications.new_feature.image." + _key);
         var _loc3_:String = getString("notifications.new_feature.color." + _key);
         if(_loc3_ == "")
         {
            _loc3_ = "#686661";
         }
         var _loc8_:ITextWindow = _window.findChildByName("desc") as ITextWindow;
         _loc8_.text = var_167.getLocalization("notifications.new_feature." + _key + ".desc");
         var _loc5_:IStaticBitmapWrapperWindow = _window.findChildByName("static_bitmap") as IStaticBitmapWrapperWindow;
         _loc5_.assetUri = _loc1_;
         var _loc6_:uint = ColorConverter.hexToUint(_loc3_);
         var _loc7_:class_1741 = _window.findChildByName("border");
         if(_loc7_ == null)
         {
            _loc7_ = _window;
         }
         _loc7_.color = _loc6_;
         var _loc4_:uint = uint(ColorConverter.rgbToHSL(_loc6_));
         var _loc9_:class_1775 = _window.findChildByName("open_button") as class_1775;
         if(_loc9_ != null)
         {
            _loc2_ = uint(255 - int((255 - (_loc4_ & 0xFF)) / 2) | _loc4_ & 0xFFFF00);
            _loc9_.color = ColorConverter.hslToRGB(_loc2_);
         }
      }
      
      private function getBoolean(param1:String) : Boolean
      {
         return (_toolbar as class_17).getBoolean(param1);
      }
      
      private function getString(param1:String) : String
      {
         return (_toolbar as class_17).getProperty(param1);
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         if(var_948 != null)
         {
            _notifications.communication.removeHabboConnectionMessageEvent(var_948);
            var_948 = null;
         }
         if(_toolbar && var_704)
         {
            _toolbar.extensionView.detachExtension("new_feature_" + _key);
         }
         if(_window != null)
         {
            _window.dispose();
            _window = null;
         }
         _windowManager = null;
         _assets = null;
         var_1775 = null;
         _toolbar = null;
         _notifications = null;
         _disposed = true;
      }
      
      private function eventHandler(param1:class_1758, param2:class_1741) : void
      {
         var _loc4_:String = null;
         var _loc3_:class_1741 = null;
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         switch(param2.name)
         {
            case "open_button":
            case "main_region":
               _loc4_ = getString("notifications.new_feature.internal_link." + _key);
               (_toolbar as class_17).context.createLinkEvent(_loc4_);
               _loc3_ = _window.findChildByName("cancel_link_region");
               if(_loc3_ != null && !_loc3_.visible)
               {
                  _loc3_.visible = true;
               }
               break;
            case "cancel_link_region":
            case "cancel_link":
               dispose();
               return;
         }
      }
      
      private function onMouseOver(param1:WindowMouseEvent) : void
      {
         var_1775.textColor = 12247545;
      }
      
      private function onMouseOut(param1:WindowMouseEvent) : void
      {
         var_1775.textColor = 16777215;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
   }
}

