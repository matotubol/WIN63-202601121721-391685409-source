package com.sulake.habbo.catalog.special_items_display
{
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.runtime.class_31;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.IScrollableListWindow;
   import com.sulake.core.window.components.IScrollbarWindow;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_2010;
   import com.sulake.core.window.components.class_2052;
   import com.sulake.core.window.components.class_2250;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.catalog.special_items_display.model.class_2451;
   import com.sulake.habbo.catalog.special_items_display.view.SpecialItemElementView;
   import com.sulake.habbo.catalog.special_items_display.view.SpecialItemPageButtonView;
   import com.sulake.habbo.localization.class_27;
   import com.sulake.habbo.window.class_38;
   import com.sulake.habbo.window.widgets.class_2343;
   
   public class SpecialItemsView implements class_31, class_13
   {
      
      public static const DESKTOP_WINDOW_LAYER:uint = 1;
      
      private static const BLEND_BUFFERING:Number = 0.1;
      
      private var _disposed:Boolean = false;
      
      private var var_55:SpecialItemsController;
      
      private var _windowManager:class_38;
      
      private var _window:class_2250;
      
      private var var_2434:IRegionWindow;
      
      private var var_2307:class_2010;
      
      private var var_885:Vector.<SpecialItemPageButtonView> = new Vector.<SpecialItemPageButtonView>();
      
      private var var_312:SpecialItemPageButtonView;
      
      private var var_1089:Vector.<SpecialItemElementView> = new Vector.<SpecialItemElementView>();
      
      private var _latestDisplayKey:String = "";
      
      private var var_302:int;
      
      private var var_652:Boolean;
      
      private var var_187:Number;
      
      private var var_767:Number;
      
      private var var_384:Boolean;
      
      private var var_115:int = 0;
      
      private var var_593:int;
      
      private var var_2708:Number = 1;
      
      private var var_5077:Number = 1;
      
      public function SpecialItemsView(param1:SpecialItemsController, param2:class_38)
      {
         super();
         _windowManager = param2;
         var_55 = param1;
         _window = _windowManager.buildFromXML(XML(var_55.assets.getAssetByName("special_items_display_xml").content),1) as class_2250;
         var_2434 = pageList.getListItemAt(0) as IRegionWindow;
         pageList.removeListItems();
         var_2307 = itemRotation.removeChildAt(0) as class_2010;
         closeButton.addEventListener("WME_CLICK",onClose);
         previousButton.addEventListener("WME_CLICK",onPreviousClick);
         nextButton.addEventListener("WME_CLICK",onNextClick);
         var_55.registerUpdateReceiver(this,1);
         hide();
      }
      
      private function get localizations() : class_27
      {
         return var_55.localizationManager;
      }
      
      public function displayNewData() : void
      {
         if(var_55.key != _latestDisplayKey)
         {
            _window.caption = localizations.getLocalizationWithParams("special_items.title","","set_name",localizations.getLocalization("special_items." + var_55.key + ".title"));
            setTitleText.text = localizations.getLocalization("special_items." + var_55.key + ".header.title");
            setDescText.text = localizations.getLocalization("special_items." + var_55.key + ".header.desc");
            initializePages();
            initializeElements();
            resetToFirstElement();
         }
         _latestDisplayKey = var_55.key;
         _window.activate();
      }
      
      private function clearPages() : void
      {
         pageList.removeListItems();
         for each(var _loc1_ in var_885)
         {
            _loc1_.dispose();
         }
         var_312 = null;
         var_885 = new Vector.<SpecialItemPageButtonView>();
      }
      
      private function initializePages() : void
      {
         var _loc2_:int = 0;
         var _loc1_:SpecialItemPageButtonView = null;
         clearPages();
         _loc2_ = 0;
         while(_loc2_ < totalElements)
         {
            _loc1_ = new SpecialItemPageButtonView(this,_loc2_);
            pageList.addListItem(_loc1_.window);
            var_885.push(_loc1_);
            _loc2_ += 1;
         }
         if(var_55.items.length == 0)
         {
            return;
         }
         var_312 = var_885[0];
         var_312.selected = true;
      }
      
      private function clearElements() : void
      {
         for each(var _loc1_ in var_1089)
         {
            itemRotation.removeChild(_loc1_.window);
            _loc1_.dispose();
         }
         var_1089 = new Vector.<SpecialItemElementView>();
      }
      
      private function initializeElements() : void
      {
         var _loc2_:SpecialItemElementView = null;
         clearElements();
         for each(var _loc1_ in var_55.items)
         {
            _loc2_ = new SpecialItemElementView(this,_loc1_);
            itemRotation.addChild(_loc2_.window);
            var_1089.push(_loc2_);
         }
      }
      
      public function resetToFirstElement() : void
      {
         if(var_55.items.length == 0)
         {
            return;
         }
         selectedPage = 0;
         var _loc1_:class_2451 = var_55.items[0];
         var_593 = -1;
         setItemPlaque(_loc1_);
         var_302 = 0;
         var_652 = false;
         var_187 = 0;
         var_767 = 0;
         var_384 = false;
         var_115 = 0;
         updateRotationAnimation();
         plaqueAndSpotlightBlend = 1;
      }
      
      public function updateRotationAnimation() : void
      {
         for each(var _loc1_ in var_1089)
         {
            _loc1_.updateRotation(var_187);
         }
      }
      
      public function setItemPlaque(param1:class_2451) : void
      {
         if(param1.index == var_593)
         {
            return;
         }
         var_593 = param1.index;
         itemTitleText.text = param1.name;
         itemDescText.text = param1.description;
         (productIconWidget.widget as class_2343).productInfo = param1;
      }
      
      public function get totalElements() : int
      {
         return var_55.items.length;
      }
      
      private function onNextClick(param1:WindowMouseEvent) : void
      {
         var _loc2_:Boolean = var_652 && !var_384;
         navigateTo((var_302 + 1) % totalElements,true,false);
         var_115 = Math.max(0,var_115);
         if(_loc2_ && (var_187 > var_302 - 1 && var_187 < var_302 || var_187 > totalElements - 1 && var_302 == 0))
         {
            var_115 += 1;
         }
      }
      
      private function onPreviousClick(param1:WindowMouseEvent) : void
      {
         var _loc2_:Boolean = var_652 && var_384;
         navigateTo((var_302 - 1 + totalElements) % totalElements,true,true);
         var_115 = Math.min(0,var_115);
         if(_loc2_ && (var_187 > var_302 && var_187 < var_302 + 1))
         {
            var_115 -= 1;
         }
      }
      
      public function navigateTo(param1:int, param2:Boolean = false, param3:Boolean = false) : void
      {
         var_302 = param1;
         selectedPage = param1;
         if(!param2)
         {
            var_115 = 0;
            param3 = false;
            if(var_187 > param1)
            {
               param3 = true;
            }
         }
         var_384 = param3;
         if(!var_652)
         {
            var_767 = 0;
            var_652 = true;
         }
      }
      
      public function update(param1:uint) : void
      {
         var _loc4_:Number = NaN;
         if(!var_652)
         {
            return;
         }
         var _loc2_:int = totalElements;
         var _loc5_:Number = 1000 / param1;
         var _loc7_:Number = var_302 - var_187;
         if(_loc7_ > 0 && var_384)
         {
            _loc7_ -= _loc2_;
         }
         else if(_loc7_ < 0 && !var_384)
         {
            _loc7_ += _loc2_;
         }
         if(!var_384 && var_115 > 0 || var_384 && var_115 < 0)
         {
            _loc7_ += var_115 * _loc2_;
         }
         var _loc3_:Number = Math.abs(_loc7_) * 2;
         var _loc6_:* = _loc3_ > var_767;
         if(_loc6_)
         {
            _loc3_ = var_767 * 0.95 + _loc3_ * 0.05;
         }
         else
         {
            _loc3_ = var_767 * 0.85 + _loc3_ * 0.15;
         }
         _loc3_ = Math.max(0.05,_loc3_);
         var _loc8_:Number = _loc3_ / _loc5_;
         if(var_384)
         {
            _loc8_ *= -1;
         }
         var_767 = _loc3_;
         if(!var_384 && _loc8_ > _loc7_ || var_384 && _loc8_ < _loc7_)
         {
            var_652 = false;
            var_187 = var_302;
            var_115 = 0;
         }
         else
         {
            var_187 += _loc8_;
            if(var_115 != 0)
            {
               _loc4_ = _loc7_ % _loc2_;
               if(var_115 > 0 && !var_384 && _loc8_ > _loc4_)
               {
                  var_115 -= 1;
               }
               else if(var_115 < 0 && var_384 && _loc8_ < _loc4_)
               {
                  var_115 += 1;
               }
            }
            if(var_187 > _loc2_)
            {
               var_187 -= _loc2_;
            }
            else if(var_187 < 0)
            {
               var_187 += _loc2_;
            }
         }
         updatePlaqueAndSpotlight();
         updateRotationAnimation();
      }
      
      private function updatePlaqueAndSpotlight() : void
      {
         var _loc3_:SpecialItemElementView = null;
         var _loc2_:Number = NaN;
         if(!var_652)
         {
            plaqueAndSpotlightBlend = 1;
            setItemPlaque(var_1089[var_302].item);
            return;
         }
         var _loc1_:Number = 0;
         if(var_593 != -1)
         {
            _loc3_ = var_1089[var_593];
            _loc1_ = _loc3_.focusValue;
         }
         if(var_593 != var_302 && var_593 != -1 && _loc1_ == 0)
         {
            var_593 = -1;
         }
         if(var_593 != var_302 && var_115 == 0 && var_767 < Math.min(2,totalElements - 1))
         {
            _loc3_ = var_1089[var_302];
            _loc2_ = _loc3_.focusValue;
            if(_loc2_ > _loc1_)
            {
               _loc1_ = _loc2_;
               setItemPlaque(_loc3_.item);
            }
         }
         plaqueAndSpotlightBlend = _loc1_;
      }
      
      public function set plaqueAndSpotlightBlend(param1:Number) : void
      {
         if(param1 > 0.8)
         {
            var _loc6_:Number = 0.4 + (param1 - 0.8) / 0.2 * 0.6;
         }
         var _loc4_:Boolean = Math.abs(var_2708 - param1) > 0.1 || param1 == 0 && var_2708 != 0 || param1 == 1 && var_2708 != 1;
         if(_loc4_)
         {
            var_2708 = param1;
            itemTitleText.blend = param1;
            itemDescText.blend = param1;
            (productIconWidget.widget as class_2343).blend = param1;
            var _loc3_:IScrollbarWindow = itemScrollArea.findChildByName("_SCROLLBAR") as IScrollbarWindow;
            var _loc7_:class_1741 = null.findChildByName("slider_track");
            var _loc5_:class_1741 = _loc7_.findChildByName("slider_bar");
            null.blend = param1;
            null.blend = param1;
         }
      }
      
      public function set selectedPage(param1:int) : void
      {
         if(var_312 != null)
         {
            var_312.selected = false;
            var_312 = null;
         }
         if(param1 >= 0 && param1 < var_885.length)
         {
            var_312 = var_885[param1];
            var_312.selected = true;
         }
      }
      
      private function onClose(param1:WindowMouseEvent) : void
      {
         hide();
      }
      
      public function hide() : void
      {
         var _loc1_:class_2052 = null;
         if(isShowing())
         {
            _loc1_ = _windowManager.getDesktop(1);
            if(_loc1_ != null)
            {
               _loc1_.removeChild(_window);
            }
         }
      }
      
      public function show() : void
      {
         var _loc1_:class_2052 = null;
         if(!isShowing())
         {
            _loc1_ = _windowManager.getDesktop(1);
            if(_loc1_ != null)
            {
               _loc1_.addChild(_window);
               _window.center();
            }
         }
      }
      
      public function isShowing() : Boolean
      {
         return _window.parent != null;
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         clearPages();
         var_55.removeUpdateReceiver(this);
         var_302 = 0;
         var_652 = false;
         var_187 = 0;
         var_767 = 0;
         var_384 = false;
         var_593 = 0;
         _window.dispose();
         _window = null;
         var_2434.dispose();
         var_2434 = null;
         var_2307.dispose();
         var_2307 = null;
         var_55 = null;
         _windowManager = null;
         var_885 = null;
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get pageTemplate() : IRegionWindow
      {
         return var_2434;
      }
      
      public function get productDisplayTemplate() : class_2010
      {
         return var_2307;
      }
      
      private function get closeButton() : class_1741
      {
         return _window.findChildByName("header_button_close");
      }
      
      private function get setTitleText() : ITextWindow
      {
         return _window.findChildByName("set_title") as ITextWindow;
      }
      
      private function get setDescText() : ITextWindow
      {
         return _window.findChildByName("set_desc") as ITextWindow;
      }
      
      private function get platformImg() : IStaticBitmapWrapperWindow
      {
         return _window.findChildByName("platform_img") as IStaticBitmapWrapperWindow;
      }
      
      private function get spotlightImg() : IStaticBitmapWrapperWindow
      {
         return _window.findChildByName("spotlight_img") as IStaticBitmapWrapperWindow;
      }
      
      private function get itemRotation() : class_1812
      {
         return _window.findChildByName("item_rotation") as class_1812;
      }
      
      private function get spotlightBaseImg() : IStaticBitmapWrapperWindow
      {
         return _window.findChildByName("spotlight_base_img") as IStaticBitmapWrapperWindow;
      }
      
      private function get previousButton() : IRegionWindow
      {
         return _window.findChildByName("previous_button") as IRegionWindow;
      }
      
      private function get nextButton() : IRegionWindow
      {
         return _window.findChildByName("next_button") as IRegionWindow;
      }
      
      private function get pageList() : IItemListWindow
      {
         return _window.findChildByName("page_list") as IItemListWindow;
      }
      
      private function get itemTitleText() : ITextWindow
      {
         return _window.findChildByName("item_title") as ITextWindow;
      }
      
      private function get itemDescText() : ITextWindow
      {
         return _window.findChildByName("item_desc") as ITextWindow;
      }
      
      private function get productIconWidget() : class_2010
      {
         return _window.findChildByName("product_icon") as class_2010;
      }
      
      private function get itemScrollArea() : IScrollableListWindow
      {
         return _window.findChildByName("item_scroll_area") as IScrollableListWindow;
      }
   }
}

