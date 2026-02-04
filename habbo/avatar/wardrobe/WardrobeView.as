package com.sulake.habbo.avatar.wardrobe
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.habbo.avatar.common.ISideContentView;
   
   public class WardrobeView implements ISideContentView
   {
      
      private var _window:class_1812;
      
      private var var_36:WardrobeModel;
      
      private var var_1526:IItemListWindow;
      
      private var var_2304:IItemListWindow;
      
      private var var_2907:class_1741;
      
      public function WardrobeView(param1:WardrobeModel)
      {
         super();
         var_36 = param1;
         var _loc2_:XmlAsset = var_36.controller.manager.assets.getAssetByName("avatareditor_wardrobe_base") as XmlAsset;
         _window = var_36.controller.manager.windowManager.buildFromXML(_loc2_.content as XML) as class_1812;
         var_1526 = _window.findChildByName("hc_slots") as IItemListWindow;
         var_2304 = _window.findChildByName("vip_slots") as IItemListWindow;
         var_2907 = _window.findChildByName("slot_template");
         if(var_2907)
         {
            _window.removeChild(var_2907);
         }
         _window.visible = false;
      }
      
      public function get slotWindowTemplate() : class_1741
      {
         return var_2907;
      }
      
      public function dispose() : void
      {
         var_36 = null;
         var_1526 = null;
         if(_window)
         {
            _window.dispose();
            _window = null;
         }
      }
      
      public function update() : void
      {
         var _loc3_:WardrobeSlot = null;
         var _loc2_:int = 0;
         if(var_1526)
         {
            var_1526.removeListItems();
         }
         if(var_2304)
         {
            var_2304.removeListItems();
         }
         var _loc1_:Array = var_36.slots;
         _loc2_ = 0;
         while(_loc2_ < _loc1_.length)
         {
            _loc3_ = _loc1_[_loc2_];
            if(_loc2_ < 5)
            {
               if(var_1526)
               {
                  var_1526.addListItem(_loc3_.view);
                  _loc3_.view.visible = true;
               }
            }
            else if(var_2304)
            {
               var_2304.addListItem(_loc3_.view);
               _loc3_.view.visible = true;
            }
            _loc2_++;
         }
      }
      
      public function getWindowContainer() : class_1812
      {
         return _window;
      }
   }
}

