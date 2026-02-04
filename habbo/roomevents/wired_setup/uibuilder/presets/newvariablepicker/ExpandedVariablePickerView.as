package com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.newvariablepicker
{
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.class_1993;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.newvariablepicker.overview.VariableNode;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.newvariablepicker.overview.VariableNodeListView;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.newvariablepicker.tabbuttons.TabButtonConfig;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.newvariablepicker.tabbuttons.TabButtonConfigs;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.newvariablepicker.tabbuttons.TabButtonView;
   
   public class ExpandedVariablePickerView implements class_13
   {
      
      private var _picker:NewVariablePicker;
      
      private var _window:class_1812;
      
      private var var_3376:IRegionWindow;
      
      private var _overviewTemplate:class_1993;
      
      private var var_1868:Vector.<TabButtonView>;
      
      private var var_2125:TabButtonConfigs;
      
      private var var_500:TabButtonView;
      
      private var var_285:VariableNodeListView;
      
      private var _disposed:Boolean = false;
      
      public function ExpandedVariablePickerView(param1:NewVariablePicker, param2:class_1812)
      {
         super();
         _picker = param1;
         _window = param2;
         var_3376 = buttonList.removeListItemAt(0) as IRegionWindow;
         _overviewTemplate = contentBox.removeChild(contentBox.getChildByName("variable_overview_template")) as class_1993;
         contentBox.removeChild(contentBox.getChildByName("node_template"));
         var_2125 = new TabButtonConfigs(param1);
         var_1868 = new Vector.<TabButtonView>();
         expandedWindow.width = param1.window.width;
         var _loc5_:int = (expandedWindow.width - 3) / var_2125.tabButtons.length;
         var _loc4_:int = _loc5_ % var_2125.tabButtons.length;
         for each(var _loc6_ in var_2125.tabButtons)
         {
            var _loc7_:int = 0;
            if(_loc4_ > 0)
            {
               _loc7_ = 0 + 1;
               _loc4_ -= 1;
            }
            var _loc3_:TabButtonView = new TabButtonView(this,_loc6_,_loc5_ + 0);
            var_1868.push(null);
            buttonList.addListItem(null.window);
         }
      }
      
      internal function onHide() : void
      {
         if(var_285 != null)
         {
            contentBox.removeChild(var_285.window);
            var_285.dispose();
            var_285 = null;
         }
      }
      
      internal function onVisible() : void
      {
         loadTab(var_500.tabConfig);
      }
      
      public function get roomEvents() : HabboUserDefinedRoomEvents
      {
         return _picker.roomEvents;
      }
      
      public function tabById(param1:int) : TabButtonView
      {
         for each(var _loc2_ in var_1868)
         {
            if(_loc2_.tabConfig.tabId == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function get selectedTab() : TabButtonView
      {
         return var_500;
      }
      
      public function get activeItemsView() : VariableNodeListView
      {
         return var_285;
      }
      
      public function selectTab(param1:TabButtonView, param2:Boolean = false) : void
      {
         if(var_500 == param1)
         {
            if(param2 && var_500 != null)
            {
               loadTab(var_500.tabConfig);
            }
            return;
         }
         if(var_500 != null)
         {
            var_500.active = false;
            var_500 = null;
         }
         if(param1 != null)
         {
            var_500 = param1;
            var_500.active = true;
            loadTab(var_500.tabConfig);
         }
         _picker.inputField.focus();
      }
      
      public function loadTab(param1:TabButtonConfig) : void
      {
         var _loc2_:* = undefined;
         if(var_285 != null)
         {
            contentBox.removeChild(var_285.window);
            var_285.dispose();
            var_285 = null;
         }
         var _loc3_:VariableNode = param1.filteredVariables();
         if(_loc3_.childrenCount == 0)
         {
            emptyContainer.visible = true;
            contentBox.height = emptyContainer.height;
         }
         else
         {
            _loc2_ = _loc3_.children;
            emptyContainer.visible = false;
            var_285 = new VariableNodeListView(_picker,_loc2_,contentBox.width,true);
            contentBox.addChild(var_285.window);
            contentBox.height = var_285.window.height;
         }
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         buttonList.removeListItems();
         for each(var _loc1_ in var_1868)
         {
            _loc1_.dispose();
         }
         if(var_285 != null)
         {
            var_285.dispose();
            var_285 = null;
         }
         var_1868 = null;
         _picker = null;
         _window = null;
         var_3376 = null;
         var_2125 = null;
         var_500 = null;
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get tabButtonTemplate() : IRegionWindow
      {
         return var_3376;
      }
      
      public function get overviewTemplate() : class_1993
      {
         return _overviewTemplate;
      }
      
      private function get buttonList() : IItemListWindow
      {
         return _window.findChildByName("button_list") as IItemListWindow;
      }
      
      private function get expandedWindow() : class_1993
      {
         return _window.findChildByName("expanded_view") as class_1993;
      }
      
      private function get contentBox() : class_1812
      {
         return _window.findChildByName("content_box") as class_1812;
      }
      
      private function get emptyContainer() : class_1812
      {
         return _window.findChildByName("empty_container") as class_1812;
      }
      
      public function get window() : class_1812
      {
         return _window;
      }
   }
}

