package com.sulake.habbo.toolbar.extensions
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IIconWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_2251;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.inventory.events.HabboInventoryHabboClubEvent;
   import com.sulake.habbo.toolbar.HabboToolbar;
   import flash.display.BitmapData;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Timer;
   import com.sulake.habbo.communication.messages.outgoing.catalog.GetHabboClubExtendOfferMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.tracking.EventLogMessageComposer;
   
   public class ClubDiscountPromoExtension
   {
      
      private static const const_569:String = "club_promo";
      
      private static const ICON_STYLE_VIP:int = 14;
      
      private static const LINK_COLOR_NORMAL:uint = 16777215;
      
      private static const LINK_COLOR_HIGHLIGHT:uint = 12247545;
      
      private var _toolbar:HabboToolbar;
      
      private var var_18:class_1812;
      
      private var _disposed:Boolean = false;
      
      private var var_132:class_2251;
      
      private var var_902:Timer;
      
      private var var_2385:int = 0;
      
      private var _animBlockMoveAmount:int;
      
      private var var_1109:Timer;
      
      private var var_1772:BitmapData;
      
      private var var_1063:Timer;
      
      public function ClubDiscountPromoExtension(param1:HabboToolbar)
      {
         super();
         _toolbar = param1;
      }
      
      private function createWindow() : class_1812
      {
         var _loc3_:XmlAsset = _toolbar.assets.getAssetByName("club_discount_promotion_xml") as XmlAsset;
         if(_loc3_)
         {
            var _loc1_:class_1812 = _toolbar.windowManager.buildFromXML(_loc3_.content as XML,1) as class_1812;
         }
         return null;
      }
      
      private function destroyWindow() : void
      {
         if(var_18)
         {
            var_18.dispose();
            var_18 = null;
            var_132 = null;
         }
         animate(false);
         destroyExpirationTimer();
      }
      
      public function dispose() : void
      {
         if(_disposed || !_toolbar)
         {
            return;
         }
         if(_toolbar.extensionView)
         {
            _toolbar.extensionView.detachExtension("club_promo");
         }
         clearAnimation();
         destroyWindow();
         _toolbar = null;
         _disposed = true;
      }
      
      private function onTextRegionClicked(param1:WindowMouseEvent) : void
      {
         if(_toolbar.inventory.clubLevel == 2)
         {
            _toolbar.connection.send(new EventLogMessageComposer("DiscountPromo","discount","client.club.extend.discount.clicked"));
            _toolbar.connection.send(new GetHabboClubExtendOfferMessageComposer());
         }
      }
      
      private function assignState() : void
      {
         switch(_toolbar.inventory.clubLevel)
         {
            case 0:
               setText("${discount.bar.no.club.promo}");
               setClubIcon(14);
               break;
            case 2:
               setText("${discount.bar.vip.expiring}");
               setClubIcon(14);
         }
         animate(true);
      }
      
      public function onClubChanged(param1:HabboInventoryHabboClubEvent) : void
      {
         if(_toolbar.inventory.clubIsExpiring && !var_18 && isExtensionEnabled())
         {
            var_18 = createWindow();
            if(var_1063 != null)
            {
               destroyExpirationTimer();
            }
            if(_toolbar.inventory.clubMinutesUntilExpiration < 1440 && _toolbar.inventory.clubMinutesUntilExpiration > 0)
            {
               var_1063 = new Timer(_toolbar.inventory.clubMinutesUntilExpiration * 60 * 1000,1);
               var_1063.addEventListener("timerComplete",onExtendOfferExpire);
               var_1063.start();
            }
            assignState();
            _toolbar.extensionView.attachExtension("club_promo",var_18,10);
         }
         else
         {
            _toolbar.extensionView.detachExtension("club_promo");
            destroyWindow();
         }
      }
      
      private function destroyExpirationTimer() : void
      {
         if(var_1063)
         {
            var_1063.stop();
            var_1063.removeEventListener("timerComplete",onExtendOfferExpire);
            var_1063 = null;
         }
      }
      
      private function onExtendOfferExpire(param1:TimerEvent) : void
      {
         _toolbar.extensionView.detachExtension("club_promo");
         destroyWindow();
      }
      
      private function isExtensionEnabled() : Boolean
      {
         if(_toolbar.inventory.clubLevel == 2 && _toolbar.getBoolean("club.membership.extend.vip.promotion.enabled"))
         {
            return true;
         }
         return false;
      }
      
      private function setText(param1:String) : void
      {
         var _loc2_:ITextWindow = null;
         var _loc3_:ITextWindow = null;
         if(var_18)
         {
            _loc2_ = var_18.findChildByName("promo_text") as ITextWindow;
            _loc3_ = var_18.findChildByName("promo_text_shadow") as ITextWindow;
            if(_loc2_)
            {
               _loc2_.text = param1;
            }
            if(_loc3_)
            {
               _loc3_.text = param1;
            }
         }
      }
      
      private function animate(param1:Boolean) : void
      {
         if(param1)
         {
            class_21.log("Animate window");
            if(var_1109)
            {
               var_1109.stop();
            }
            var_1109 = new Timer(15000);
            var_1109.addEventListener("timer",onTriggerTimer);
            var_1109.start();
         }
         else
         {
            if(var_1109)
            {
               var_1109.stop();
               var_1109 = null;
            }
            clearAnimation();
         }
      }
      
      private function clearAnimation() : void
      {
         if(var_132)
         {
            var_132.visible = false;
            var_132.bitmap = null;
            var_132 = null;
            var_18.invalidate();
            if(var_902)
            {
               var_902.stop();
               var_902 = null;
            }
         }
      }
      
      private function onTriggerTimer(param1:TimerEvent) : void
      {
         if(var_132)
         {
            if(var_132.context)
            {
               var_132.visible = true;
               resetAnimationVariables();
               startAnimationTimer();
            }
         }
      }
      
      private function resetAnimationVariables() : void
      {
         var_132.x = 3;
         var_132.y = 3;
         var_132.bitmap = var_1772.clone();
         var_132.height = var_18.height - 6;
         var_132.width = var_132.bitmap.width;
         var_132.invalidate();
         _animBlockMoveAmount = var_18.width - 7 - var_132.bitmap.width;
         var_2385 = 0;
      }
      
      private function startAnimationTimer() : void
      {
         var_902 = new Timer(25,26);
         var_902.addEventListener("timer",onAnimationTimer);
         var_902.addEventListener("timerComplete",onAnimationTimerComplete);
         var_902.start();
      }
      
      private function onAnimationTimer(param1:TimerEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:BitmapData = null;
         if(var_132)
         {
            var_132.x = 3 + var_2385 / 20 * _animBlockMoveAmount;
            if(var_132.x > _animBlockMoveAmount)
            {
               _loc2_ = var_18.width - 4 - var_132.x;
               _loc3_ = new BitmapData(_loc2_,var_1772.height);
               _loc3_.copyPixels(var_1772,new Rectangle(0,0,_loc2_,var_1772.height),new Point(0,0));
               var_132.bitmap = _loc3_;
               var_132.width = _loc2_;
            }
            var_132.invalidate();
            var_2385 = var_2385 + 1;
         }
      }
      
      private function onAnimationTimerComplete(param1:TimerEvent) : void
      {
         clearAnimation();
      }
      
      private function setClubIcon(param1:int) : void
      {
         var _loc2_:IIconWindow = null;
         if(var_18)
         {
            _loc2_ = var_18.findChildByName("club_icon") as IIconWindow;
            if(_loc2_)
            {
               _loc2_.style = param1;
               _loc2_.invalidate();
            }
         }
      }
      
      private function onTextRegionMouseOver(param1:WindowMouseEvent) : void
      {
         var _loc2_:ITextWindow = null;
         if(var_18)
         {
            _loc2_ = var_18.findChildByName("promo_text") as ITextWindow;
            _loc2_.textColor = 12247545;
         }
      }
      
      private function onTextRegionMouseOut(param1:WindowMouseEvent) : void
      {
         var _loc2_:ITextWindow = null;
         if(var_18)
         {
            _loc2_ = var_18.findChildByName("promo_text") as ITextWindow;
            _loc2_.textColor = 16777215;
         }
      }
   }
}

