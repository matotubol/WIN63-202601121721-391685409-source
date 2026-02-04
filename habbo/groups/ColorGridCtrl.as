package com.sulake.habbo.groups
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.runtime.exceptions.Exception;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IItemGridWindow;
   import com.sulake.core.window.components.class_2251;
   import com.sulake.core.window.events.class_1758;
   import flash.display.BitmapData;
   import flash.geom.ColorTransform;
   import package_3.class_2927;
   
   public class ColorGridCtrl
   {
      
      private var var_52:HabboGroupsManager;
      
      private var var_2998:class_1812;
      
      private var _parentCallback:Function;
      
      private var var_1364:Vector.<class_2927>;
      
      private var var_730:IItemGridWindow;
      
      private var var_917:int = -1;
      
      private var var_1848:BitmapData;
      
      private var var_745:BitmapData;
      
      private var var_1988:BitmapData;
      
      private var _disposed:Boolean = false;
      
      public function ColorGridCtrl(param1:HabboGroupsManager, param2:Function)
      {
         super();
         var_52 = param1;
         _parentCallback = param2;
      }
      
      public function get selectedColorIndex() : int
      {
         return var_917;
      }
      
      public function get isInitialized() : Boolean
      {
         return var_1364 != null && var_730 != null;
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            if(var_730)
            {
               var_730.destroyGridItems();
               var_730 = null;
            }
            if(var_745)
            {
               var_745.dispose();
               var_745 = null;
            }
            if(var_1988)
            {
               var_1988.dispose();
               var_1988 = null;
            }
            if(var_745)
            {
               var_745.dispose();
               var_745 = null;
            }
            if(var_1848)
            {
               var_1848.dispose();
               var_1848 = null;
            }
            var_52 = null;
            var_2998 = null;
            _disposed = true;
         }
      }
      
      public function createAndAttach(param1:class_1812, param2:String, param3:Vector.<class_2927>) : void
      {
         if(var_730 != null || param1 == null || param2 == null || param3 == null)
         {
            return;
         }
         var_2998 = param1;
         var_1364 = param3;
         var_730 = var_2998.findChildByName(param2) as IItemGridWindow;
         var_745 = getBitmap("color_chooser_bg");
         var_1988 = getBitmap("color_chooser_fg");
         var_1848 = getBitmap("color_chooser_selected");
         for each(var _loc5_ in var_1364)
         {
            var _loc4_:class_1812 = var_52.getXmlWindow("badge_color_item") as class_1812;
            _loc4_.procedure = onClick;
            null.background = true;
            null.color = 4290689957;
            null.width = var_745.width;
            null.height = var_745.height;
            setGridItemBitmap(null,"background",var_745,true,null);
            setGridItemBitmap(null,"foreground",var_1988,true,_loc5_);
            setGridItemBitmap(null,"selected",var_1848,false,null);
            var_730.addGridItem(null);
         }
      }
      
      private function setGridItemBitmap(param1:class_1812, param2:String, param3:BitmapData, param4:Boolean, param5:class_2927 = null) : void
      {
         var _loc7_:BitmapData = null;
         var _loc6_:class_2251 = param1.findChildByName(param2) as class_2251;
         if(_loc6_ != null)
         {
            _loc7_ = param3.clone();
            if(param5 != null)
            {
               _loc7_.colorTransform(_loc7_.rect,new ColorTransform(param5.red / 255,param5.green / 255,param5.blue / 255));
            }
            _loc6_.bitmap = _loc7_;
            _loc6_.visible = param4;
         }
      }
      
      public function setSelectedColorIndex(param1:int, param2:Boolean = true) : void
      {
         if(param1 < 0)
         {
            param1 = 0;
         }
         if(var_917 != param1 && param1 < var_730.numGridItems)
         {
            setSelectedItemVisibility(var_917,false);
            var_917 = param1;
            setSelectedItemVisibility(var_917,true);
         }
         if(param2 && _parentCallback != null)
         {
            _parentCallback(this);
         }
      }
      
      public function setSelectedColorById(param1:int) : void
      {
         var _loc2_:int = 0;
         if(!isInitialized)
         {
            return;
         }
         _loc2_ = 0;
         while(_loc2_ < var_1364.length)
         {
            if(var_1364[_loc2_].id == param1)
            {
               setSelectedColorIndex(_loc2_);
               return;
            }
            _loc2_++;
         }
         setSelectedColorIndex(0);
      }
      
      public function getSelectedColorId() : int
      {
         var _loc1_:class_2927 = getSelectedColorData();
         if(_loc1_ != null)
         {
            return _loc1_.id;
         }
         return 0;
      }
      
      public function getSelectedColorData() : class_2927
      {
         if(var_1364 != null && var_917 >= 0 && var_917 < var_1364.length)
         {
            return var_1364[var_917];
         }
         return null;
      }
      
      private function getBitmap(param1:String) : BitmapData
      {
         var _loc3_:BitmapData = null;
         var _loc2_:BitmapDataAsset = var_52.assets.getAssetByName(param1) as BitmapDataAsset;
         if(_loc2_)
         {
            _loc3_ = _loc2_.content as BitmapData;
            if(_loc3_ != null)
            {
               return _loc3_;
            }
         }
         throw new Exception("Failed to load bitmap asset " + param1 + " in ColorGridWidget");
      }
      
      private function setSelectedItemVisibility(param1:int, param2:Boolean) : void
      {
         var _loc3_:class_1741 = null;
         if(param1 < 0 || param1 >= var_730.numGridItems)
         {
            return;
         }
         var _loc4_:class_1812 = var_730.getGridItemAt(param1) as class_1812;
         if(_loc4_ != null)
         {
            _loc3_ = _loc4_.findChildByName("selected") as class_1741;
            if(_loc3_ != null)
            {
               _loc3_.visible = param2;
            }
         }
      }
      
      private function onClick(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         setSelectedColorIndex(var_730.getGridItemIndex(param2));
      }
   }
}

