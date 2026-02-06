package com.sulake.habbo.ui.widget.camera
{
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.utils.class_55;
   import com.sulake.core.utils.images.class_1791;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.IScrollableGridWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_1970;
   import com.sulake.core.window.components.class_1993;
   import com.sulake.core.window.components.class_2250;
   import com.sulake.core.window.components.class_2251;
   import com.sulake.core.window.events.WindowKeyboardEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.localization.class_27;
   import com.sulake.habbo.quest.class_498;
   import com.sulake.habbo.tracking.HabboTracking;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.ColorTransform;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.globalization.DateTimeFormatter;
   import flash.net.FileReference;
   import flash.utils.ByteArray;
   import flash.utils.setTimeout;
   import com.sulake.habbo.communication.messages.incoming.camera.CameraPublishStatusMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.camera.CompetitionStatusMessageEvent;
   
   public class CameraPhotoLab implements class_13
   {
      
      private static var TEXT_WIDTH_MARGIN:int = 6;
      
      private static var var_274:PhotoPurchaseConfirmationDialog;
      
      private var var_16:CameraWidget;
      
      private var _window:class_1812;
      
      private var _disposed:Boolean = false;
      
      private var var_239:class_2251;
      
      private var var_2246:BitmapData;
      
      private var var_650:CameraFxStrengthSlider;
      
      private var _sliderEffectInfo:ITextWindow;
      
      private var var_321:CameraEffect;
      
      private var var_465:class_55 = new class_55();
      
      private var _itemGrid:IScrollableGridWindow;
      
      private var var_2257:Sprite;
      
      private var var_2176:class_55 = new class_55();
      
      private var _captionInputKeyEvents:int = 0;
      
      private var var_4111:String = "";
      
      private var var_3054:Boolean = false;
      
      private var var_869:FileReference = new FileReference();
      
      public function CameraPhotoLab(param1:CameraWidget)
      {
         super();
         var_16 = param1;
      }
      
      public static function preloadEffects(param1:String, param2:String, param3:class_27) : void
      {
         var _loc5_:Array = [];
         var _loc4_:class_55 = CameraEffect.getEffects(param2,param3);
         for each(var _loc6_ in _loc4_)
         {
            if(_loc6_.type == "composite" || _loc6_.type == "frame")
            {
               _loc5_.push(_loc6_.name);
            }
         }
         CameraFxPreloader.init(param1,_loc5_);
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         if(var_274)
         {
            var_274.hide();
         }
         CameraEffect.resetAllEffects();
         var_2246 = null;
         var_16 = null;
         var_239 = null;
         if(var_650 != null)
         {
            var_650.dispose();
            var_650 = null;
         }
         _sliderEffectInfo = null;
         var_321 = null;
         var_465 = null;
         var_2176 = null;
         _disposed = true;
         if(_window)
         {
            _window.dispose();
         }
         _window = null;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      private function setImageAndFilterButtons(param1:BitmapData) : void
      {
         var_2246 = param1.clone();
         var_239.bitmap = param1;
         buildFilterButtons();
      }
      
      internal function setSelectedFxValue(param1:Number) : void
      {
         if(var_321)
         {
            var_321.value = param1;
            updateSliderEffectInfo();
            renderAllEffects();
         }
      }
      
      private function updateSliderEffectInfo() : void
      {
         _sliderEffectInfo.text = var_321.description + " " + int(var_321.getEffectStrength() * 100) + "%";
         _sliderEffectInfo.width = _sliderEffectInfo.textWidth + TEXT_WIDTH_MARGIN;
      }
      
      internal function setCaptionText(param1:String) : void
      {
         ITextWindow(_window.findChildByName("captionInput")).text = param1;
      }
      
      private function buildTypeButtons() : void
      {
         var _loc5_:int = 0;
         _loc5_ = 6;
         var _loc3_:int = 0;
         _loc3_ = 2;
         if(var_2176.length > 0)
         {
            return;
         }
         var _loc1_:int = (_window as class_2250).margins.left + _itemGrid.x;
         var _loc2_:class_1812 = createTypeButton("colormatrix","camera_icon_colorfilter");
         _loc2_.x = _loc1_ + (_itemGrid.width - (2 * (_loc2_.width + 6) - 6)) / 2;
         _loc2_.y = 50;
         _window.addChild(_loc2_);
         var _loc4_:class_1812 = createTypeButton("composite","camera_icon_compositefilter");
         _loc4_.x = _loc2_.right + 6;
         _loc4_.y = _loc2_.y;
         _window.addChild(_loc4_);
      }
      
      private function buildFilterButtons() : void
      {
         var _loc1_:class_1812 = null;
         var _loc5_:String = null;
         if(CameraFxPreloader.preloadFinished() == false)
         {
            setTimeout(buildFilterButtons,200);
         }
         var _loc6_:int = 0;
         var _loc7_:class_498 = var_16.handler.roomDesktop.questEngine;
         if(_loc7_ != null)
         {
            _loc6_ = _loc7_.getAchievementLevel("explore","ACH_CameraPhotoCount");
            if(_loc6_ == 0)
            {
               _loc6_ = _loc7_.getAchievementLevel("archive","ACH_CameraPhotoCount");
            }
         }
         var _loc2_:class_55 = CameraEffect.getEffects(var_16.component.getProperty("camera.available.effects"),var_16.localizations);
         for each(var _loc4_ in _loc2_)
         {
            _loc1_ = createFxButton(_loc4_,var_2246.clone(),_loc6_);
            if(_loc1_)
            {
               _loc5_ = _loc4_.description;
               if(_loc6_ < _loc4_.var_3606)
               {
                  _loc5_ = var_16.localizations.getLocalization("camera.effect.required.level") + " " + _loc4_.var_3606;
               }
               IRegionWindow(_loc1_).toolTipCaption = _loc5_;
            }
         }
         var _loc3_:class_1812 = _window.findChildByName("slider_container") as class_1812;
         var_650 = new CameraFxStrengthSlider(this,_loc3_,var_16.windowManager.assets);
         var_650.disable();
         CameraEffect.setMaxValue(var_650.getScale());
         setFilterType("colormatrix");
      }
      
      private function createTypeButton(param1:String, param2:String) : class_1812
      {
         var _loc3_:IRegionWindow = var_16.getXmlWindow("camera_typebutton") as IRegionWindow;
         var _loc4_:class_2251 = _loc3_.findChildByName("icon") as class_2251;
         _loc4_.bitmap = (var_16.windowManager.assets.getAssetByName(param2).content as BitmapData).clone();
         _loc3_.name = "typebutton," + param1;
         _loc3_.toolTipCaption = param1;
         var_2176.add(param1,_loc3_);
         return _loc3_;
      }
      
      private function createFxButton(param1:CameraEffect, param2:BitmapData, param3:int) : class_1812
      {
         var _loc7_:class_2251 = null;
         var _loc5_:Number = NaN;
         var _loc6_:class_1741 = null;
         var _loc4_:class_1812 = var_16.getXmlWindow("camera_filterbutton") as class_1812;
         if(param3 >= param1.var_3606)
         {
            _loc7_ = _loc4_.findChildByName("content") as class_2251;
            _loc7_.bitmap = new BitmapData(_loc7_.width,_loc7_.height,true,0);
            _loc5_ = _loc7_.width / param2.width;
            var _loc8_:Matrix = new Matrix();
            _loc8_.scale(_loc5_,_loc5_);
            var _loc9_:Bitmap = new Bitmap(param2,"auto",true);
            switch(param1.type)
            {
               case "colormatrix":
                  param2.applyFilter(param2,param2.rect,new Point(0,0),param1.getColorMatrixFilter(true));
                  break;
               case "composite":
                  if(CameraFxPreloader.getImage(param1.name) == null)
                  {
                     return null;
                  }
                  param2.draw(CameraFxPreloader.getImage(param1.name),null,null,param1.var_4054,null,true);
                  break;
               case "frame":
                  if(CameraFxPreloader.getImage(param1.name) == null)
                  {
                     return null;
                  }
                  param2.draw(CameraFxPreloader.getImage(param1.name),null,null,null,null,true);
            }
            _loc7_.bitmap.draw(null,null,null,null,null,true);
            _loc4_.procedure = effectButtonClick;
         }
         else
         {
            _loc6_ = _loc4_.findChildByName("lock_indicator") as class_1741;
            _loc6_.visible = true;
         }
         _loc4_.name = param1.name;
         param1.button = _loc4_;
         var_465[_loc4_.name] = param1;
         return _loc4_;
      }
      
      public function openPhotoLab(param1:BitmapData) : void
      {
         _window = var_16.getXmlWindow("camera_editor") as class_1812;
         _window.center();
         if(var_16.component.getProperty("camera.effects.enabled") != "true")
         {
            openPurchaseConfirmationDialog(null);
            return;
         }
         _itemGrid = _window.findChildByName("item_grid") as IScrollableGridWindow;
         _itemGrid.spacing = 7;
         var_239 = _window.findChildByName("image") as class_2251;
         _window.procedure = windowEventHandler;
         var _loc10_:ITextWindow = ITextWindow(_window.findChildByName("captionInput"));
         _loc10_.procedure = captionProcedure;
         var _loc6_:class_1970 = _window.findChildByName("purchase_display_object") as class_1970;
         var_2257 = new Sprite();
         var_2257.graphics.beginFill(16711680,0);
         var_2257.graphics.drawRect(0,0,_loc6_.width,_loc6_.height);
         _loc6_.setDisplayObject(var_2257);
         var_2257.addEventListener("click",openPurchaseConfirmationDialog);
         var _loc7_:IRegionWindow = _window.findChildByName("zoom_button") as IRegionWindow;
         var _loc11_:class_1993 = _loc7_.getChildByName("centerizer") as class_1993;
         var _loc5_:ITextWindow = _loc11_.getChildByName("zoom_text") as ITextWindow;
         _loc5_.width = _loc5_.textWidth + TEXT_WIDTH_MARGIN;
         var _loc8_:IRegionWindow = _window.findChildByName("save_button") as IRegionWindow;
         var _loc4_:class_1993 = _loc8_.getChildByName("centerizer") as class_1993;
         var _loc9_:ITextWindow = _loc4_.getChildByName("save_text") as ITextWindow;
         _loc9_.width = _loc9_.textWidth + TEXT_WIDTH_MARGIN;
         var _loc2_:class_1970 = _window.findChildByName("save_click_catcher") as class_1970;
         var _loc3_:Sprite = new Sprite();
         _loc3_.graphics.beginFill(16711680,0);
         _loc3_.graphics.drawRect(0,0,_loc2_.width,_loc2_.height);
         _loc2_.setDisplayObject(_loc3_);
         _loc3_.addEventListener("click",offerSaveAsFile);
         buildTypeButtons();
         setImageAndFilterButtons(param1);
         _sliderEffectInfo = _window.findChildByName("slider_effect_info") as ITextWindow;
         CameraEffect.resetAllEffects();
      }
      
      private function effectButtonClick(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         if(param2.name == "remove_effect_button")
         {
            if(var_465.hasKey(param2.parent.name))
            {
               var _loc3_:CameraEffect = var_465[param2.parent.name];
               null.setChosen(false);
               if(var_321 == null)
               {
                  var_650.disable();
                  var_321 = null;
               }
               renderAllEffects();
               return;
            }
         }
         if(var_465.hasKey(param2.name))
         {
            setActiveEffect(var_465[param2.name]);
         }
      }
      
      private function captionProcedure(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type == "WKE_KEY_DOWN")
         {
            if(WindowKeyboardEvent(param1).ctrlKey || WindowKeyboardEvent(param1).charCode == 0)
            {
               _captionInputKeyEvents = 0;
            }
            else
            {
               _captionInputKeyEvents = _captionInputKeyEvents + 1;
            }
         }
         else if(param1.type == "WKE_KEY_UP")
         {
            _captionInputKeyEvents = 0;
         }
         else if(param1.type == "WE_CHANGE")
         {
            if(_captionInputKeyEvents == 1)
            {
               var_4111 = ITextWindow(_window.findChildByName("captionInput")).text;
            }
            else
            {
               setCaptionText(var_4111);
            }
            _captionInputKeyEvents = 0;
         }
      }
      
      private function openPurchaseConfirmationDialog(param1:MouseEvent) : void
      {
         if(var_274)
         {
            var_274.hide();
         }
         if(var_16.container.sessionDataManager.isAccountSafetyLocked())
         {
            var_16.windowManager.alert("${generic.alert.title}","${notifications.text.safety_locked}",0,null);
            if(var_16.component.getProperty("camera.effects.enabled") != "true")
            {
               dispose();
            }
            return;
         }
         var_274 = new PhotoPurchaseConfirmationDialog(var_16,ITextWindow(_window.findChildByName("captionInput")).text);
         var _loc2_:Boolean = var_16.sendPhotoData();
         var_274.setPrices(var_16.handler.creditPrice,var_16.handler.ducketPrice,var_16.handler.publishDucketPrice);
         HabboTracking.getInstance().trackEventLog("Stories","camera","stories.photo.purchase_dialog_opened");
         if(!_loc2_)
         {
            var_274.setRenderingFailed();
            var_16.windowManager.alert("${generic.alert.title}","${camera.alert.too_much_stuff}",0,null);
         }
         hide();
      }
      
      public function hide() : void
      {
         _window.visible = false;
      }
      
      public function show() : void
      {
         _window.visible = true;
      }
      
      public function closePurchaseConfirmation() : void
      {
         if(var_274)
         {
            var_274.hide();
            var_274 = null;
         }
      }
      
      internal function animateSuccessfulPurchase() : void
      {
         if(var_274)
         {
            var_274.animateIconToToolbar();
         }
      }
      
      public function publishingStatus(param1:CameraPublishStatusMessageEvent) : void
      {
         if(var_274)
         {
            var_274.publishingStatus(param1);
         }
      }
      
      public function competitionStatus(param1:CompetitionStatusMessageEvent) : void
      {
         if(var_274)
         {
            var_274.competitionStatus(param1);
         }
      }
      
      private function offerSaveAsFile(param1:MouseEvent) : void
      {
         var _loc2_:DateTimeFormatter = null;
         var _loc4_:String = null;
         var _loc3_:BitmapData = var_239.bitmap.clone();
         var _loc5_:ByteArray = class_1791.encode(_loc3_);
         try
         {
            _loc2_ = new DateTimeFormatter("i-default");
            _loc2_.setDateTimePattern("yyyy-MM-dd_HH-mm-ss");
            _loc4_ = "Habbo_" + _loc2_.format(new Date()) + ".png";
            var_869.save(_loc5_,_loc4_);
         }
         catch(error:Error)
         {
         }
      }
      
      public function logChosenEffects() : void
      {
         for each(var _loc1_ in var_465)
         {
            if(_loc1_.isOn)
            {
               HabboTracking.getInstance().trackEventLog("Stories","camera","stories.photo.effect.chosen",_loc1_.name);
            }
         }
      }
      
      private function windowEventHandler(param1:class_1758, param2:class_1741) : void
      {
         if(_disposed || !_window || param1.type != "WME_CLICK")
         {
            return;
         }
         switch(param2.name)
         {
            case "cancel_button":
               var_16.startTakingPhoto("effectEditorCancel");
               dispose();
               break;
            case "header_button_close":
               dispose();
               break;
            case "help_button":
               var_16.component.context.createLinkEvent("habbopages/camera");
               break;
            default:
               var_650.disable();
               if(var_321 != null)
               {
                  var_321.turnOffHighlight();
               }
               break;
            case "zoom_button":
               var_3054 = !var_3054;
               renderAllEffects();
               break;
            case "save_button":
            case "slider_container":
         }
         if(param2.name.indexOf("typebutton") != -1)
         {
            setFilterType(param2.name.split(",")[1]);
         }
      }
      
      private function setActiveEffect(param1:CameraEffect) : void
      {
         if(var_321 != null)
         {
            var_321.turnOffHighlight();
         }
         var_321 = param1;
         var_321.setChosen(true);
         if(param1.usesEffectStrength())
         {
            var_650.enable();
            var_650.setValue(param1.value);
            updateSliderEffectInfo();
         }
         else
         {
            var_650.disable();
         }
         if(param1.allowsOnlyOneInstance())
         {
            turnOffOtherEffectsOfSameType(param1);
         }
         renderAllEffects();
      }
      
      private function turnOffOtherEffectsOfSameType(param1:CameraEffect) : void
      {
         for each(var _loc2_ in var_465)
         {
            if(_loc2_.type == param1.type && _loc2_ != param1)
            {
               _loc2_.setChosen(false);
            }
         }
      }
      
      private function setFilterType(param1:String) : void
      {
         if(var_321 != null)
         {
            var_321.turnOffHighlight();
         }
         _itemGrid.removeGridItems();
         for each(var _loc2_ in var_465)
         {
            if(_loc2_.type == param1)
            {
               _itemGrid.addGridItem(_loc2_.button);
            }
         }
         highlightSelectedButtonType(param1);
      }
      
      private function highlightSelectedButtonType(param1:String) : void
      {
         var _loc3_:class_1741 = null;
         for each(var _loc2_ in var_2176)
         {
            _loc3_ = _loc2_.findChildByName("active_border");
            _loc3_.visible = _loc2_.name == "typebutton," + param1;
         }
      }
      
      private function renderAllEffects() : void
      {
         var _loc2_:ColorTransform = null;
         var _loc5_:Matrix = null;
         var _loc3_:BitmapData = null;
         var _loc1_:BitmapData = var_2246.clone();
         if(var_3054)
         {
            _loc5_ = new Matrix();
            _loc5_.a = 2;
            _loc5_.d = 2;
            _loc5_.tx = -_loc1_.width / 2;
            _loc5_.ty = -_loc1_.height / 2;
            _loc3_ = new BitmapData(_loc1_.width,_loc1_.height);
            _loc3_.draw(_loc1_,_loc5_);
            _loc1_ = _loc3_;
         }
         for each(var _loc4_ in var_465)
         {
            if(_loc4_.isOn)
            {
               if(_loc4_.type == "colormatrix")
               {
                  _loc1_.applyFilter(_loc1_,_loc1_.rect,new Point(0,0),_loc4_.getColorMatrixFilter());
               }
               if(_loc4_.type == "composite")
               {
                  _loc2_ = new ColorTransform(1,1,1,_loc4_.getEffectStrength());
                  _loc1_.draw(CameraFxPreloader.getImage(_loc4_.name),null,_loc2_,_loc4_.var_4054);
               }
            }
         }
         for each(var _loc6_ in var_465)
         {
            if(_loc6_.isOn && _loc6_.type == "frame")
            {
               _loc1_.draw(CameraFxPreloader.getImage(_loc6_.name));
            }
         }
         var_239.bitmap = _loc1_;
         var_239.invalidate();
      }
      
      protected function onClose(param1:WindowMouseEvent) : void
      {
         dispose();
      }
      
      public function setRenderedPhotoUrl(param1:String) : void
      {
         if(var_274)
         {
            var_274.setImageUrl(param1);
         }
      }
      
      public function getEffectDataJson() : String
      {
         var _loc2_:Object = null;
         var _loc1_:Vector.<Object> = new Vector.<Object>();
         for each(var _loc3_ in var_465)
         {
            if(_loc3_.isOn && _loc3_.type != "frame")
            {
               _loc2_ = {};
               _loc2_.name = _loc3_.name;
               _loc2_.alpha = int(_loc3_.getEffectStrength() * 255);
               _loc1_.push(_loc2_);
            }
         }
         for each(var _loc4_ in var_465)
         {
            if(_loc4_.isOn && _loc4_.type == "frame")
            {
               _loc2_ = {};
               _loc2_.name = _loc4_.name;
               _loc1_.push(_loc2_);
            }
         }
         return JSON.stringify(_loc1_);
      }
      
      public function getZoom() : int
      {
         return var_3054 ? 2 : 1;
      }
   }
}

