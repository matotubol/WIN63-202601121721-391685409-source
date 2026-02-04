package com.sulake.habbo.groups.badge
{
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.class_1775;
   import com.sulake.core.window.components.class_2251;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.groups.ColorGridCtrl;
   import com.sulake.habbo.groups.HabboGroupsManager;
   import flash.display.BitmapData;
   import flash.geom.Point;
   
   public class BadgeLayerCtrl
   {
      
      public static var BASE_LAYER_INDEX:int = 0;
      
      public static var PARENT_CONTAINER_NAME:String = "part_edit_list";
      
      private var var_52:HabboGroupsManager;
      
      private var var_283:BadgeEditorCtrl;
      
      private var var_2032:int = 0;
      
      private var var_269:BadgeLayerOptions;
      
      private var var_853:class_1812;
      
      private var var_1469:ColorGridCtrl;
      
      private var _disposed:Boolean = false;
      
      private var var_3828:BitmapData;
      
      private var var_1765:class_2251;
      
      private var var_3000:class_1775;
      
      private var var_2594:class_1812;
      
      private var var_1362:class_2251;
      
      private var var_2027:class_2251;
      
      public function BadgeLayerCtrl(param1:HabboGroupsManager, param2:BadgeEditorCtrl, param3:int)
      {
         super();
         var_52 = param1;
         var_283 = param2;
         var_2032 = param3;
         var_269 = new BadgeLayerOptions();
         var_269.layerIndex = param3;
         var_3828 = var_52.getButtonImage("badge_part_add");
      }
      
      public function createWindow() : void
      {
         if(var_853 != null)
         {
            return;
         }
         var _loc1_:IItemListWindow = var_283.partEditContainer.findChildByName(PARENT_CONTAINER_NAME) as IItemListWindow;
         var_853 = var_52.getXmlWindow("badge_layer") as class_1812;
         var _loc2_:class_1812 = var_853.findChildByName("preview_container") as class_1812;
         var_1765 = _loc2_.findChildByName("part_preview") as class_2251;
         var_1765.bitmap = var_52.getButtonImage("badge_part_add");
         var_3000 = _loc2_.findChildByName("part_button") as class_1775;
         var_3000.procedure = onPartPreviewButtonClick;
         var_2594 = var_853.findChildByName("position_container") as class_1812;
         var_1362 = var_2594.findChildByName("position_picker") as class_2251;
         var_1362.bitmap = var_52.getButtonImage("position_picker");
         var_2027 = var_2594.findChildByName("position_grid") as class_2251;
         var_2027.bitmap = var_52.getButtonImage("position_grid");
         if(var_2032 == 0)
         {
            var_2027.visible = false;
            var_1362.visible = false;
         }
         else
         {
            var_2027.procedure = onPositionGridClick;
         }
         var_1469 = new ColorGridCtrl(var_52,onColorSelected);
         var_1469.createAndAttach(var_853,"color_selector",var_52.guildEditorData.badgeColors);
         if(var_269.layerIndex == BASE_LAYER_INDEX)
         {
            _loc1_.addListItem(var_853);
         }
         else
         {
            _loc1_.addListItemAt(var_853,0);
         }
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            if(var_1469)
            {
               var_1469.dispose();
               var_1469 = null;
            }
            if(var_853)
            {
               var_853.dispose();
               var_853 = null;
            }
            var_1765 = null;
            var_3000 = null;
            var_2594 = null;
            var_1362 = null;
            var_2027 = null;
            var_52 = null;
            _disposed = true;
         }
      }
      
      public function setLayerOptions(param1:BadgeLayerOptions) : void
      {
         if(param1.layerIndex != var_269.layerIndex)
         {
            throw new Error("Tried to set layer option with invalid layerIndex value");
         }
         var _loc3_:BadgeLayerOptions = var_269;
         var_269 = param1.clone();
         if(!var_269.isGridEqual(_loc3_))
         {
            updatePositionPicker(false);
            var _loc2_:Boolean = true;
         }
         if(_loc3_.colorIndex != var_269.colorIndex)
         {
            var_1469.setSelectedColorIndex(var_269.colorIndex,false);
            var_269.colorIndex = var_1469.selectedColorIndex;
            _loc2_ = true;
         }
         if(_loc3_.partIndex != var_269.partIndex)
         {
            updateSelectedPart();
         }
      }
      
      public function get layerOptions() : BadgeLayerOptions
      {
         return var_269;
      }
      
      public function updateSelectedPart() : void
      {
         var _loc1_:BitmapData = null;
         if(var_283.badgeSelectPartCtrl)
         {
            _loc1_ = var_283.badgeSelectPartCtrl.getPartItemImage(layerOptions);
         }
         if(_loc1_ == null)
         {
            _loc1_ = var_3828;
         }
         var_1765.bitmap.dispose();
         var_1765.bitmap = new BitmapData(_loc1_.width,_loc1_.height);
         var_1765.bitmap.copyPixels(_loc1_,_loc1_.rect,new Point());
         var_283.onPartChanged(this);
      }
      
      private function updatePositionPicker(param1:Boolean = true) : void
      {
         var_1362.x = var_269.gridX * 14 + 1;
         var_1362.y = var_269.gridY * 14 + 1;
         if(param1)
         {
            updateSelectedPart();
         }
      }
      
      private function onPositionGridClick(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type != "WME_CLICK" || !var_1362)
         {
            return;
         }
         var _loc3_:WindowMouseEvent = param1 as WindowMouseEvent;
         var_269.gridX = Math.min(2,Math.max(0,Math.floor(_loc3_.localX / 14)));
         var_269.gridY = Math.min(2,Math.max(0,Math.floor(_loc3_.localY / 14)));
         updatePositionPicker();
      }
      
      private function onPartPreviewButtonClick(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         var_283.onShowSelectPart(this);
      }
      
      public function onColorSelected(param1:ColorGridCtrl) : void
      {
         if(var_269.colorIndex != param1.selectedColorIndex)
         {
            var_269.colorIndex = param1.selectedColorIndex;
            updateSelectedPart();
         }
      }
   }
}

