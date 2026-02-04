package com.sulake.habbo.ui.widget.chooser
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_2250;
   import com.sulake.core.window.events.WindowMouseEvent;
   
   public class ChooserView
   {
      
      private var var_16:ChooserWidgetBase;
      
      private var var_839:String;
      
      private var _window:class_2250;
      
      private var _itemList:IItemListWindow;
      
      private var _items:Array;
      
      private var var_3413:Boolean;
      
      private var var_639:int;
      
      private const COLOR_EVEN:uint = 4293848814;
      
      private const COLOR_ODD:uint = 0;
      
      private const COLOR_HILITE:uint = 4282169599;
      
      public function ChooserView(param1:ChooserWidgetBase, param2:String)
      {
         super();
         var_16 = param1;
         var_839 = param2;
      }
      
      public function dispose() : void
      {
         if(_window != null)
         {
            _window.dispose();
            _window = null;
         }
      }
      
      public function isOpen() : Boolean
      {
         return _window != null && Boolean(_window.visible);
      }
      
      public function populate(param1:Array, param2:Boolean) : void
      {
         if(var_16 == null)
         {
            return;
         }
         if(_window == null)
         {
            createWindow();
         }
         if(_window == null || _itemList == null || param1 == null)
         {
            return;
         }
         _itemList.destroyListItems();
         var _loc3_:XmlAsset = XmlAsset(var_16.assets.getAssetByName("chooser_item"));
         if(_loc3_ == null)
         {
            return;
         }
         _items = param1.slice();
         var_3413 = param2;
         var _loc6_:int = 0;
         while(0 < param1.length)
         {
            var _loc4_:ChooserItem = param1[0] as ChooserItem;
            if(_loc4_ != null)
            {
               var _loc5_:class_1812 = var_16.windowManager.buildFromXML(_loc3_.content as XML) as class_1812;
               if(_loc5_ == null)
               {
                  return;
               }
               var _loc7_:ITextWindow = null.findChildByName("itemtext") as ITextWindow;
               if(_loc7_ == null)
               {
                  return;
               }
               null.id = 0;
               if(var_3413)
               {
                  null.text = null.name + " id: " + null.id;
               }
               else
               {
                  null.text = null.name;
               }
               null.color = 4293848814;
               null.addEventListener("WME_CLICK",onListItemClicked);
               _itemList.addListItem(null);
            }
            _loc6_++;
         }
         _loc6_ = 0;
         while(0 < _itemList.numListItems)
         {
            _loc5_ = _itemList.getListItemAt(0) as class_1812;
            if(_loc5_ != null)
            {
               null.width = _itemList.width;
            }
            _loc6_++;
         }
         var_639 = -1;
      }
      
      private function createWindow() : void
      {
         var _loc1_:XmlAsset = XmlAsset(var_16.assets.getAssetByName("chooser_view"));
         if(_loc1_ == null)
         {
            return;
         }
         _window = var_16.windowManager.buildFromXML(_loc1_.content as XML) as class_2250;
         if(_window == null)
         {
            return;
         }
         _window.caption = var_839;
         _itemList = _window.findChildByName("item_list") as IItemListWindow;
         var _loc2_:class_1741 = _window.findChildByTag("close");
         if(_loc2_ != null)
         {
            _loc2_.addEventListener("WME_CLICK",onClose);
         }
         if(_window.parent != null)
         {
            _window.x = _window.parent.width - _window.width - 10;
            _window.y = 10;
         }
      }
      
      private function hideWindow() : void
      {
         if(_window != null)
         {
            _window.dispose();
            _window = null;
         }
      }
      
      private function onListItemClicked(param1:WindowMouseEvent) : void
      {
         if(param1 == null || param1.window == null || _items == null)
         {
            return;
         }
         var _loc3_:int = param1.window.id;
         if(_loc3_ < 0 || _loc3_ > _items.length)
         {
            return;
         }
         var _loc2_:ChooserItem = _items[_loc3_] as ChooserItem;
         if(_loc2_ == null)
         {
            return;
         }
         var_16.choose(_loc2_.id,_loc2_.category);
         highlightItem(_loc3_);
      }
      
      private function highlightItem(param1:int) : void
      {
         var _loc2_:class_1812 = null;
         if(_itemList == null || param1 < 0 || param1 > _itemList.numListItems || param1 == var_639)
         {
            return;
         }
         if(var_639 != -1)
         {
            _loc2_ = _itemList.getListItemAt(var_639) as class_1812;
            if(_loc2_ != null)
            {
               _loc2_.color = var_639 % 2 ? 0 : 4293848814;
            }
         }
         _loc2_ = _itemList.getListItemAt(param1) as class_1812;
         if(_loc2_ != null)
         {
            _loc2_.color = 4282169599;
            var_639 = param1;
         }
      }
      
      public function removeItem(param1:int, param2:int) : void
      {
         var _loc3_:ChooserItem = null;
         var _loc4_:int = 0;
         if(_items == null || _itemList == null)
         {
            return;
         }
         _loc4_ = 0;
         while(_loc4_ < _items.length)
         {
            _loc3_ = _items[_loc4_] as ChooserItem;
            if(_loc3_ != null)
            {
               if(_loc3_.id == param1 && _loc3_.category == param2)
               {
                  _items.splice(_loc4_,1);
                  break;
               }
            }
            _loc4_++;
         }
         populate(_items,var_3413);
      }
      
      private function onClose(param1:WindowMouseEvent) : void
      {
         hideWindow();
      }
   }
}

