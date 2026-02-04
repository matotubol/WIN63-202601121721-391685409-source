package com.sulake.habbo.ui.widget.furniture.dimmer
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IItemGridWindow;
   import com.sulake.core.window.components.ISelectableWindow;
   import com.sulake.core.window.components.ITabButtonWindow;
   import com.sulake.core.window.components.ITabContextWindow;
   import com.sulake.core.window.components.class_1885;
   import com.sulake.core.window.components.class_2251;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.events.class_1758;
   import flash.display.BitmapData;
   import flash.geom.Rectangle;
   
   public class DimmerView
   {
      
      private static const const_428:Number = 100;
      
      private static const const_356:Number = 100;
      
      private var _window:class_1812;
      
      private var _tabContext:ITabContextWindow;
      
      private var _windowXML:XML;
      
      private var var_16:DimmerFurniWidget;
      
      private var var_730:DimmerViewColorGrid;
      
      private var var_840:DimmerViewAlphaSlider;
      
      private var var_2578:int;
      
      private var var_917:int;
      
      private var var_2414:int;
      
      public function DimmerView(param1:DimmerFurniWidget)
      {
         super();
         var_16 = param1;
      }
      
      public function get selectedBrightness() : int
      {
         return var_2578;
      }
      
      public function get selectedColorIndex() : int
      {
         return var_917;
      }
      
      public function get selectedType() : int
      {
         return var_2414;
      }
      
      public function dispose() : void
      {
         hideInterface();
         var_16 = null;
      }
      
      public function showInterface() : void
      {
         if(_window == null)
         {
            createWindow();
         }
         selectPreset(var_16.selectedPresetIndex);
         update();
      }
      
      public function update() : void
      {
         var _loc2_:String = null;
         if(_window == null || var_16 == null)
         {
            return;
         }
         var _loc1_:Boolean = var_16.isOn;
         var _loc3_:class_1741 = _window.findChildByName("on_off_button");
         if(_loc3_ != null)
         {
            _loc2_ = _loc1_ ? "${widget.dimmer.button.off}" : "${widget.dimmer.button.on}";
            _loc3_.caption = _loc2_;
         }
         _loc3_ = _window.findChildByName("tabbedview");
         if(_loc3_ != null)
         {
            _loc3_.visible = _loc1_;
         }
         _loc3_ = _window.findChildByName("apply_button");
         if(_loc3_ != null)
         {
            _loc1_ ? _loc3_.enable() : _loc3_.disable();
         }
         _loc3_ = _window.findChildByName("off_border");
         if(_loc3_)
         {
            _loc3_.visible = !_loc1_;
         }
      }
      
      public function hideInterface() : void
      {
         if(var_16 != null)
         {
            var_16.removePreview();
         }
         if(var_730 != null)
         {
            var_730.dispose();
            var_730 = null;
         }
         if(var_840 != null)
         {
            var_840.dispose();
            var_840 = null;
         }
         _tabContext = null;
         if(_window != null)
         {
            _window.dispose();
            _window = null;
         }
      }
      
      private function createWindow() : void
      {
         if(var_16 == null || var_16.windowManager == null || windowXML == null)
         {
            return;
         }
         _window = var_16.windowManager.createWindow("dimmerui_container","",4,0,0x020000 | 1,new Rectangle(100,100,2,2),null,0) as class_1812;
         _window.buildFromXML(windowXML);
         var _loc4_:class_1741 = _window.findChildByTag("close");
         if(_loc4_ != null)
         {
            null.procedure = onWindowClose;
         }
         _loc4_ = _window.findChildByName("color_grid_container");
         if(_loc4_ != null)
         {
            var _loc5_:class_1741 = (null as class_1812).findChildByName("color_grid");
            if(_loc5_ != null)
            {
               var_730 = new DimmerViewColorGrid(this,null as IItemGridWindow,var_16.windowManager,var_16.assets);
            }
         }
         _loc4_ = _window.findChildByName("brightness_container");
         if(_loc4_ != null)
         {
            var_840 = new DimmerViewAlphaSlider(this,null as class_1812,var_16.assets);
         }
         _tabContext = ITabContextWindow(_window.findChildByName("tab_context"));
         selectTab(var_16.selectedPresetIndex);
         var _loc6_:int = 0;
         while(0 < _tabContext.numTabItems)
         {
            var _loc1_:ITabButtonWindow = _tabContext.getTabItemAt(0);
            null.setParamFlag(1,true);
            null.procedure = onTabClick;
            _loc6_++;
         }
         _loc4_ = _window.findChildByName("type_checkbox");
         if(_loc4_ != null)
         {
            null.addEventListener("WME_CLICK",onMouseEvent);
         }
         _loc4_ = _window.findChildByName("apply_button");
         if(_loc4_ != null)
         {
            null.addEventListener("WME_CLICK",onMouseEvent);
         }
         _loc4_ = _window.findChildByName("on_off_button");
         if(_loc4_ != null)
         {
            null.addEventListener("WME_CLICK",onMouseEvent);
         }
         var _loc2_:class_2251 = _window.findChildByName("off_image") as class_2251;
         var _loc7_:BitmapDataAsset = var_16.assets.getAssetByName("dimmer_info") as BitmapDataAsset;
         if(_loc2_ != null && _loc7_ != null)
         {
            _loc2_.bitmap = new BitmapData(_loc2_.width,_loc2_.height);
            var _loc3_:BitmapData = _loc7_.content as BitmapData;
         }
      }
      
      private function onMouseEvent(param1:WindowMouseEvent) : void
      {
         var _loc3_:class_1885 = null;
         var _loc2_:class_1741 = param1.target as class_1741;
         var _loc4_:String;
         switch(_loc4_ = _loc2_.name)
         {
            case "type_checkbox":
               _loc3_ = param1.target as class_1885;
               if(_loc3_ == null)
               {
                  return;
               }
               if(_loc3_.isSelected)
               {
                  selectedType = 2;
               }
               else
               {
                  selectedType = 1;
               }
               var_16.previewCurrentSetting();
               break;
            case "apply_button":
               var_16.storeCurrentSetting(true);
               break;
            case "cancel":
            case "close":
               hideInterface();
               break;
            case "on_off_button":
               var_16.changeRoomDimmerState();
         }
      }
      
      private function onTabClick(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type != "WE_SELECTED")
         {
            return;
         }
         var_16.storeCurrentSetting(false);
         var _loc3_:int = param2.id;
         selectPreset(_loc3_);
      }
      
      private function onWindowClose(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         hideInterface();
      }
      
      private function selectPreset(param1:int) : void
      {
         if(var_16 == null || var_16.presets == null || param1 < 0 || param1 >= var_16.presets.length)
         {
            return;
         }
         var_16.selectedPresetIndex = param1;
         var _loc2_:DimmerFurniWidgetPresetItem = var_16.presets[param1];
         if(_loc2_ == null)
         {
            return;
         }
         selectTab(param1);
         var_2578 = _loc2_.light;
         if(var_840 != null)
         {
            var_840.setValue(var_2578);
         }
         var_917 = colors.indexOf(_loc2_.color);
         if(var_730 != null)
         {
            var_730.setSelectedColorIndex(var_917);
         }
         selectedType = _loc2_.type;
         var_16.previewCurrentSetting();
      }
      
      private function selectTab(param1:int) : void
      {
         if(_tabContext == null)
         {
            return;
         }
         var _loc2_:class_1741 = _tabContext.getTabItemAt(param1);
         if(_loc2_ != null)
         {
            _tabContext.selector.setSelected(_loc2_ as ISelectableWindow);
         }
      }
      
      private function getSelectedTabIndex() : int
      {
         if(_tabContext == null)
         {
            return -1;
         }
         var _loc1_:ISelectableWindow = _tabContext.selector.getSelected();
         return _tabContext.selector.getSelectableIndex(_loc1_);
      }
      
      private function get windowXML() : XML
      {
         if(_windowXML != null)
         {
            return _windowXML;
         }
         if(var_16 == null || var_16.assets == null || var_16.assets.getAssetByName("dimmer_ui") == null)
         {
            return null;
         }
         var _loc1_:XmlAsset = XmlAsset(var_16.assets.getAssetByName("dimmer_ui"));
         _windowXML = XML(_loc1_.content);
         return _windowXML;
      }
      
      public function get colors() : Array
      {
         if(var_16 == null)
         {
            return null;
         }
         return var_16.colors;
      }
      
      public function set selectedType(param1:int) : void
      {
         if(param1 != 1 && param1 != 2)
         {
            return;
         }
         var_2414 = param1;
         var _loc2_:class_1885 = _window.findChildByName("type_checkbox") as class_1885;
         if(_loc2_ != null)
         {
            if(param1 == 2)
            {
               _loc2_.select();
            }
            else
            {
               _loc2_.unselect();
            }
         }
         if(var_840 != null)
         {
            var_840.min = var_16.minLights[param1 - 1];
         }
      }
      
      public function set selectedColorIndex(param1:int) : void
      {
         var_917 = param1;
         if(var_730 != null)
         {
            var_730.setSelectedColorIndex(param1);
         }
         var_16.previewCurrentSetting();
      }
      
      public function set selectedBrightness(param1:int) : void
      {
         var_2578 = param1;
         if(var_840 != null)
         {
            var_840.setValue(param1);
         }
         var_16.previewCurrentSetting();
      }
   }
}

