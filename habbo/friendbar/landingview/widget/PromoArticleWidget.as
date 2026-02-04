package com.sulake.habbo.friendbar.landingview.widget
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.runtime.class_31;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.communication.messages.outgoing.landingview.class_3261;
   import com.sulake.habbo.friendbar.landingview.HabboLandingView;
   import com.sulake.habbo.friendbar.landingview.interfaces.ILandingViewWidget;
   import com.sulake.habbo.friendbar.landingview.interfaces.ISettingsAwareWidget;
   import com.sulake.habbo.friendbar.landingview.layout.CommonWidgetSettings;
   import com.sulake.habbo.friendbar.landingview.layout.WidgetContainerLayout;
   import com.sulake.habbo.utils.HabboWebTools;
   import package_101.class_2356;
   import package_101.class_4098;
   
   public class PromoArticleWidget implements ILandingViewWidget, ISettingsAwareWidget, class_31
   {
      
      private static const REFRESH_PERIOD_IN_MILLIS:Number = 600000;
      
      private static const FADE_LENGTH:Number = 500;
      
      private static const MAX_ARTICLES:int = 10;
      
      private var _landingView:HabboLandingView;
      
      private var _container:class_1812;
      
      private var var_763:int = 0;
      
      private var var_993:Array = [];
      
      private var _lastRequestTime:Date;
      
      private var var_1637:IMessageEvent;
      
      private var var_1317:uint = 0;
      
      public function PromoArticleWidget(param1:HabboLandingView)
      {
         super();
         _landingView = param1;
      }
      
      public function initialize() : void
      {
         _container = class_1812(_landingView.getXmlWindow("promo_article"));
         _container.procedure = onMouse;
         var_1637 = new class_2356(onPromoArticles);
         _landingView.communicationManager.addHabboConnectionMessageEvent(var_1637);
      }
      
      public function refresh() : void
      {
         if(_lastRequestTime == null || _lastRequestTime.time + 600000 < new Date().time)
         {
            _landingView.send(new class_3261());
            _lastRequestTime = new Date();
         }
         else
         {
            goToArticle(var_763);
         }
      }
      
      public function get container() : class_1741
      {
         return _container;
      }
      
      public function dispose() : void
      {
         if(var_1637 && _landingView)
         {
            _landingView.communicationManager.removeHabboConnectionMessageEvent(var_1637);
            var_1637.dispose();
            var_1637 = null;
         }
         if(_container)
         {
            _container.dispose();
            _container = null;
         }
         _landingView = null;
      }
      
      public function get disposed() : Boolean
      {
         return _landingView == null;
      }
      
      public function set settings(param1:CommonWidgetSettings) : void
      {
         WidgetContainerLayout.applyCommonWidgetSettings(_container,param1);
      }
      
      private function refreshContent() : void
      {
         setArticleContent();
         setNavigationDisks();
      }
      
      private function setArticleContent() : void
      {
         var _loc1_:class_4098 = var_993[var_763];
         if(_loc1_)
         {
            _container.findChildByName("promo_title").caption = _loc1_.title;
            _container.findChildByName("promo_text").caption = _loc1_.bodyText;
            _container.findChildByName("button").visible = !(_loc1_.linkType == 2 || _loc1_.linkType == 0 && _loc1_.linkContent == "");
            _container.findChildByName("button").immediateClickMode = true;
            _container.findChildByName("button").caption = _loc1_.buttonText;
            _container.findChildByName("promo_image").visible = _loc1_.imageUrl != "";
            try
            {
               IStaticBitmapWrapperWindow(_container.findChildByName("promo_image")).assetUri = "${image.library.url}" + _loc1_.imageUrl;
            }
            catch(e:Error)
            {
               _landingView.context.warning("Missing image url for promo article with title: " + _loc1_.title);
            }
         }
      }
      
      private function setNavigationDisks() : void
      {
         var _loc3_:int = 0;
         var _loc4_:IRegionWindow = null;
         var _loc1_:class_1812 = class_1812(_container.findChildByName("navigation"));
         _loc3_ = 0;
         while(_loc3_ < 10)
         {
            _loc4_ = IRegionWindow(_loc1_.getChildAt(_loc3_));
            if(var_993.length > _loc3_)
            {
               var _loc2_:IStaticBitmapWrapperWindow = IStaticBitmapWrapperWindow(_loc4_.getChildAt(0));
               null.assetUri = "progress_disk_flat_" + (var_763 == _loc3_ ? "on" : "off");
               _loc4_.visible = true;
            }
            else
            {
               _loc4_.visible = false;
            }
            _loc3_++;
         }
      }
      
      private function goToArticle(param1:int) : void
      {
         var _loc2_:* = param1 == var_763;
         if(var_993.length == 0)
         {
            return;
         }
         if(param1 < 0)
         {
            var_763 = var_993.length - 1;
         }
         else if(param1 >= var_993.length)
         {
            var_763 = 0;
         }
         else
         {
            var_763 = param1;
         }
         if(_loc2_)
         {
            refreshContent();
         }
         else
         {
            startFade();
         }
      }
      
      private function startFade() : void
      {
         var_1317 = 0;
         _landingView.registerUpdateReceiver(this,1);
      }
      
      private function stopFade() : void
      {
         _landingView.removeUpdateReceiver(this);
         setBlend(1);
      }
      
      private function followLink() : void
      {
         var _loc1_:class_4098 = var_993[var_763];
         switch(_loc1_.linkType)
         {
            case 0:
               HabboWebTools.openWebPage(_loc1_.linkContent);
               break;
            case 1:
               _landingView.context.createLinkEvent(_loc1_.linkContent);
         }
      }
      
      private function onMouse(param1:class_1758, param2:class_1741) : void
      {
         if(param2.name == "article_navigation")
         {
            if(param1.type == "WME_OVER")
            {
               hoverOverNavigation(param2,true);
            }
            else if(param1.type == "WME_OUT" && param2.id != var_763)
            {
               hoverOverNavigation(param2,false);
            }
         }
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         switch(param2.name)
         {
            case "button":
               followLink();
               break;
            case "article_navigation":
               goToArticle(param2.id);
         }
      }
      
      private function hoverOverNavigation(param1:class_1741, param2:Boolean) : void
      {
         var _loc3_:IStaticBitmapWrapperWindow = IStaticBitmapWrapperWindow(class_1812(param1).getChildAt(0));
         if(!_loc3_)
         {
            return;
         }
         _loc3_.assetUri = "progress_disk_flat_" + (param2 ? "on" : "off");
      }
      
      private function onPromoArticles(param1:class_2356) : void
      {
         var_993 = [];
         for each(var _loc2_ in param1.getParser().articles)
         {
            var_993.push(_loc2_);
         }
         refresh();
      }
      
      private function setBlend(param1:Number) : void
      {
         _container.findChildByName("promo_title").blend = param1;
         _container.findChildByName("promo_text").blend = param1;
         _container.findChildByName("button").blend = param1;
         _container.findChildByName("promo_image").blend = param1;
      }
      
      public function update(param1:uint) : void
      {
         var _loc2_:uint = var_1317 + param1;
         if(var_1317 < 500)
         {
            setBlend(Math.max(0,1 - var_1317 / 500));
            if(_loc2_ >= 500)
            {
               refreshContent();
            }
         }
         else
         {
            setBlend(Math.min(1,(var_1317 - 500) / 500));
         }
         var_1317 = _loc2_;
         if(var_1317 >= 500 * 2)
         {
            stopFade();
         }
      }
   }
}

