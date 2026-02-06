package com.sulake.habbo.ui.widget.camera
{
   import com.sulake.core.assets.loaders.AssetLoaderEvent;
   import com.sulake.core.assets.loaders.BitmapFileLoader;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_1775;
   import com.sulake.core.window.components.class_1885;
   import com.sulake.core.window.components.class_2250;
   import com.sulake.core.window.components.class_2251;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.core.window.utils.class_2001;
   import com.sulake.habbo.catalog.purse.class_1831;
   import com.sulake.habbo.utils.HabboWebTools;
   import com.sulake.habbo.utils.StringUtil;
   import com.sulake.habbo.utils.TextWindowUtils;
   import com.sulake.habbo.window.utils.AlertDialogCaption;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.events.TimerEvent;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import flash.utils.Timer;
   import com.sulake.habbo.communication.messages.incoming.camera.CameraPublishStatusMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.camera.CompetitionStatusMessageEvent;
   
   internal class PhotoPurchaseConfirmationDialog
   {
      
      private static const STATE_LOADING_IMAGE:String = "loading_image";
      
      private static const STATE_IMAGE_LOADED:String = "image_loaded";
      
      private static const STATE_WAITING_PURCHASE_TO_COMPLETE:String = "waiting_purchase_to_complete";
      
      private static const STATE_WAITING_PUBLISH_TO_COMPLETE:String = "waiting_publish_to_complete";
      
      private static const STATE_WAITING_COMPETITION_SUBMIT_TO_COMPLETE:String = "waiting_competition_submit_to_complete";
      
      private static const STATE_RENDERING_FAILED:String = "rendering_failed";
      
      private var var_61:String;
      
      private var _window:class_1812;
      
      private var var_16:CameraWidget;
      
      private var var_48:BitmapData;
      
      private var _caption:String;
      
      private var var_3575:Boolean;
      
      private var var_2932:Boolean = false;
      
      private var var_3169:Boolean = false;
      
      private var var_2842:String = null;
      
      private var var_505:Timer;
      
      private var var_3403:int = 0;
      
      public function PhotoPurchaseConfirmationDialog(param1:CameraWidget, param2:String)
      {
         super();
         var_16 = param1;
         _caption = param2;
         _window = var_16.getXmlWindow("photo_purchase_confirmation") as class_1812;
         var _loc3_:IItemListWindow = (_window as class_2250).content.getChildByName("contentlist") as IItemListWindow;
         if(param1.component.getBoolean("camera.competition.enabled"))
         {
            TextWindowUtils.setHTMLLinkStyle(_window.findChildByName("competition_info") as ITextWindow,16777215,16777215,16777215);
         }
         else
         {
            _loc3_.removeListItem(_loc3_.getListItemByName("competition_wrapper"));
         }
         if(param1.component.getBoolean("disclaimer.credit_spending.enabled"))
         {
            setDisclaimerAccepted(false);
         }
         else
         {
            _loc3_.removeListItem(_loc3_.getListItemByName("disclaimer"));
            setDisclaimerAccepted(true);
         }
         if(!param1.component.getBoolean("camera.photo.publishing.enabled"))
         {
            _loc3_.removeListItem(_loc3_.getListItemByName("publish_wrapper"));
         }
         (_window as class_2250).resizeToFitContent();
         setState("loading_image");
         _window.center();
         _window.procedure = windowEventHandler;
      }
      
      private function checkPurse(param1:int, param2:int) : Boolean
      {
         var _loc3_:class_1831 = var_16.catalog.getPurse();
         if(_loc3_.credits < param1)
         {
            var_16.catalog.showNotEnoughCreditsAlert();
            return false;
         }
         if(_loc3_.getActivityPointsForType(0) < param2)
         {
            var_16.catalog.showNotEnoughActivityPointsAlert(0);
            return false;
         }
         return true;
      }
      
      private function disableButtons(param1:Boolean) : void
      {
         var _loc4_:class_1775 = class_1775(_window.findChildByName("buy_button"));
         var _loc2_:class_1775 = class_1775(_window.findChildByName("publish_button"));
         var _loc3_:class_1775 = class_1775(_window.findChildByName("competition_button"));
         if(_loc4_)
         {
            _loc4_.disable();
         }
         if(_loc2_)
         {
            _loc2_.disable();
         }
         if(_loc3_)
         {
            _loc3_.disable();
         }
         if(param1)
         {
            class_1775(_window.findChildByName("cancel_button")).caption = var_16.localizations.getLocalization("generic.close");
            _window.findChildByName("status_info").caption = var_16.localizations.getLocalization("camera.purchase.pleasewait");
         }
      }
      
      private function setState(param1:String) : void
      {
         if(_window == null)
         {
            return;
         }
         var_61 = param1;
         var _loc4_:class_1775 = class_1775(_window.findChildByName("buy_button"));
         var _loc2_:class_1775 = class_1775(_window.findChildByName("publish_button"));
         var _loc3_:class_1775 = class_1775(_window.findChildByName("competition_button"));
         switch(param1)
         {
            case "loading_image":
               disableButtons(false);
               break;
            case "image_loaded":
               if(var_3575)
               {
                  _loc4_.enable();
               }
               if(!var_3169)
               {
                  if(_loc2_)
                  {
                     _loc2_.enable();
                  }
               }
               if(!var_2932 && _loc3_)
               {
                  _loc3_.enable();
               }
               break;
            case "waiting_purchase_to_complete":
               disableButtons(true);
               if(var_16.component.getBoolean("disclaimer.credit_spending.enabled"))
               {
                  setDisclaimerAccepted(false);
               }
               break;
            case "waiting_publish_to_complete":
               var_3169 = true;
               disableButtons(true);
               break;
            case "waiting_competition_submit_to_complete":
               var_2932 = true;
               disableButtons(true);
               break;
            case "rendering_failed":
               disableButtons(false);
               _window.findChildByName("status_info").caption = "";
         }
      }
      
      public function animateIconToToolbar() : void
      {
         if(!_window)
         {
            return;
         }
         var _loc2_:class_2251 = _window.findChildByName("product_image") as class_2251;
         var _loc4_:Point = new Point();
         _loc2_.getGlobalPosition(_loc4_);
         var _loc6_:BitmapData = new BitmapData(120,120);
         var _loc3_:Number = _loc6_.width / var_48.width;
         var _loc5_:Matrix = new Matrix(_loc3_,0,0,_loc3_,0,0);
         _loc6_.draw(var_48,_loc5_);
         var_16.component.toolbar.createTransitionToIcon("HTIE_ICON_INVENTORY",_loc6_,_loc4_.x,_loc4_.y);
         _window.findChildByName("status_info").caption = var_16.localizations.getLocalization("camera.purchase.successful");
         _window.findChildByName("buy_button").caption = var_16.localizations.getLocalization("camera.buy.another.button.text");
         _window.findChildByName("inventory_link_area").visible = true;
         var_3403 = var_3403 + 1;
         _window.findChildByName("purchase_count").caption = "";
         _window.findChildByName("purchase_count").caption = var_3403.toString();
         setState("image_loaded");
      }
      
      public function setImageUrl(param1:String) : void
      {
         var _loc2_:BitmapFileLoader = null;
         if(var_16 == null)
         {
            return;
         }
         if(param1 && param1.length > 0)
         {
            param1 = var_16.component.context.configuration.getProperty("stories.image_url_base") + param1;
            _loc2_ = new BitmapFileLoader("image/png",new URLRequest(param1));
            _loc2_.addEventListener("AssetLoaderEventComplete",onImageLoaded);
         }
         else
         {
            setRenderingFailed();
            var_16.windowManager.alert("${generic.alert.title}","${camera.render.count.info}",0,null);
         }
      }
      
      private function onImageLoaded(param1:AssetLoaderEvent) : void
      {
         if(!_window)
         {
            return;
         }
         var _loc2_:Bitmap = BitmapFileLoader(param1.target).content as Bitmap;
         if(_loc2_)
         {
            setImage(_loc2_.bitmapData);
         }
         _window.findChildByName("status_info").caption = var_16.localizations.getLocalization("camera.confirm_phase.info");
         setState("image_loaded");
      }
      
      private function setImage(param1:BitmapData) : void
      {
         if(_window == null || param1 == null)
         {
            return;
         }
         var _loc3_:class_2251 = _window.findChildByName("product_image") as class_2251;
         if(_loc3_ == null)
         {
            return;
         }
         if(_loc3_.bitmap != null)
         {
            _loc3_.bitmap.dispose();
            _loc3_.bitmap = null;
         }
         if(_loc3_.bitmap == null)
         {
            _loc3_.bitmap = new BitmapData(_loc3_.width,_loc3_.height,true,0);
         }
         var _loc2_:Number = _loc3_.width / param1.width;
         _loc3_.bitmap.draw(param1,new Matrix(_loc2_,0,0,_loc2_,0,0),null,null,null,true);
         var_48 = param1;
      }
      
      public function setRenderingFailed() : void
      {
         if(_window == null)
         {
            return;
         }
         var _loc1_:class_2251 = _window.findChildByName("product_image") as class_2251;
         if(_loc1_ != null)
         {
            var_48 = new BitmapData(_loc1_.width,_loc1_.height,false,0);
            if(_loc1_.bitmap == null)
            {
               _loc1_.bitmap = var_48;
            }
            else
            {
               _loc1_.bitmap.dispose();
               _loc1_.bitmap.draw(var_48);
            }
         }
         setState("rendering_failed");
      }
      
      public function publishingStatus(param1:CameraPublishStatusMessageEvent) : void
      {
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         var _loc2_:String = null;
         if(_window == null)
         {
            return;
         }
         if(param1.getParser().isOk())
         {
            var_2842 = param1.getParser().getExtraDataId();
            _window.findChildByName("status_info").caption = var_16.localizations.getLocalization("camera.publish.successful");
            _window.findChildByName("publish_explanation").caption = var_16.localizations.getLocalization("camera.publish.successful");
            _window.findChildByName("publish_detailed_explanation").caption = var_16.localizations.getLocalization("camera.publish.success.short.info");
            _window.findChildByName("publish_button").visible = false;
            _window.findChildByName("publish_price_area").visible = false;
            _window.findChildByName("publish_link_area").visible = true;
            if(var_505 != null)
            {
               var_505.reset();
            }
         }
         else
         {
            _loc4_ = param1.getParser().getSecondsToWait();
            _loc3_ = _loc4_ / 60 + 1;
            _loc2_ = var_16.localizations.registerParameter("camera.publish.wait","minutes",_loc3_.toString());
            var_16.windowManager.alert("${generic.alert.title}",_loc2_,0,null);
            _window.findChildByName("status_info").caption = "";
            if(var_505 == null)
            {
               var_505 = new Timer(_loc4_ * 1000,1);
               var_505.addEventListener("timerComplete",onPublishTimerComplete);
            }
            else
            {
               var_505.reset();
               var_505.delay = _loc4_ * 1000;
            }
            var_505.start();
         }
         setState("image_loaded");
      }
      
      private function onPublishTimerComplete(param1:TimerEvent) : void
      {
         var_3169 = false;
         var_505 = null;
         if(var_61 == "image_loaded")
         {
            var _loc2_:class_1775 = class_1775(_window.findChildByName("publish_button"));
            null.enable();
         }
      }
      
      public function competitionStatus(param1:CompetitionStatusMessageEvent) : void
      {
         if(_window == null || _window.findChildByName("competition_wrapper") == null)
         {
            return;
         }
         if(param1.getParser().isOk())
         {
            _window.findChildByName("status_info").caption = var_16.localizations.getLocalization("camera.competition.submitted.status");
            _window.findChildByName("competition_name").caption = var_16.localizations.getLocalization("camera.competition.submitted.info");
         }
         else if(param1.getParser().getErrorReason() == "too-many-submits")
         {
            _window.findChildByName("status_info").caption = var_16.localizations.getLocalization("generic.failed");
            _window.findChildByName("competition_name").caption = var_16.localizations.getLocalization("camera.competition.limit.info");
         }
         else if(param1.getParser().getErrorReason() == "email-not-verified")
         {
            var_2932 = false;
            _window.findChildByName("status_info").caption = var_16.localizations.getLocalization("generic.failed");
            var _loc2_:class_2001 = var_16.windowManager.confirm("${generic.alert.title}","${camera.competition.email.not.verified}",0x10 | 0x20,onEmailVerificationGo);
            null.setButtonCaption(16,new AlertDialogCaption(var_16.localizations.getLocalization("email.settings"),"",true));
            null.setButtonCaption(32,new AlertDialogCaption(var_16.localizations.getLocalization("groupforum.settings.cancel"),"",true));
         }
         setState("image_loaded");
         var _loc3_:class_1741 = _window.findChildByName("competition_button");
         if(_loc3_ != null && _loc3_.y < 10)
         {
            _loc3_.y = 10;
         }
      }
      
      private function onEmailVerificationGo(param1:class_2001, param2:class_1758) : void
      {
         var _loc4_:String = null;
         var _loc3_:String = null;
         if(param2.type == "WE_OK")
         {
            _loc4_ = var_16.component.context.configuration.getProperty("email.verification.url");
            if(!StringUtil.isEmpty(_loc4_))
            {
               _loc3_ = var_16.component.getInteger("spaweb",0) == 1 ? "" : "_blank";
               navigateToURL(new URLRequest(_loc4_),_loc3_);
            }
         }
         param1.dispose();
      }
      
      public function setPrices(param1:int, param2:int, param3:int) : void
      {
         var _loc4_:ITextWindow = _window.findChildByName("purchase_credit_cost_text") as ITextWindow;
         _loc4_.text = param1.toString();
         var _loc5_:ITextWindow = _window.findChildByName("purchase_ducket_cost_text") as ITextWindow;
         if(param2 > 0)
         {
            _loc5_.text = param2.toString();
         }
         else
         {
            _loc5_.visible = false;
            _window.findChildByName("ducket_icon").visible = false;
         }
         var _loc6_:ITextWindow = _window.findChildByName("publish_ducket_cost_text") as ITextWindow;
         if(_loc6_)
         {
            _loc6_.text = param3.toString();
         }
      }
      
      private function windowEventHandler(param1:class_1758, param2:class_1741) : void
      {
         if(!param1 || !param2)
         {
            return;
         }
         if(param1.type != "WME_CLICK" && param1.type != "WME_DOUBLE_CLICK")
         {
            return;
         }
         switch(param2.name)
         {
            case "spending_disclaimer":
               setDisclaimerAccepted(class_1885(param2).isSelected);
               break;
            case "competition_button":
               if(var_61 == "image_loaded")
               {
                  setState("waiting_competition_submit_to_complete");
                  var_16.handler.confirmPhotoCompetitionSubmit();
               }
               break;
            case "buy_button":
               if(var_61 == "image_loaded" && var_3575 && checkPurse(var_16.handler.creditPrice,var_16.handler.ducketPrice))
               {
                  setState("waiting_purchase_to_complete");
                  var_16.handler.confirmPhotoPurchase();
               }
               break;
            case "publish_button":
               if(var_61 == "image_loaded" && checkPurse(0,var_16.handler.publishDucketPrice))
               {
                  setState("waiting_publish_to_complete");
                  var_16.handler.confirmPhotoPublish();
               }
               break;
            case "inventory_link":
               var_16.component.context.createLinkEvent("inventory/open/furni");
               break;
            case "publish_link":
               var _loc3_:String = var_16.container.sessionDataManager.userName;
               var _loc4_:String = "/profile/" + null + "/photo/" + var_2842;
               HabboWebTools.openPage(null);
               break;
            case "header_button_close":
            case "cancel_button":
               var_16.startTakingPhoto("photoPurchaseCancel");
               hide();
         }
      }
      
      private function setDisclaimerAccepted(param1:Boolean) : void
      {
         if(_window == null)
         {
            return;
         }
         var _loc2_:class_1741 = _window.findChildByName("buy_button");
         if(_loc2_ == null)
         {
            return;
         }
         var_3575 = param1;
         if(param1 && var_61 == "image_loaded")
         {
            _loc2_.enable();
         }
         else
         {
            _loc2_.disable();
         }
      }
      
      public function hide() : void
      {
         if(_window)
         {
            _window.dispose();
            _window = null;
         }
         var_48 = null;
         var_16 = null;
         if(var_505 != null)
         {
            var_505.stop();
            var_505 = null;
         }
      }
   }
}

