package com.sulake.habbo.groups.badge
{
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IItemGridWindow;
   import com.sulake.core.window.components.class_2251;
   import com.sulake.habbo.groups.*;
   import com.sulake.habbo.groups.events.HabboGroupsEditorData;
   import flash.display.BitmapData;
   import flash.geom.Point;
   import com.sulake.habbo.communication.messages.incoming.users.class_2463;
   
   public class BadgeEditorCtrl implements class_13
   {
      
      private var var_52:HabboGroupsManager;
      
      private var _window:class_1812;
      
      private var var_2998:class_1812;
      
      private var var_1200:Array;
      
      private var var_876:BadgeSelectPartCtrl;
      
      private var _disposed:Boolean = false;
      
      private var _layers:Vector.<BadgeLayerCtrl>;
      
      private var var_771:BadgeLayerOptions;
      
      private var var_458:class_1812;
      
      private var var_2047:IItemGridWindow;
      
      private var var_872:class_1812;
      
      private var var_525:Vector.<class_2251>;
      
      public function BadgeEditorCtrl(param1:HabboGroupsManager)
      {
         super();
         var_52 = param1;
         var_52.events.addEventListener("HGE_EDIT_INFO",onHabboGroupsEditorData);
         var_876 = new BadgeSelectPartCtrl(var_52,this);
         _layers = new Vector.<BadgeLayerCtrl>();
         _layers.push(new BadgeLayerCtrl(var_52,this,0));
         _layers.push(new BadgeLayerCtrl(var_52,this,1));
         _layers.push(new BadgeLayerCtrl(var_52,this,2));
         _layers.push(new BadgeLayerCtrl(var_52,this,3));
         _layers.push(new BadgeLayerCtrl(var_52,this,4));
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get partEditContainer() : class_1812
      {
         return var_872;
      }
      
      public function get partSelectContainer() : class_1812
      {
         return var_458;
      }
      
      public function get partSelectGrid() : IItemGridWindow
      {
         return var_2047;
      }
      
      public function get currentLayerOptions() : BadgeLayerOptions
      {
         return var_771;
      }
      
      public function get badgeSelectPartCtrl() : BadgeSelectPartCtrl
      {
         return var_876;
      }
      
      public function get isIntialized() : Boolean
      {
         return _window != null && var_1200 != null;
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            if(_layers)
            {
               for each(var _loc1_ in _layers)
               {
                  _loc1_.dispose();
               }
               _layers = null;
            }
            if(var_876)
            {
               var_876.dispose();
               var_876 = null;
            }
            if(var_458)
            {
               var_458.dispose();
               var_458 = null;
            }
            if(var_2047)
            {
               var_2047.dispose();
               var_2047 = null;
            }
            if(var_872)
            {
               var_872.dispose();
               var_872 = null;
            }
            if(var_525)
            {
               for each(var _loc2_ in var_525)
               {
                  _loc2_.dispose();
               }
               var_525 = null;
            }
            if(_window)
            {
               _window.dispose();
               _window = null;
            }
            var_1200 = null;
            var_771 = null;
            _window = null;
            var_52 = null;
            _disposed = true;
         }
      }
      
      public function onHabboGroupsEditorData(param1:HabboGroupsEditorData) : void
      {
         var_876.loadData();
         createWindow(null,null);
      }
      
      public function createWindow(param1:class_1812, param2:Array) : void
      {
         if(_window != null || _disposed)
         {
            return;
         }
         if(param1 != null)
         {
            var_2998 = param1;
         }
         if(param2 != null)
         {
            var_1200 = param2;
         }
         if(var_2998 == null || var_1200 == null || var_52 == null || var_52.guildEditorData == null)
         {
            return;
         }
         _window = var_52.getXmlWindow("badge_editor") as class_1812;
         var _loc4_:class_1812 = _window.findChildByName("guild_badge") as class_1812;
         var_525 = new Vector.<class_2251>();
         var_525.push(_loc4_.findChildByName("layer_0") as class_2251);
         var_525.push(_loc4_.findChildByName("layer_1") as class_2251);
         var_525.push(_loc4_.findChildByName("layer_2") as class_2251);
         var_525.push(_loc4_.findChildByName("layer_3") as class_2251);
         var_525.push(_loc4_.findChildByName("layer_4") as class_2251);
         var_872 = _window.findChildByName("part_edit") as class_1812;
         var_458 = _window.findChildByName("part_select") as class_1812;
         var_458.visible = false;
         var_2047 = var_458.findChildByName("part_select_grid") as IItemGridWindow;
         var _loc3_:int = 0;
         while(0 < _layers.length)
         {
            _layers[0].createWindow();
            _loc3_++;
         }
         resetLayerOptions(var_1200);
         var_2998.addChild(_window);
      }
      
      public function resetLayerOptions(param1:Array) : void
      {
         if(!this.isIntialized)
         {
            return;
         }
         if(var_458.visible)
         {
            var_458.visible = false;
            var_872.visible = true;
         }
         var_1200 = param1;
         var_771 = null;
         var_872.visible = true;
         var_458.visible = false;
         var_876.loadData();
         var _loc2_:int = 0;
         while(0 < _layers.length)
         {
            _layers[0].setLayerOptions(createLayerOption(0));
            _layers[0].updateSelectedPart();
            _loc2_++;
         }
      }
      
      private function createLayerOption(param1:int) : BadgeLayerOptions
      {
         var _loc3_:int = 0;
         var _loc2_:class_2463 = var_1200[param1] as class_2463;
         var _loc4_:BadgeLayerOptions = new BadgeLayerOptions();
         _loc4_.layerIndex = param1;
         _loc4_.colorIndex = 0;
         _loc4_.setGrid(_loc2_.position);
         _loc3_ = 0;
         while(_loc3_ < var_52.guildEditorData.badgeColors.length)
         {
            if(var_52.guildEditorData.badgeColors[_loc3_].id == _loc2_.colorId)
            {
               _loc4_.colorIndex = _loc3_;
               break;
            }
            _loc3_++;
         }
         if(param1 == BadgeLayerCtrl.BASE_LAYER_INDEX)
         {
            _loc3_ = 0;
            while(_loc3_ < var_52.guildEditorData.baseParts.length)
            {
               if(var_52.guildEditorData.baseParts[_loc3_].id == _loc2_.partId)
               {
                  _loc4_.partIndex = _loc3_;
                  break;
               }
               _loc3_++;
            }
         }
         else
         {
            _loc3_ = 0;
            while(_loc3_ < var_52.guildEditorData.layerParts.length)
            {
               if(var_52.guildEditorData.layerParts[_loc3_].id == _loc2_.partId)
               {
                  _loc4_.partIndex = _loc3_;
                  break;
               }
               _loc3_++;
            }
         }
         return _loc4_;
      }
      
      public function onPartSelected(param1:BadgeSelectPartCtrl) : void
      {
         var_771.partIndex = param1.getSelectedPartIndex();
         _layers[var_771.layerIndex].setLayerOptions(currentLayerOptions);
         var_872.visible = true;
         var_458.visible = false;
      }
      
      public function onPartHover(param1:BadgeSelectPartCtrl) : void
      {
         updatePreviewImage(param1.layerOptions);
      }
      
      public function onPartChanged(param1:BadgeLayerCtrl) : void
      {
         updatePreviewImage(param1.layerOptions);
      }
      
      public function updatePreviewImage(param1:BadgeLayerOptions) : void
      {
         var _loc2_:BitmapData = var_876.getPartItemImage(param1);
         if(_loc2_ != null)
         {
            var_525[param1.layerIndex].bitmap = _loc2_.clone();
            var_525[param1.layerIndex].visible = true;
         }
         else
         {
            var_525[param1.layerIndex].visible = false;
         }
      }
      
      public function onShowSelectPart(param1:BadgeLayerCtrl) : void
      {
         var _loc2_:BadgeLayerOptions = var_771;
         var_771 = param1.layerOptions.clone();
         if(!param1.layerOptions.equalVisuals(_loc2_))
         {
            var_876.updateGrid();
         }
         else
         {
            var_876.layerOptions = var_771.clone();
         }
         var_872.visible = false;
         var_458.visible = true;
      }
      
      public function onViewChange() : void
      {
         if(isIntialized && Boolean(var_458.visible))
         {
            updatePreviewImage(var_771);
            var_872.visible = true;
            var_458.visible = false;
         }
      }
      
      public function getBadgeSettings() : Array
      {
         var _loc2_:int = 0;
         var _loc1_:Array = [];
         for each(var _loc4_ in _layers)
         {
            _loc2_ = getLayerPartId(_loc4_.layerOptions);
            if(_loc2_ >= 0)
            {
               var _loc3_:int = getLayerColorId(_loc4_.layerOptions);
               _loc1_.push(_loc2_);
               _loc1_.push(0);
               _loc1_.push(_loc4_.layerOptions.position);
            }
         }
         return _loc1_;
      }
      
      public function get primaryColorIndex() : int
      {
         if(_layers == null)
         {
            return 0;
         }
         var _loc1_:int = 0;
         for each(var _loc2_ in _layers)
         {
            if(!(getLayerPartId(_loc2_.layerOptions) < 0 || getLayerColorId(_loc2_.layerOptions) < 0))
            {
               _loc1_ = _loc2_.layerOptions.colorIndex;
            }
         }
         return _loc1_;
      }
      
      public function get secondaryColorIndex() : int
      {
         if(_layers != null)
         {
            return _layers[0].layerOptions.colorIndex;
         }
         return 0;
      }
      
      public function getBadgeBitmap() : BitmapData
      {
         var _loc1_:BitmapData = new BitmapData(BadgeEditorPartItem.IMAGE_WIDTH,BadgeEditorPartItem.IMAGE_HEIGHT,true,15329761);
         for each(var _loc2_ in var_525)
         {
            if(_loc2_.visible)
            {
               _loc1_.copyPixels(_loc2_.bitmap,_loc1_.rect,new Point(),null,null,true);
            }
         }
         return _loc1_;
      }
      
      private function getLayerPartId(param1:BadgeLayerOptions) : int
      {
         if(param1.partIndex < 0)
         {
            return -1;
         }
         if(param1.layerIndex == BadgeLayerCtrl.BASE_LAYER_INDEX)
         {
            if(param1.partIndex >= var_52.guildEditorData.baseParts.length)
            {
               return -1;
            }
            return var_52.guildEditorData.baseParts[param1.partIndex].id;
         }
         if(param1.partIndex >= var_52.guildEditorData.layerParts.length)
         {
            return -1;
         }
         return var_52.guildEditorData.layerParts[param1.partIndex].id;
      }
      
      private function getLayerColorId(param1:BadgeLayerOptions) : int
      {
         if(param1.colorIndex < 0 || param1.colorIndex >= var_52.guildEditorData.badgeColors.length)
         {
            return -1;
         }
         return var_52.guildEditorData.badgeColors[param1.colorIndex].id;
      }
   }
}

