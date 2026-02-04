package com.sulake.habbo.inventory.collectibles
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.utils.class_55;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_2010;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.window.widgets.class_2343;
   import package_111.class_3106;
   
   public class CollectibleGroupedItem
   {
      
      private static const THUMB_COLOR_NORMAL:int = 13421772;
      
      private static const THUMB_COLOR_UNSEEN:int = 10275685;
      
      private var var_265:Boolean = false;
      
      private var var_2533:RenderableTradeNftItem;
      
      private var var_204:class_55;
      
      private var var_2281:Boolean;
      
      private var _window:class_1812;
      
      private var var_978:class_1741;
      
      private var _isUnseen:Boolean;
      
      private var var_36:CollectiblesModel;
      
      private var _name:String;
      
      public function CollectibleGroupedItem(param1:class_3106, param2:Vector.<Number>, param3:CollectiblesModel)
      {
         super();
         var_2533 = new RenderableTradeNftItem(param1);
         var_204 = new class_55();
         for each(var _loc4_ in param2)
         {
            var_204.add(_loc4_,false);
         }
         var_36 = param3;
         _isUnseen = false;
         this.isSelected = false;
         var _loc5_:XmlAsset = var_36.controller.assets.getAssetByName("inventory_thumb_nft_xml") as XmlAsset;
         if(_loc5_ == null || _loc5_.content == null)
         {
            return;
         }
         _window = var_36.controller.windowManager.buildFromXML(_loc5_.content as XML) as class_1812;
         _window.procedure = itemEventProc;
         var_978 = _window.findChildByTag("BG_COLOR");
         _name = var_36.controller.catalog.collectorHub.getProductName(var_2533);
         unlockedAssetCountChanged();
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function initializeImage() : void
      {
         (nftIconWidget.widget as class_2343).productInfo = var_2533;
         var_265 = true;
      }
      
      public function get isInitialized() : Boolean
      {
         return var_265;
      }
      
      public function get item() : class_3106
      {
         return var_2533.item;
      }
      
      public function addAssetId(param1:Number) : void
      {
         var_204.add(param1,false);
         unlockedAssetCountChanged();
      }
      
      public function get assetIds() : Array
      {
         return var_204.getKeys();
      }
      
      public function pop(param1:int) : Vector.<Number>
      {
         var _loc2_:Boolean = false;
         var _loc3_:Vector.<Number> = new Vector.<Number>();
         for each(var _loc4_ in var_204.getKeys())
         {
            _loc2_ = var_204.getValue(_loc4_);
            if(!_loc2_)
            {
               _loc3_.push(_loc4_);
            }
            if(_loc3_.length >= param1)
            {
               break;
            }
         }
         return _loc3_;
      }
      
      public function removeAssetId(param1:Number) : Boolean
      {
         if(var_204.hasKey(param1))
         {
            var_204.remove(param1);
            unlockedAssetCountChanged();
            return true;
         }
         return false;
      }
      
      public function hasAsset(param1:Number, param2:Boolean = false) : Boolean
      {
         if(var_204.hasKey(param1))
         {
            var _loc3_:Boolean = var_204.getValue(param1);
            return false == param2;
         }
         return false;
      }
      
      public function lockAsset(param1:Number, param2:Boolean = false) : Boolean
      {
         if(!var_204.hasKey(param1))
         {
            return false;
         }
         var _loc3_:Boolean = var_204.getValue(param1);
         if(_loc3_ && param2)
         {
            var_204.remove(param1);
            var_204.add(param1,false);
            unlockedAssetCountChanged();
            return true;
         }
         if(!_loc3_ && !param2)
         {
            var_204.remove(param1);
            var_204.add(param1,true);
            unlockedAssetCountChanged();
            return true;
         }
         return false;
      }
      
      public function unlockAll() : void
      {
         for each(var _loc1_ in var_204.getKeys())
         {
            if(var_204.getValue(_loc1_))
            {
               var_204.remove(_loc1_);
               var_204.add(_loc1_,false);
               var _loc2_:Boolean = true;
            }
         }
      }
      
      public function get amount() : int
      {
         return var_204.length;
      }
      
      private function unlockedAssetCountChanged() : void
      {
         var _loc2_:int = unlockedAssetCount;
         numberContainer.visible = _loc2_ > 1;
         numberText.caption = String(_loc2_);
         var _loc1_:Number = _loc2_ == 0 ? 0.2 : 1;
         (nftIconWidget.widget as class_2343).blend = _loc1_;
      }
      
      public function get unlockedAssetCount() : int
      {
         var _loc1_:int = 0;
         for each(var _loc2_ in var_204.getValues())
         {
            if(!_loc2_)
            {
               _loc1_ += 1;
            }
         }
         return _loc1_;
      }
      
      public function dispose() : void
      {
         if(var_2281)
         {
            var_36.setSelected(null);
         }
         if(_window != null)
         {
            _window.dispose();
            _window = null;
         }
      }
      
      public function get isSelected() : Boolean
      {
         return var_2281;
      }
      
      public function get window() : class_1812
      {
         return _window;
      }
      
      private function itemEventProc(param1:class_1758, param2:class_1741) : void
      {
         switch(param1.type)
         {
            case "WME_CLICK":
               var_36.setSelected(this);
               break;
            case "WME_DOUBLE_CLICK":
               var_36.requestAddTrading(this,1);
         }
      }
      
      public function set isSelected(param1:Boolean) : void
      {
         var_2281 = param1;
         if(var_978 == null || _window == null)
         {
            return;
         }
         var_978.color = _isUnseen ? 10275685 : 13421772;
         _window.findChildByName("outline").visible = param1;
      }
      
      public function set isUnseen(param1:Boolean) : void
      {
         if(_isUnseen != param1)
         {
            _isUnseen = param1;
            this.isSelected = var_2281;
         }
      }
      
      public function removeIntervalProcedure() : void
      {
         if(_window)
         {
            _window.procedure = null;
         }
      }
      
      protected function get nftIconWidget() : class_2010
      {
         return _window.findChildByName("nft_icon") as class_2010;
      }
      
      protected function get numberContainer() : class_1812
      {
         return _window.findChildByName("number_container") as class_1812;
      }
      
      protected function get numberText() : ITextWindow
      {
         return _window.findChildByName("number") as ITextWindow;
      }
      
      public function get renderableItem() : RenderableTradeNftItem
      {
         return var_2533;
      }
   }
}

