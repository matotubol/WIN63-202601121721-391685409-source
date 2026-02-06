package com.sulake.habbo.groups.badge
{
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.class_1993;
   import com.sulake.core.window.components.class_2251;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.groups.HabboGroupsManager;
   import flash.display.BitmapData;
   import flash.geom.Point;
   import com.sulake.habbo.communication.messages.incoming.users.class_2862;
   
   public class BadgeSelectPartCtrl implements class_13
   {
      
      private var var_52:HabboGroupsManager;
      
      private var var_283:BadgeEditorCtrl;
      
      private var var_562:Vector.<BadgeEditorPartItem>;
      
      private var var_686:Vector.<BadgeEditorPartItem>;
      
      private var var_269:BadgeLayerOptions;
      
      private var var_165:class_1812;
      
      private var var_957:class_2251;
      
      private var _disposed:Boolean = false;
      
      public function BadgeSelectPartCtrl(param1:HabboGroupsManager, param2:BadgeEditorCtrl)
      {
         super();
         var_52 = param1;
         var_283 = param2;
      }
      
      public function get layerOptions() : BadgeLayerOptions
      {
         return var_269;
      }
      
      public function set layerOptions(param1:BadgeLayerOptions) : void
      {
         var_269 = param1;
      }
      
      public function dispose() : void
      {
         var _loc1_:* = null;
         if(!_disposed)
         {
            if(var_283.partSelectGrid != null && var_283.partSelectGrid.numGridItems > 0)
            {
               var_283.partSelectGrid.destroyGridItems();
            }
            if(var_686)
            {
               for each(_loc1_ in var_686)
               {
                  _loc1_.dispose();
               }
               var_686 = null;
            }
            if(var_562)
            {
               for each(_loc1_ in var_562)
               {
                  _loc1_.dispose();
               }
               var_562 = null;
            }
            var_269 = null;
            var_957 = null;
            var_165 = null;
            var_283 = null;
            var_52 = null;
            _disposed = true;
         }
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function getSelectedPartIndex() : int
      {
         var _loc1_:int = -1;
         if(var_269 != null && var_283.partSelectGrid != null && var_165 != null)
         {
            _loc1_ = var_283.partSelectGrid.getGridItemIndex(var_165);
            if(_loc1_ != -1 && var_269.layerIndex != BadgeLayerCtrl.BASE_LAYER_INDEX)
            {
               _loc1_ -= 1;
            }
         }
         return _loc1_;
      }
      
      public function loadData() : void
      {
         if(var_686 != null || var_562 != null)
         {
            return;
         }
         var_686 = new Vector.<BadgeEditorPartItem>();
         for each(var _loc1_ in var_52.guildEditorData.baseParts)
         {
            var_686.push(new BadgeEditorPartItem(var_52,this,var_686.length,BadgeEditorPartItem.BASE_PART,null));
         }
         var_562 = new Vector.<BadgeEditorPartItem>();
         var_562.push(new BadgeEditorPartItem(var_52,this,-1,BadgeEditorPartItem.LAYER_PART));
         for each(_loc1_ in var_52.guildEditorData.layerParts)
         {
            var_562.push(new BadgeEditorPartItem(var_52,this,var_562.length - 1,BadgeEditorPartItem.LAYER_PART,null));
         }
      }
      
      public function updateGrid() : void
      {
         var_165 = null;
         var_957 = null;
         var_269 = var_283.currentLayerOptions.clone();
         var_283.partSelectGrid.destroyGridItems();
         if(var_269.layerIndex == BadgeLayerCtrl.BASE_LAYER_INDEX)
         {
            for each(var _loc1_ in var_686)
            {
               var_283.partSelectGrid.addGridItem(createGridItem(null));
            }
         }
         else
         {
            for each(_loc1_ in var_562)
            {
               var_283.partSelectGrid.addGridItem(createGridItem(null));
            }
         }
      }
      
      private function createGridItem(param1:BadgeEditorPartItem) : class_1812
      {
         var _loc2_:class_1812 = var_52.getXmlWindow("badge_part_item") as class_1812;
         _loc2_.procedure = onPartMouseEvent;
         setGridItemImage(_loc2_,param1);
         return _loc2_;
      }
      
      public function onBaseImageLoaded(param1:BadgeEditorPartItem) : void
      {
         var _loc2_:class_1812 = null;
         if(var_269 != null && var_269.layerIndex == BadgeLayerCtrl.BASE_LAYER_INDEX && Boolean(var_283.partSelectContainer.visible))
         {
            _loc2_ = var_283.partSelectGrid.getGridItemAt(param1.partIndex) as class_1812;
            setGridItemImage(_loc2_,param1);
         }
      }
      
      public function onLayerImageLoaded(param1:BadgeEditorPartItem) : void
      {
         var _loc2_:class_1812 = null;
         if(var_269 != null && var_269.layerIndex != BadgeLayerCtrl.BASE_LAYER_INDEX && Boolean(var_283.partSelectContainer.visible))
         {
            _loc2_ = var_283.partSelectGrid.getGridItemAt(param1.partIndex + 1) as class_1812;
            setGridItemImage(_loc2_,param1);
         }
      }
      
      private function setGridItemImage(param1:class_1812, param2:BadgeEditorPartItem) : void
      {
         var _loc5_:class_2251 = null;
         var _loc4_:BitmapData = param2.getComposite(var_269);
         if(_loc4_ != null)
         {
            _loc5_ = param1.findChildByName("part") as class_2251;
            _loc5_.bitmap = new BitmapData(_loc4_.width,_loc4_.height);
            _loc5_.bitmap.copyPixels(_loc4_,_loc4_.rect,new Point());
         }
         var _loc3_:class_2251 = param1.findChildByName("selected") as class_2251;
         _loc3_.bitmap = var_52.getButtonImage("badge_part_picker");
         if(param2.partIndex == var_269.partIndex)
         {
            _loc3_.visible = true;
            var_957 = _loc3_;
         }
         else
         {
            _loc3_.visible = false;
         }
      }
      
      private function onPartMouseEvent(param1:class_1758, param2:class_1741) : void
      {
         var _loc4_:class_1812 = null;
         if(param1.type == "WME_OVER")
         {
            if(var_165 != param2)
            {
               if(var_165 != null)
               {
                  var _loc3_:class_1993 = var_165.findChildByName("background") as class_1993;
               }
               var_165 = param2 as class_1812;
               if(var_165 != null)
               {
                  _loc3_ = var_165.findChildByName("background") as class_1993;
                  var_269.partIndex = getSelectedPartIndex();
                  var_283.onPartHover(this);
               }
            }
         }
         if(param1.type == "WME_CLICK")
         {
            if(var_957 != null)
            {
               var_957.visible = false;
            }
            _loc4_ = param2 as class_1812;
            if(_loc4_ != null)
            {
               var_957 = _loc4_.findChildByName("selected") as class_2251;
               var_957.visible = true;
            }
            var_283.onPartSelected(this);
         }
      }
      
      public function getPartItemImage(param1:BadgeLayerOptions) : BitmapData
      {
         if(param1 == null || param1.partIndex < 0)
         {
            return null;
         }
         if(param1.layerIndex == BadgeLayerCtrl.BASE_LAYER_INDEX)
         {
            if(var_686 != null && param1.partIndex < var_686.length)
            {
               return var_686[param1.partIndex].getComposite(param1);
            }
         }
         else if(var_562 != null && param1.partIndex + 1 < var_562.length)
         {
            return var_562[param1.partIndex + 1].getComposite(param1);
         }
         return null;
      }
   }
}

