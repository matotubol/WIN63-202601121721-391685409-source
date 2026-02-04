package com.sulake.habbo.catalog.collectibles
{
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.runtime.class_31;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_1775;
   import com.sulake.core.window.components.class_2010;
   import com.sulake.core.window.components.class_2052;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.catalog.collectibles.renderer.model.BaseItemWrapper;
   import com.sulake.habbo.catalog.collectibles.util.class_2502;
   import com.sulake.habbo.window.class_38;
   import com.sulake.habbo.window.widgets.class_1902;
   
   public class CollectiblesRewardBoxView implements class_13, class_31
   {
      
      public static var BG_STAR_ROTATE_SPEED:Number = 20;
      
      private var _windowManager:class_38;
      
      private var var_55:CollectiblesController;
      
      private var _window:class_1812;
      
      private var var_1831:IStaticBitmapWrapperWindow;
      
      private var var_3200:Array = [];
      
      public function CollectiblesRewardBoxView(param1:CollectiblesController, param2:class_38)
      {
         super();
         var_55 = param1;
         _windowManager = param2;
         _window = param2.buildFromXML(XML(var_55.assets.getAssetByName("collectible_reward_xml").content),2) as class_1812;
         var_1831 = rotatingStar;
         var_55.registerUpdateReceiver(this,1);
         if(closeButton != null)
         {
            closeButton.addEventListener("WME_CLICK",onWindowCloseRequested);
         }
         if(okButton != null)
         {
            okButton.addEventListener("WME_CLICK",onWindowCloseRequested);
         }
      }
      
      public function dispose() : void
      {
         var_55.removeUpdateReceiver(this);
         if(_window)
         {
            _window.dispose();
            _window = null;
         }
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
      
      private function onWindowCloseRequested(param1:class_1758) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         showNextRewardOrClose();
      }
      
      private function hideWindow() : void
      {
         var _loc1_:class_2052 = null;
         if(_windowManager != null && _window != null && _window.parent != null)
         {
            _loc1_ = _windowManager.getDesktop(2);
            if(_loc1_ != null)
            {
               _loc1_.removeChild(_window);
            }
         }
      }
      
      public function showReward(param1:BaseItemWrapper, param2:Boolean) : void
      {
         var _loc3_:class_2052 = null;
         if(param1.baseItem == null)
         {
            return;
         }
         var_3200.push(param1);
         if(_windowManager != null && _window != null && _window.parent == null)
         {
            _loc3_ = _windowManager.getDesktop(2);
            if(_loc3_ != null)
            {
               _loc3_.addChild(_window);
            }
            showNextRewardOrClose();
         }
         else if(param2)
         {
            showNextRewardOrClose();
         }
      }
      
      private function showNextRewardOrClose() : void
      {
         var _loc1_:BaseItemWrapper = null;
         if(var_3200.length > 0)
         {
            _loc1_ = var_3200.shift();
            populateRewardItem(_loc1_);
         }
         else
         {
            hideWindow();
         }
      }
      
      private function populateRewardItem(param1:BaseItemWrapper) : void
      {
         productImage.productInfo = param1;
         setWindowColors(param1.baseItem.rarity);
         productNameText.caption = var_55.getProductName(param1);
         rarityText.text = param1.baseItem.rarity.toUpperCase();
      }
      
      private function setWindowColors(param1:String) : void
      {
         var _loc2_:uint = class_2502.getRarityColor(param1);
         _window.color = _loc2_;
         background.color = _loc2_;
      }
      
      private function get background() : class_1741
      {
         return _window.findChildByName("background") as class_1741;
      }
      
      private function get productImage() : class_1902
      {
         var _loc1_:class_2010 = _window.findChildByName("product_image") as class_2010;
         return _loc1_.widget as class_1902;
      }
      
      private function get productNameText() : ITextWindow
      {
         return _window.findChildByName("product_name") as ITextWindow;
      }
      
      private function get closeButton() : class_1741
      {
         return _window.findChildByName("header_button_close") as class_1741;
      }
      
      private function get okButton() : class_1775
      {
         return _window.findChildByName("ok_button") as class_1775;
      }
      
      private function get rotatingStar() : IStaticBitmapWrapperWindow
      {
         return _window.findChildByName("rotating_star") as IStaticBitmapWrapperWindow;
      }
      
      private function get rarityText() : ITextWindow
      {
         return _window.findChildByName("rarity_text") as ITextWindow;
      }
      
      public function update(param1:uint) : void
      {
         var _loc2_:Number = BG_STAR_ROTATE_SPEED * (param1 / 1000);
         var_1831.rotation += _loc2_;
         var_1831.rotation %= 360;
         var_1831.invalidate();
      }
   }
}

