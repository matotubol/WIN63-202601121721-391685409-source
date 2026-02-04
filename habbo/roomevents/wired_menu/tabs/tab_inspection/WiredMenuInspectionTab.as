package com.sulake.habbo.roomevents.wired_menu.tabs.tab_inspection
{
   import com.sulake.core.runtime.class_31;
   import com.sulake.core.utils.class_55;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_1775;
   import com.sulake.core.window.components.class_1885;
   import com.sulake.core.window.components.class_1993;
   import com.sulake.core.window.components.class_2143;
   import com.sulake.core.window.components.class_2872;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.wiredmenu.class_2823;
   import com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.wiredmenu.class_3188;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredmenu.class_3781;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.Util;
   import com.sulake.habbo.roomevents.wired_menu.WiredMenuController;
   import com.sulake.habbo.roomevents.wired_menu.tabs.WiredMenuDefaultTab;
   import com.sulake.habbo.roomevents.wired_menu.tabs.common.VariableTypePicker;
   import com.sulake.habbo.roomevents.wired_menu.tabs.tab_variable_overview.VariableHoldersHighlighter;
   import com.sulake.habbo.roomevents.wired_setup.common.class_4050;
   import com.sulake.habbo.roomevents.wired_setup.inputsources.WiredInputSourcePicker;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.newvariablepicker.NewVariablePicker;
   import com.sulake.habbo.window.utils.tableview.ITableObject;
   import com.sulake.habbo.window.utils.tableview.TableColumn;
   import com.sulake.habbo.window.utils.tableview.TableView;
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   import package_188.VariableList;
   import package_189.WiredVariable;
   import package_97.WiredObjectInspectionData;
   import package_97.class_2755;
   import package_97.class_3336;
   
   public class WiredMenuInspectionTab extends WiredMenuDefaultTab implements class_31
   {
      
      private static var POLL_VARIABLES_MS:uint = 500;
      
      private static var STATE_NOTHING:int = 0;
      
      private static var STATE_FETCHING_HOLDING_VARIABLES:int = 1;
      
      private static var STATE_AWAITING_VARIABLES:int = 2;
      
      private static var STATE_DISPLAYING:int = 3;
      
      public static var VARIABLES_COLUMN_VARIABLE:String = "variable";
      
      public static var VARIABLES_COLUMN_VALUE:String = "value";
      
      private var var_468:TableView;
      
      private var var_371:VariableTypePicker;
      
      private var var_994:VariableHolderPreviewer;
      
      private var var_61:int = STATE_NOTHING;
      
      private var var_4210:int = 0;
      
      private var var_1448:Dictionary = new Dictionary();
      
      private var var_24:WiredObjectInspectionData = null;
      
      private var var_4986:int = -1;
      
      private var var_4378:int = 0;
      
      private var _highlightingForFurni:int = -1;
      
      private var _highlighter:VariableHoldersHighlighter;
      
      private var var_2492:int = -1;
      
      private var var_1278:NewVariablePicker;
      
      public function WiredMenuInspectionTab(param1:WiredMenuController, param2:class_1812)
      {
         super(param1,param2);
         _highlighter = new VariableHoldersHighlighter(param1.roomEvents);
         var_468 = new TableView(param1.windowManager,variableValuesTableContainer);
         var_371 = new VariableTypePicker(typePickerContainer,onSelectVariableType);
         var_994 = new VariableHolderPreviewer(previewContainer,param1);
         createVariableValuesTable();
         createCreateVariableBubble();
         updateTableUI();
         updatePreviewUI();
         addMessageEvent(new class_2755(onWiredVariablesForObject));
         addMessageEvent(new class_3336(onWiredMenuError));
         highlightWiredButton.addEventListener("WME_CLICK",onHighlightWiredsClicked);
         deleteVariableButton.addEventListener("WME_CLICK",onDeleteVariableClicked);
         addVariableButton.addEventListener("WME_CLICK",onAddVariableClicked);
         createVariableButton.addEventListener("WME_CLICK",onCreateVariableClicked);
         param2.procedure = windowProcedure;
      }
      
      private function createVariableValuesTable() : void
      {
         var _loc1_:Array = [new TableColumn(VARIABLES_COLUMN_VARIABLE,loc("wiredmenu.inspection.variables.variable"),0.65,"left"),new TableColumn(VARIABLES_COLUMN_VALUE,loc("wiredmenu.inspection.variables.value"),0.35,"right")];
         var_468.initialize(Vector.<TableColumn>(_loc1_));
         var_468.onCellEditCallback = onCellEdit;
         var_468.onRowSelectedCallback = onRowSelected;
      }
      
      private function createCreateVariableBubble() : void
      {
         var _loc1_:HabboUserDefinedRoomEvents = controller.roomEvents;
         var _loc3_:PresetManager = _loc1_.wiredCtrl.presetManager;
         var _loc2_:class_1812 = _loc3_.createLayout("search_tree_dropdown") as class_1812;
         variablePickerContainer.addChild(_loc2_);
         var_1278 = new NewVariablePicker(controller.roomEvents,_loc2_,variableFilter,onChangeCreateVariable);
         var_1278.width = variablePickerContainer.width;
         createVariableBubble.visible = false;
      }
      
      private function onChangeCreateVariable(param1:WiredVariable) : void
      {
         Util.disableSection(valueSettingContainer,param1 != null && !param1.hasValue);
         Util.disableSection(createVariableButton,param1 == null);
      }
      
      private function variableFilter(param1:WiredVariable) : Boolean
      {
         return param1.canCreateAndDelete && (var_24 == null || !var_24.variableValues.hasKey(param1.variableId));
      }
      
      override public function startViewing() : void
      {
         super.startViewing();
         maybePollNewVariables(false);
      }
      
      private function maybePollNewVariables(param1:Boolean = true) : void
      {
         if(var_61 == STATE_DISPLAYING)
         {
            if(!param1)
            {
               var_61 = STATE_FETCHING_HOLDING_VARIABLES;
               updateLoadingState();
            }
            requestVariablesForObject(var_24.type,getObjectIdForType());
         }
      }
      
      private function getObjectIdForType() : int
      {
         if(var_24.type == WiredInputSourcePicker.USER_SOURCE)
         {
            return var_24.userIndex;
         }
         if(var_24.type == WiredInputSourcePicker.var_128)
         {
            return var_24.objectId;
         }
         return 0;
      }
      
      override protected function isDataReady() : Boolean
      {
         return var_61 == STATE_NOTHING || var_61 == STATE_DISPLAYING;
      }
      
      private function clearDataAndState() : void
      {
         var_61 = STATE_NOTHING;
         var _loc1_:WiredObjectInspectionData = var_24;
         var_24 = null;
         onDataChanged(_loc1_,null);
         updateTableUI();
      }
      
      private function onCellEdit(param1:ITableObject, param2:String, param3:String) : void
      {
         if(param2 != VARIABLES_COLUMN_VALUE)
         {
            return;
         }
         var _loc5_:VariableValueTableObject = param1 as VariableValueTableObject;
         var _loc4_:WiredVariable = _loc5_.variable;
         if(!controller.hasWritePermission || !_loc4_.hasValue || !_loc4_.canWriteValue)
         {
            return;
         }
         var _loc6_:int = Util.getIntFromString(param3,-2147483648,true);
         if(_loc6_ != -2147483648)
         {
            controller.send(new class_3188(_loc4_.variableTarget,getObjectIdForType(),_loc4_.variableId,_loc6_,0));
         }
      }
      
      private function onAddVariableClicked(param1:WindowMouseEvent) : void
      {
         if(createVariableBubble.visible)
         {
            createVariableBubble.visible = false;
         }
         else
         {
            controller.roomEvents.variablesSynchronizer.getAllVariables(initializeCreateVariableBubble,true);
         }
      }
      
      private function windowProcedure(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type == "WME_CLICK" && Boolean(createVariableBubble.visible))
         {
            if(param2.name != "add_var_btn" && !createVariableBubble.windowIsChild(param2))
            {
               createVariableBubble.visible = false;
            }
         }
      }
      
      private function initializeCreateVariableBubble(param1:Vector.<WiredVariable>) : void
      {
         var _loc3_:Array = [];
         for each(var _loc2_ in param1)
         {
            _loc3_.push(_loc2_);
         }
         var_1278.init(new VariableList(_loc3_),"",var_371.selectedType);
         Util.disableSection(createVariableButton,true);
         createVariableBubble.visible = true;
      }
      
      private function onDeleteVariableClicked(param1:WindowMouseEvent) : void
      {
         if(var_24 == null)
         {
            return;
         }
         var _loc3_:VariableValueTableObject = var_468.selected as VariableValueTableObject;
         if(_loc3_ == null)
         {
            return;
         }
         var _loc2_:WiredVariable = _loc3_.variable;
         if(!controller.hasWritePermission || !_loc2_.canCreateAndDelete)
         {
            return;
         }
         var_2492 = var_468.getIndexOfObject(_loc3_);
         controller.send(new class_3188(_loc2_.variableTarget,getObjectIdForType(),_loc2_.variableId,0,2));
      }
      
      private function onCreateVariableClicked(param1:WindowMouseEvent) : void
      {
         if(var_24 == null)
         {
            return;
         }
         var _loc2_:WiredVariable = var_1278.selected;
         var_1278.finalize();
         var _loc3_:int = 0;
         if(_loc2_.hasValue)
         {
            _loc3_ = int(valueInput.text);
         }
         controller.send(new class_3188(_loc2_.variableTarget,getObjectIdForType(),_loc2_.variableId,_loc3_,1));
         createVariableBubble.visible = false;
         valueInput.text = "0";
      }
      
      private function onWiredVariablesForObject(param1:class_2755) : void
      {
         if(var_61 != STATE_FETCHING_HOLDING_VARIABLES && var_61 != STATE_DISPLAYING)
         {
            return;
         }
         var _loc3_:WiredObjectInspectionData = param1.getParser().data;
         if(_loc3_.type != var_371.selectedType)
         {
            return;
         }
         var _loc2_:WiredObjectInspectionData = var_24;
         var_24 = _loc3_;
         onDataChanged(_loc2_,var_24);
         var_61 = STATE_AWAITING_VARIABLES;
         if(!controller.variablesSynchronizer.getAllVariables(onAllVariables,!allVariablesAvailable))
         {
            updateLoadingState();
         }
      }
      
      private function onWiredMenuError(param1:class_3336) : void
      {
         var _loc2_:class_3781 = param1.getParser();
         if(_loc2_.errorCode == class_3781.var_5342)
         {
            if(var_61 != STATE_DISPLAYING)
            {
               clearDataAndState();
               updatePreviewUI();
               updateLoadingState();
            }
         }
      }
      
      private function get allVariablesAvailable() : Boolean
      {
         for each(var _loc1_ in var_24.variableValues.getKeys())
         {
            if(!(_loc1_ in var_1448))
            {
               return false;
            }
         }
         return true;
      }
      
      private function updatePreviewUI() : void
      {
         var _loc1_:* = var_371.selectedType == class_4050.GLOBAL_SOURCE;
         Util.disableSection(pinContainer,_loc1_);
         var _loc2_:* = var_371.selectedType == WiredInputSourcePicker.var_128;
         var _loc3_:* = var_371.selectedType == WiredInputSourcePicker.USER_SOURCE;
         Util.disableSection(highlightWiredButton,var_24 == null || var_24.type != WiredInputSourcePicker.var_128 || var_24.configuredInWireds == null || var_24.configuredInWireds.length == 0);
         highlightWiredButton.visible = _loc2_;
         if(_loc1_)
         {
            var_994.setGlobalPlaceholder();
            return;
         }
         if(!_loc2_ && !_loc3_)
         {
            var_994.clearPreviewer();
            return;
         }
         if(var_61 == STATE_NOTHING)
         {
            if(_loc2_)
            {
               var_994.setFurniInstructions();
            }
            else if(_loc3_)
            {
               var_994.setUserInstructions();
            }
         }
         else if(var_61 == STATE_DISPLAYING)
         {
            if(_loc2_)
            {
               var_994.setFurniByObjectId(var_24.objectId);
            }
            else if(_loc3_)
            {
               var_994.setPreviewByUserIndex(var_24.userIndex);
            }
         }
      }
      
      private function onHighlightWiredsClicked(param1:WindowMouseEvent) : void
      {
         _highlighter.clear();
         if(_highlightingForFurni == -1 && var_24 != null && var_24.configuredInWireds != null && var_24.configuredInWireds.length > 0)
         {
            for each(var _loc2_ in var_24.configuredInWireds)
            {
               _highlighter.highlightObject(_loc2_,null);
            }
            _highlightingForFurni = var_24.objectId;
         }
         else
         {
            _highlightingForFurni = -1;
         }
      }
      
      private function onDataChanged(param1:WiredObjectInspectionData, param2:WiredObjectInspectionData) : void
      {
         if(param2 == null)
         {
            clearHighlights();
         }
         if(param2 != null && _highlightingForFurni != -1 && (param2.type != WiredInputSourcePicker.var_128 || param2.objectId != _highlightingForFurni))
         {
            clearHighlights();
         }
         if(param1 == null || param2 == null || param1.type != param2.type || param1.objectId != param2.objectId || param1.userIndex != param2.userIndex)
         {
            createVariableBubble.visible = false;
         }
      }
      
      private function clearHighlights() : void
      {
         _highlighter.clear();
         _highlightingForFurni = -1;
      }
      
      override public function stopViewing() : void
      {
         super.stopViewing();
         clearHighlights();
         createVariableBubble.visible = false;
      }
      
      private function updateTableUI() : void
      {
         var _loc4_:WiredVariable = null;
         var _loc5_:class_55 = null;
         var _loc1_:Array = null;
         var _loc3_:Boolean = false;
         var _loc2_:* = undefined;
         if(var_61 == STATE_NOTHING)
         {
            var_468.clear();
            Util.disableSection(variableValuesTableContainer);
         }
         else if(var_61 == STATE_DISPLAYING)
         {
            if(!variableValuesTableContainer.isEnabled())
            {
               Util.disableSection(variableValuesTableContainer,false);
            }
            _loc5_ = var_24.variableValues;
            _loc1_ = [];
            for each(var _loc6_ in _loc5_.getKeys())
            {
               _loc4_ = var_1448[_loc6_];
               if(_loc4_ != null)
               {
                  _loc1_.push(_loc4_);
               }
            }
            Util.sortVariables(_loc1_);
            _loc3_ = getObjectIdForType() == var_4378 && var_24.type == var_4986;
            _loc2_ = new Vector.<ITableObject>();
            for each(_loc4_ in _loc1_)
            {
               if(!_loc4_.isInvisible)
               {
                  _loc2_.push(new VariableValueTableObject(_loc4_,_loc5_.getValue(_loc4_.variableId),controller.hasWritePermission,_loc3_,controller.roomEvents));
               }
            }
            var_468.setObjects(_loc2_);
            var_4378 = getObjectIdForType();
            var_4986 = var_24.type;
         }
         updateButtonsUI();
      }
      
      private function updateButtonsUI() : void
      {
         var _loc3_:VariableValueTableObject = null;
         var _loc2_:Boolean = false;
         var _loc1_:Boolean = false;
         if(controller.hasWritePermission)
         {
            _loc3_ = var_468.selected as VariableValueTableObject;
            if(var_24 != null && var_24.type != class_4050.GLOBAL_SOURCE)
            {
               if(_loc3_ != null && _loc3_.variable != null && _loc3_.variable.canCreateAndDelete)
               {
                  _loc2_ = true;
               }
               _loc1_ = true;
            }
         }
         Util.disableSection(deleteVariableButton,!_loc2_);
         Util.disableSection(addVariableButton,!_loc1_);
      }
      
      private function onRowSelected(param1:VariableValueTableObject) : void
      {
         var _loc2_:VariableValueTableObject = null;
         updateButtonsUI();
         if(param1 == null && var_2492 != -1)
         {
            _loc2_ = var_468.getObjectByIndex(var_2492) as VariableValueTableObject;
            var_468.trySelect(_loc2_);
            var_2492 = -1;
         }
      }
      
      private function onAllVariables(param1:Vector.<WiredVariable>) : void
      {
         var_1448 = new Dictionary();
         for each(var _loc2_ in param1)
         {
            var_1448[_loc2_.variableId] = _loc2_;
         }
         if(var_61 != STATE_AWAITING_VARIABLES)
         {
            return;
         }
         var_61 = STATE_DISPLAYING;
         updateTableUI();
         updateLoadingState();
         updatePreviewUI();
      }
      
      private function onSelectVariableType(param1:int) : void
      {
         clearDataAndState();
         initializeInterface();
         if(param1 == class_4050.GLOBAL_SOURCE)
         {
            var_61 = STATE_FETCHING_HOLDING_VARIABLES;
            requestVariablesForObject(param1,0);
            updateLoadingState();
         }
         updatePreviewUI();
         updateButtonsUI();
      }
      
      private function requestVariablesForObject(param1:int, param2:int) : void
      {
         var_4210 = getTimer();
         controller.send(new class_2823(param1,param2));
      }
      
      public function inspectFurni(param1:int, param2:Boolean = false) : void
      {
         if(!isViewing)
         {
            return;
         }
         if(pinCheckbox.isSelected && var_61 == STATE_DISPLAYING && !param2)
         {
            return;
         }
         if(param2)
         {
            pinCheckbox.select();
         }
         var _loc3_:* = var_371.selectedType == WiredInputSourcePicker.var_128;
         if(param2 && !_loc3_)
         {
            var_371.selectedType = WiredInputSourcePicker.var_128;
            updatePreviewUI();
         }
         else if(!_loc3_)
         {
            return;
         }
         if(var_371.selectedType == WiredInputSourcePicker.var_128)
         {
            if(var_24 != null && var_24.type == WiredInputSourcePicker.var_128 && var_24.objectId == param1)
            {
               return;
            }
            var_61 = STATE_FETCHING_HOLDING_VARIABLES;
            updateLoadingState();
            requestVariablesForObject(WiredInputSourcePicker.var_128,param1);
         }
      }
      
      public function inspectUser(param1:int, param2:Boolean = false) : void
      {
         if(!isViewing)
         {
            return;
         }
         if(pinCheckbox.isSelected && var_61 == STATE_DISPLAYING && !param2)
         {
            return;
         }
         if(param2)
         {
            pinCheckbox.select();
         }
         var _loc3_:* = var_371.selectedType == WiredInputSourcePicker.USER_SOURCE;
         if(param2 && !_loc3_)
         {
            var_371.selectedType = WiredInputSourcePicker.USER_SOURCE;
            updatePreviewUI();
         }
         else if(!_loc3_)
         {
            return;
         }
         if(var_371.selectedType == WiredInputSourcePicker.USER_SOURCE)
         {
            if(var_24 != null && var_24.type == WiredInputSourcePicker.USER_SOURCE && var_24.userIndex == param1)
            {
               return;
            }
            var_61 = STATE_FETCHING_HOLDING_VARIABLES;
            updateLoadingState();
            requestVariablesForObject(WiredInputSourcePicker.USER_SOURCE,param1);
         }
      }
      
      override public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         controller.variablesSynchronizer.removeListener(onAllVariables);
         var_371.dispose();
         var_371 = null;
         var_468.dispose();
         var_468 = null;
         var_61 = STATE_NOTHING;
         var_1448 = null;
         var_24 = null;
         var_994.dispose();
         var_994 = null;
         _highlighter.dispose();
         _highlighter = null;
         super.dispose();
      }
      
      public function update(param1:uint) : void
      {
         if(!isViewing)
         {
            return;
         }
         var_371.update(param1);
         var _loc2_:int = getTimer();
         if(var_4210 < _loc2_ - POLL_VARIABLES_MS && isDataReady())
         {
            maybePollNewVariables();
         }
         _highlighter.update(param1);
      }
      
      private function get variableValuesTableContainer() : class_1812
      {
         return container.findChildByName("variable_values_table_container") as class_1812;
      }
      
      private function get typePickerContainer() : class_1812
      {
         return container.findChildByName("type_picker_container") as class_1812;
      }
      
      private function get previewContainer() : class_1812
      {
         return container.findChildByName("preview_container") as class_1812;
      }
      
      private function get pinContainer() : class_1812
      {
         return container.findChildByName("pin_option_container") as class_1812;
      }
      
      private function get pinCheckbox() : class_1885
      {
         return container.findChildByName("pin_checkbox") as class_1885;
      }
      
      private function get highlightWiredButton() : class_2143
      {
         return container.findChildByName("highlight_wired_btn") as class_2143;
      }
      
      private function get deleteVariableButton() : class_1775
      {
         return container.findChildByName("delete_var_btn") as class_1775;
      }
      
      private function get addVariableButton() : class_1775
      {
         return container.findChildByName("add_var_btn") as class_1775;
      }
      
      private function get createVariableBubble() : class_2872
      {
         return container.findChildByName("create_var_bubble") as class_2872;
      }
      
      private function get variablePickerContainer() : class_1812
      {
         return createVariableBubble.findChildByName("var_picker_container") as class_1812;
      }
      
      private function get valueInputBorder() : class_1993
      {
         return createVariableBubble.findChildByName("value_input_border") as class_1993;
      }
      
      private function get valueInput() : ITextWindow
      {
         return createVariableBubble.findChildByName("value_input") as ITextWindow;
      }
      
      private function get createVariableButton() : class_1775
      {
         return createVariableBubble.findChildByName("create_var_btn") as class_1775;
      }
      
      private function get variableSettingContainer() : class_1812
      {
         return createVariableBubble.findChildByName("variable_setting") as class_1812;
      }
      
      private function get valueSettingContainer() : class_1812
      {
         return createVariableBubble.findChildByName("value_setting") as class_1812;
      }
   }
}

