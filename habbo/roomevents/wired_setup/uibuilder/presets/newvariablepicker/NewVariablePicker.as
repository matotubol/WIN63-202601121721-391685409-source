package com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.newvariablepicker
{
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_1993;
   import com.sulake.core.window.events.WindowKeyboardEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.newvariablepicker.overview.VariableNode;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.newvariablepicker.overview.VariableNodeListView;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.newvariablepicker.tabbuttons.TabButtonConfigs;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.newvariablepicker.tabbuttons.TabButtonView;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import package_188.class_3414;
   import package_189.WiredVariable;
   import package_189.class_4013;
   
   public class NewVariablePicker implements class_13
   {
      
      public static var UNSPECIFIED_TYPE:int = 2147483647;
      
      private var _disposed:Boolean = false;
      
      private var _roomEvents:HabboUserDefinedRoomEvents;
      
      private var _container:class_1812;
      
      private var var_1169:class_1812;
      
      private var var_2737:IRegionWindow;
      
      private var _isExpanded:Boolean = false;
      
      private var var_1963:Function;
      
      private var var_2534:Function;
      
      private var var_5201:Boolean = true;
      
      private var var_1453:class_3414;
      
      private var var_1740:Vector.<WiredVariable>;
      
      private var _selected:WiredVariable;
      
      private var var_1252:int;
      
      private var var_1895:Dictionary;
      
      private var var_5040:String;
      
      private var var_932:Boolean;
      
      private var var_234:ExpandedVariablePickerView = null;
      
      public function NewVariablePicker(param1:HabboUserDefinedRoomEvents, param2:class_1812, param3:Function = null, param4:Function = null)
      {
         super();
         _roomEvents = param1;
         _container = param2;
         var_1963 = param3;
         var_2534 = param4;
         var_1895 = new Dictionary();
         var_2737 = _container.findChildByName("input_field_region") as IRegionWindow;
         var_1169 = _container.findChildByName("expanded_view_wrapper") as class_1812;
         var_1169.desktop.addChild(var_1169);
         var_1169.visible = false;
         inputFieldRegion.addEventListener("WME_CLICK",onTextRegionClick);
         inputField.addEventListener("WME_CLICK",onTextRegionClick);
         cancelSearchButton.addEventListener("WME_CLICK",onCancelSearch);
         inputField.addEventListener("WE_CHANGE",onChangeQuery);
         inputField.addEventListener("WKE_KEY_UP",onKeyUp);
         inputPlaceholderText.visible = true;
         expandedWindowWrapper.setParamFlag(16,false);
         expandedWindowWrapper.addEventListener("WE_DEACTIVATED",onDeactivate);
         collapseView(true);
      }
      
      public function init(param1:class_3414, param2:String, param3:int) : void
      {
         var_1453 = param1;
         var_1252 = param3;
         var_5040 = param2;
         var_932 = false;
         var_1895 = new Dictionary();
         var_1740 = filteredAllVariables;
         select(findVariableById(param2),true);
         if(var_234 != null)
         {
            var_234.selectTab(var_234.tabById(determineInitialTab()));
         }
      }
      
      public function set variableTarget(param1:int) : void
      {
         if(param1 == var_1252)
         {
            return;
         }
         collapseView();
         updateSelected();
         var_1252 = param1;
         var_1740 = filteredAllVariables;
         if(param1 in var_1895)
         {
            select(var_1895[param1]);
         }
         else
         {
            select(null);
         }
      }
      
      public function get variableTarget() : int
      {
         return var_1252;
      }
      
      private function findVariableById(param1:String) : WiredVariable
      {
         for each(var _loc2_ in var_1740)
         {
            if(_loc2_.variableId == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function get filteredVariables() : Vector.<WiredVariable>
      {
         return var_1740;
      }
      
      public function filteredVariableById(param1:String) : WiredVariable
      {
         for each(var _loc2_ in var_1740)
         {
            if(_loc2_.variableId == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      private function get filteredAllVariables() : Vector.<WiredVariable>
      {
         if(var_1453 == null || var_1453.variables == null)
         {
            return new Vector.<WiredVariable>();
         }
         var _loc1_:Vector.<WiredVariable> = new Vector.<WiredVariable>();
         for each(var _loc2_ in var_1453.variables)
         {
            if((var_1963 == null || var_5201 || var_1963(_loc2_)) && _loc2_.variableName != "" && (_loc2_.variableTarget == var_1252 || var_1252 == UNSPECIFIED_TYPE))
            {
               if(!(_loc2_.isInvisible && var_5040 != _loc2_.variableId))
               {
                  _loc1_.push(_loc2_);
               }
            }
         }
         return _loc1_;
      }
      
      public function select(param1:WiredVariable, param2:Boolean = false) : void
      {
         collapseView();
         var_1895[var_1252] = param1;
         _selected = param1;
         inputField.text = param1?.variableName;
         updatePlaceholder();
         if(!param2 && var_2534 != null)
         {
            var_2534(param1);
         }
         var_932 = false;
      }
      
      public function get expandedView() : ExpandedVariablePickerView
      {
         return var_234;
      }
      
      private function updateSelected() : void
      {
         var _loc1_:WiredVariable = filteredVariableByDisplayName(inputField.text);
         if(_loc1_ != null && _selected != _loc1_)
         {
            select(_loc1_);
         }
         if(inputField.text == "" && _selected != null)
         {
            select(null);
         }
      }
      
      public function get selected() : WiredVariable
      {
         updateSelected();
         return _selected;
      }
      
      public function finalize() : void
      {
         updateSelected();
         if(_selected != null)
         {
            _roomEvents.variablePickerHelper.addToHistory(_selected);
         }
      }
      
      private function collapseView(param1:Boolean = false) : void
      {
         if(!_isExpanded && !param1)
         {
            return;
         }
         _isExpanded = false;
         collapsedView.visible = true;
         expandedWindowWrapper.visible = false;
         expandedWindowWrapper.deactivate();
         moveInputField(searchWrapperCollapsed);
         if(var_234 != null)
         {
            var_234.onHide();
         }
      }
      
      private function expandView() : void
      {
         if(_isExpanded)
         {
            return;
         }
         _isExpanded = true;
         collapsedView.visible = false;
         var _loc1_:Point = new Point();
         _container.getGlobalPosition(_loc1_);
         _loc1_.y -= searchWrapperExpanded.y;
         expandedWindowWrapper.setGlobalPosition(_loc1_);
         expandedWindowWrapper.visible = true;
         expandedWindowWrapper.activate();
         moveInputField(searchWrapperExpanded);
         inputField.focus();
         showExpand();
         var_932 = false;
      }
      
      private function showExpand() : void
      {
         if(var_234 != null)
         {
            var_234.onVisible();
            return;
         }
         var_234 = new ExpandedVariablePickerView(this,expandedWindowWrapper);
         var_234.selectTab(var_234.tabById(determineInitialTab()));
      }
      
      private function determineInitialTab() : int
      {
         if(_selected == null)
         {
            return TabButtonConfigs.USER_CREATED_TAB_ID;
         }
         if(_selected.variableType == class_4013.var_5280)
         {
            return TabButtonConfigs.var_5198;
         }
         if(_selected.variableType == class_4013.INTERNAL)
         {
            return TabButtonConfigs.INTERNAL_TAB_ID;
         }
         return TabButtonConfigs.USER_CREATED_TAB_ID;
      }
      
      private function moveInputField(param1:class_1812) : void
      {
         class_1812(inputFieldRegion.parent).removeChild(inputFieldRegion);
         param1.addChild(inputFieldRegion);
         inputFieldRegion.width = param1.width;
         inputFieldRegion.height = param1.height;
      }
      
      private function onDeactivate(param1:class_1758) : void
      {
         var _loc2_:WiredVariable = null;
         if(var_932)
         {
            _loc2_ = filteredVariableByDisplayName(inputField.text);
            if(_loc2_ != null)
            {
               select(_loc2_);
            }
            else
            {
               select(_selected);
            }
            var_932 = false;
         }
         collapseView();
      }
      
      private function filteredVariableByDisplayName(param1:String) : WiredVariable
      {
         var _loc2_:String = null;
         for each(var _loc3_ in var_1740)
         {
            if(!(var_1963 != null && !var_1963(_loc3_)))
            {
               if(_loc3_.variableName.toLowerCase() == param1.toLowerCase())
               {
                  return _loc3_;
               }
               _loc2_ = _loc3_.variableName;
               if(param1.toLowerCase() == _loc2_.toLowerCase())
               {
                  return _loc3_;
               }
            }
         }
         return null;
      }
      
      private function onKeyUp(param1:WindowKeyboardEvent) : void
      {
         var _loc4_:WiredVariable = null;
         var _loc3_:TabButtonView = null;
         var _loc5_:VariableNodeListView = null;
         var _loc2_:VariableNode = null;
         if(param1.keyCode == 27)
         {
            collapseView();
         }
         else if(param1.keyCode == 13)
         {
            _loc4_ = filteredVariableByDisplayName(inputField.text);
            if(_loc4_ != null)
            {
               select(_loc4_);
               return;
            }
            if(inputField.text == "")
            {
               select(null);
               return;
            }
            if(var_234 != null && _isExpanded)
            {
               _loc3_ = var_234.selectedTab;
               if(_loc3_ != null && _loc3_.tabConfig.tabId == TabButtonConfigs.var_4534)
               {
                  _loc5_ = var_234.activeItemsView;
                  if(_loc5_ != null && _loc5_.childNodes.length >= 1)
                  {
                     _loc2_ = _loc5_.childNodes[0].variableNode;
                     if(_loc2_.variable != null && _loc2_.canBeSelected(this))
                     {
                        select(_loc2_.variable);
                     }
                  }
                  else
                  {
                     select(null);
                  }
               }
            }
         }
      }
      
      private function onChangeQuery(param1:class_1758) : void
      {
         if(_isExpanded && var_234 != null)
         {
            var_234.selectTab(var_234.tabById(TabButtonConfigs.var_4534),true);
         }
         updatePlaceholder();
         var_932 = true;
      }
      
      private function updatePlaceholder() : void
      {
         cancelSearchButton.visible = inputField.text.length > 0;
         inputPlaceholderText.visible = inputField.text.length == 0;
      }
      
      private function onTextRegionClick(param1:WindowMouseEvent) : void
      {
         inputField.focus();
         expandView();
      }
      
      private function onCancelSearch(param1:WindowMouseEvent) : void
      {
         inputField.text = "";
         select(null);
         updatePlaceholder();
         inputField.focus();
         expandView();
      }
      
      public function get showFilteredVariables() : Boolean
      {
         return var_5201;
      }
      
      public function get variableFilter() : Function
      {
         return var_1963;
      }
      
      public function get roomEvents() : HabboUserDefinedRoomEvents
      {
         return _roomEvents;
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         if(var_234 != null)
         {
            var_1169.desktop.removeChild(var_1169);
            var_234.dispose();
            var_234 = null;
         }
         _container = null;
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function set width(param1:int) : void
      {
         _container.width = param1;
      }
      
      public function get window() : class_1812
      {
         return _container;
      }
      
      private function get collapsedView() : class_1993
      {
         return _container.findChildByName("collapsed_view") as class_1993;
      }
      
      private function get expandedWindowWrapper() : class_1812
      {
         return var_1169;
      }
      
      private function get inputFieldRegion() : IRegionWindow
      {
         return var_2737;
      }
      
      private function get inputPlaceholderText() : ITextWindow
      {
         return var_2737.findChildByName("input_placeholder_text") as ITextWindow;
      }
      
      public function get inputField() : ITextFieldWindow
      {
         return var_2737.findChildByName("input_field") as ITextFieldWindow;
      }
      
      private function get searchWrapperCollapsed() : class_1812
      {
         return _container.findChildByName("search_wrapper_collapsed") as class_1812;
      }
      
      private function get searchWrapperExpanded() : class_1812
      {
         return var_1169.findChildByName("search_wrapper_expanded") as class_1812;
      }
      
      private function get cancelSearchButton() : IRegionWindow
      {
         return var_1169.findChildByName("cancel_search") as IRegionWindow;
      }
   }
}

